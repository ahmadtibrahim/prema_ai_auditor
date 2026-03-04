# FILE: /opt/odoo/custum-addons/prema_ai_auditor/models/ai_session.py
# NOTE: replace existing content with this entire file.
#
# COMMIT NOTE (what changed)
# fix(openai): switch from /v1/responses to /v1/chat/completions to eliminate 400 errors
# - Endpoint: /v1/responses -> /v1/chat/completions
# - Body: input -> messages
# - Parse: output[0]... -> choices[0].message.content
# - Model: gpt-5-mini -> gpt-4o-mini (compatible default)
#
# feat(session): remember last uploaded attachment + auto-create draft without asking for ID
# - Added last_attachment_id (Many2one to prema.ai.attachment)
# - send_message() intercepts "create draft/create bill" BEFORE any OpenAI call
# - Fixed missing relativedelta import (was crashing _tool_revenue_forecast)

from odoo import api, fields, models
from odoo.exceptions import UserError
from dateutil.relativedelta import relativedelta
import requests


class PremaAISession(models.Model):
    _name = "prema.ai.session"
    _description = "Prema AI Session"

    name = fields.Char(string="Session Name", default="AI Chat")
    user_id = fields.Many2one("res.users", default=lambda self: self.env.user, ondelete="cascade")
    message_ids = fields.One2many(
        "prema.ai.message", "session_id", string="Messages", order="create_date asc"
    )

    # remember last uploaded attachment for this chat
    last_attachment_id = fields.Many2one("prema.ai.attachment", string="Last Attachment")

    # -------------------------------------------------------------------------
    # Session management
    # -------------------------------------------------------------------------
    @api.model
    def list_sessions(self):
        sessions = self.search([("user_id", "=", self.env.user.id)], order="create_date desc")
        return sessions.read(["id", "name"])

    @api.model
    def create(self, vals):
        if "user_id" not in vals:
            vals["user_id"] = self.env.user.id
        return super().create(vals)

    @api.model
    def rename_session(self, session_id, new_name):
        session = self.browse(session_id)
        if not session.exists():
            raise UserError("Session not found")
        session.name = new_name
        return True

    @api.model
    def delete_session(self, session_id):
        session = self.browse(session_id)
        if not session.exists():
            return False
        session.unlink()
        return True

    # -------------------------------------------------------------------------
    # Messaging API
    # -------------------------------------------------------------------------
    def send_message(self, message):
        """
        Called via RPC on a session record.
        Intercepts bill creation commands BEFORE OpenAI so it never asks for ID.
        """
        self.ensure_one()
        msg = (message or "").strip()
        if not msg:
            return ""

        # store user message
        self.env["prema.ai.message"].create({
            "session_id": self.id,
            "role": "user",
            "content": msg,
        })

        lower = msg.lower()

        # ✅ Intercept bill creation commands (server-side)
        create_cmds = (
            "create the draft",
            "create draft",
            "create bill",
            "create vendor bill",
            "make the draft",
            "make draft",
        )
        if any(c in lower for c in create_cmds):
            att = self.last_attachment_id
            if not att:
                assistant_reply = "No attachment found for this chat. Upload a file first, then type 'create the draft'."
            else:
                result = self.env["prema.ai.attachment"].sudo().process_attachment_by_id(att.id, confirmed=True)
                assistant_reply = self._format_process_result(result)

            self.env["prema.ai.message"].create({
                "session_id": self.id,
                "role": "assistant",
                "content": assistant_reply,
            })
            return assistant_reply

        # default: OpenAI (now fixed to chat/completions)
        assistant_reply = self._call_openai_chat_completions()
        self.env["prema.ai.message"].create({
            "session_id": self.id,
            "role": "assistant",
            "content": assistant_reply,
        })
        return assistant_reply

    def _format_process_result(self, result):
        if not isinstance(result, dict):
            return str(result)

        if result.get("success"):
            msg = (
                "✅ Draft bill created.\n"
                f"- Move ID: {result.get('move_id')}\n"
                f"- Vendor: {result.get('partner')}\n"
                f"- Amount: {result.get('amount')}"
            )
            if result.get("duplicate_warning"):
                msg += f"\n⚠ Duplicate: {result.get('duplicate_warning')}"
            return msg

        if result.get("confirmation_required"):
            return "Confirmation required. Reply: 'confirm create draft'."

        if result.get("error"):
            return f"❌ Draft creation failed: {result.get('error')}"

        return f"⚠ Unexpected response: {result}"

    # -------------------------------------------------------------------------
    # OpenAI call (FIXED)
    # -------------------------------------------------------------------------
    def _call_openai_chat_completions(self):
        self.ensure_one()
        api_key = self.env["ir.config_parameter"].sudo().get_param("openai.api_key")
        if not api_key:
            raise UserError("OpenAI API key is missing (set system parameter openai.api_key)")

        system_text = (
            "You are Prema’s assistant inside Odoo 18. "
            "Be brief and actionable. "
            "Ask for confirmation before creating/updating/deleting records."
        )

        messages = [{"role": "system", "content": system_text}]
        for msg in self.message_ids:
            # map roles safely
            role = msg.role if msg.role in ("user", "assistant", "system") else "user"
            messages.append({"role": role, "content": msg.content or ""})

        try:
            r = requests.post(
                "https://api.openai.com/v1/chat/completions",
                headers={
                    "Authorization": f"Bearer {api_key}",
                    "Content-Type": "application/json",
                },
                json={
                    "model": "gpt-4o-mini",
                    "messages": messages,
                    "temperature": 0.2,
                    "max_tokens": 800,
                },
                timeout=60,
            )
            r.raise_for_status()
            data = r.json()
            return (data["choices"][0]["message"]["content"] or "").strip()
        except Exception as e:
            return f"[OpenAI error] {e}"

    # -------------------------------------------------------------------------
    # Tool registry (unchanged)
    # -------------------------------------------------------------------------
    def _tool_registry(self):
        return {
            "search_records": self._tool_search_records,
            "create_record": self._tool_create_record,
            "update_record": self._tool_update_record,
            "delete_record": self._tool_delete_record,
            "check_duplicate_bills": self._tool_check_duplicate_bills,
            "financial_summary": self._tool_financial_summary,
            "crm_pipeline_analysis": self._tool_crm_pipeline_analysis,
            "revenue_forecast": self._tool_revenue_forecast,
        }

    def _tool_search_records(self, model, domain, fields=None):
        return self.env[model].search_read(domain, fields)

    def _tool_create_record(self, model, values):
        rec = self.env[model].create(values)
        return rec.id

    def _tool_update_record(self, model, record_id, values):
        rec = self.env[model].browse(record_id)
        rec.write(values)
        return True

    def _tool_delete_record(self, model, record_id):
        rec = self.env[model].browse(record_id)
        rec.unlink()
        return True

    def _tool_check_duplicate_bills(self):
        moves = self.env["account.move"].search([("move_type", "=", "in_invoice")])
        duplicates = []
        seen = set()
        for mv in moves:
            key = (mv.partner_id.id, mv.amount_total, mv.invoice_date)
            if key in seen:
                duplicates.append(mv.name)
            else:
                seen.add(key)
        return duplicates

    def _tool_financial_summary(self):
        income = self.env["account.move"].search([("move_type", "=", "out_invoice")]).mapped("amount_total")
        expense = self.env["account.move"].search([("move_type", "=", "in_invoice")]).mapped("amount_total")
        return {"total_income": sum(income), "total_expenses": sum(expense), "balance": sum(income) - sum(expense)}

    def _tool_crm_pipeline_analysis(self):
        leads = self.env["crm.lead"].search([])
        stage_counts = {}
        prob_sum = 0.0
        for ld in leads:
            stage = ld.stage_id.name or "No Stage"
            stage_counts[stage] = stage_counts.get(stage, 0) + 1
            prob_sum += ld.probability or 0.0
        avg_prob = (prob_sum / len(leads)) if leads else 0.0
        return {"stages": stage_counts, "average_probability": avg_prob}

    def _tool_revenue_forecast(self):
        today = fields.Date.today()
        six_months_ago = today - relativedelta(months=6)
        orders = self.env["sale.order"].search([("date_order", ">=", six_months_ago)])
        monthly = {}
        for so in orders:
            month = so.date_order.strftime("%Y-%m")
            monthly[month] = monthly.get(month, 0) + so.amount_total
        if monthly:
            avg_rev = sum(monthly.values()) / len(monthly)
            return {
                "monthly_revenues": monthly,
                "average_monthly_revenue": avg_rev,
                "next_month_forecast": avg_rev,
            }
        return {"monthly_revenues": {}, "average_monthly_revenue": 0.0, "next_month_forecast": 0.0}


class PremaAIMessage(models.Model):
    _name = "prema.ai.message"
    _description = "Prema AI Message"

    session_id = fields.Many2one("prema.ai.session", ondelete="cascade")
    role = fields.Selection([("user", "User"), ("assistant", "Assistant")], required=True)
    content = fields.Text(required=True)
    create_date = fields.Datetime(default=lambda self: fields.Datetime.now())