# FILE: /opt/odoo/custum-addons/prema_ai_auditor/models/ai_session.py
# NOTE: replace existing content with this entire file.
#
# COMMIT NOTE (what changed)
# fix(openai): switch from /v1/chat/completions to /v1/responses for GPT-5 compatibility
# - Endpoint: /v1/chat/completions -> /v1/responses
# - Body: messages -> input, system message -> instructions
# - Parse: choices[0].message.content -> output_text
# - max_tokens -> max_output_tokens
# - Model defaults: gpt-5.3 (primary), gpt-5.2 (fast), gpt-4o (vision)
# - Added _call_openai() with mode param replacing _call_openai_chat_completions()
# - send_message() now calls _call_openai(mode="primary")
#
# ALL OTHER LOGIC UNCHANGED: session management, bill intercept, tools, etc.

from odoo import api, fields, models
from odoo.exceptions import UserError
from dateutil.relativedelta import relativedelta
import logging
import requests

_logger = logging.getLogger(__name__)

DEFAULT_PRIMARY_MODEL = "gpt-5.3"
DEFAULT_FAST_MODEL = "gpt-5.2"
DEFAULT_VISION_MODEL = "gpt-4o"


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

    # model mode selection
    model_mode = fields.Selection([
        ("primary", "Primary"),
        ("fast", "Fast"),
        ("vision", "Vision"),
    ], default="primary", string="AI Model Mode")

    # -------------------------------------------------------------------------
    # Session management (UNCHANGED)
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
    # Messaging API (UNCHANGED logic, only swapped AI call method)
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

        # Intercept bill creation commands (server-side)
        create_cmds = (
            "create the draft",
            "create draft",
            "create bill",
            "create vendor bill",
            "make the draft",
            "make draft",
            "confirm create draft",
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

        # default: OpenAI Responses API
        assistant_reply = self._call_openai(mode=self.model_mode or "primary")
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
    # Model resolution (reads from system parameters)
    # -------------------------------------------------------------------------
    def _resolve_model(self, mode="primary"):
        param = self.env["ir.config_parameter"].sudo()
        if mode == "fast":
            return param.get_param("prema_ai.fast_model", DEFAULT_FAST_MODEL)
        elif mode == "vision":
            return param.get_param("prema_ai.vision_model", DEFAULT_VISION_MODEL)
        else:
            return param.get_param("prema_ai.primary_model", DEFAULT_PRIMARY_MODEL)

    # -------------------------------------------------------------------------
    # System prompt
    # -------------------------------------------------------------------------
    def _build_system_prompt(self):
        memory = ""
        try:
            memory = self.env["prema.ai.correction"].build_memory_prompt(
                context_type=None, tags=None,
            )
        except Exception:
            pass

        prompt = (
            "You are Prema AI — an intelligent ERP assistant running inside Odoo 18 Enterprise.\n\n"
            "EXECUTION MODE: EXECUTE_WITH_APPROVAL\n"
            "- Ask the user for confirmation before creating, updating, or deleting any record.\n"
            "- Read-only queries can be answered immediately.\n"
            "- Never delete records automatically.\n\n"
            "AVAILABLE TOOLS:\n"
            "- find_stale_leads, show_overdue_tasks, find_old_tickets\n"
            "- find_unbilled_orders, find_duplicate_expenses, check_duplicate_bills\n"
            "- financial_summary, crm_pipeline_analysis, revenue_forecast\n"
            "- generate_email_template, build_document_packet, system_audit\n\n"
            "RULES:\n"
            "1. Be concise and actionable.\n"
            "2. Show a PREVIEW for record-modifying actions and ask for approval.\n"
            "3. Format numbers with appropriate currency symbols.\n"
        )
        if memory:
            prompt += f"\n{memory}\n"
        return prompt.strip()

    # -------------------------------------------------------------------------
    # OpenAI Responses API (/v1/responses)
    # -------------------------------------------------------------------------
    def _call_openai(self, mode="primary"):
        """
        Call the OpenAI Responses API.
        GPT-5 models require /v1/responses (not /v1/chat/completions).

        Responses API differences:
        - Endpoint: POST https://api.openai.com/v1/responses
        - Body: "input" (array of messages), "instructions" (system prompt)
        - Response: "output" array → find item type=="message" → content[0].text
        - Convenience: response["output_text"] contains the text directly
        - max_tokens → max_output_tokens
        """
        self.ensure_one()

        api_key = self.env["ir.config_parameter"].sudo().get_param("openai.api_key")
        if not api_key:
            return (
                "⚠ OpenAI API key is missing. "
                "Please set system parameter: openai.api_key"
            )

        model = self._resolve_model(mode)
        instructions = self._build_system_prompt()

        # Build input array from conversation history
        input_messages = []
        for msg in self.message_ids:
            role = msg.role if msg.role in ("user", "assistant") else "user"
            input_messages.append({"role": role, "content": msg.content or ""})

        try:
            response = requests.post(
                "https://api.openai.com/v1/responses",
                headers={
                    "Authorization": f"Bearer {api_key}",
                    "Content-Type": "application/json",
                },
                json={
                    "model": model,
                    "instructions": instructions,
                    "input": input_messages,
                    "temperature": 0.2,
                    "max_output_tokens": 2000,
                    "store": False,
                },
                timeout=90,
            )
            response.raise_for_status()
            data = response.json()

            # Parse response: use output_text convenience field first
            output_text = data.get("output_text")
            if output_text:
                return output_text.strip()

            # Fallback: walk the output array
            for item in data.get("output", []):
                if item.get("type") == "message" and item.get("content"):
                    for block in item["content"]:
                        if block.get("type") == "output_text" and block.get("text"):
                            return block["text"].strip()

            _logger.warning("OpenAI Responses API returned no text in output: %s", data)
            return "⚠ AI returned an empty response. Please try again."

        except requests.exceptions.Timeout:
            _logger.error("OpenAI API timeout (model=%s)", model)
            return "⚠ OpenAI request timed out. Please try again."
        except requests.exceptions.HTTPError as e:
            status = e.response.status_code if e.response is not None else "unknown"
            body = ""
            try:
                body = e.response.text[:500] if e.response is not None else ""
            except Exception:
                pass
            _logger.error("OpenAI HTTP %s error: %s — %s", status, e, body)
            return f"⚠ OpenAI error (HTTP {status}): {body or str(e)}"
        except Exception as e:
            _logger.error("OpenAI unexpected error: %s", e)
            return f"⚠ AI error: {e}"

    # -------------------------------------------------------------------------
    # Tool registry (UNCHANGED)
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
