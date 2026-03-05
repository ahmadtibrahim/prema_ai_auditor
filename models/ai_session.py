# FILE: /opt/odoo/custum-addons/prema_ai_auditor/models/ai_session.py
"""
Prema AI Session — OpenAI GPT integration with configurable models.

TASKS COVERED:
 1. All previous AI provider references removed
 2. OpenAI chat/completions endpoint
 3. Model configuration via system parameters
 4. Model selection (primary / fast / vision)
11. Updated system prompt with tools and approval rules
"""

import json
import logging

import requests
from dateutil.relativedelta import relativedelta
from odoo import api, fields, models
from odoo.exceptions import UserError

_logger = logging.getLogger(__name__)

# ─── Default models (overridden by system parameters) ───────────────
DEFAULT_PRIMARY_MODEL = "gpt-5.3"
DEFAULT_FAST_MODEL = "gpt-5.2"
DEFAULT_VISION_MODEL = "gpt-4o"


class PremaAISession(models.Model):
    _name = "prema.ai.session"
    _description = "Prema AI Session"

    name = fields.Char(string="Session Name", default="AI Chat")
    user_id = fields.Many2one(
        "res.users", default=lambda self: self.env.user, ondelete="cascade",
    )
    message_ids = fields.One2many(
        "prema.ai.message", "session_id", string="Messages", order="create_date asc",
    )
    last_attachment_id = fields.Many2one(
        "prema.ai.attachment", string="Last Attachment",
    )
    model_mode = fields.Selection([
        ("primary", "Primary"),
        ("fast", "Fast"),
        ("vision", "Vision"),
    ], default="primary", string="AI Model Mode")

    # ─── Session management ─────────────────────────────────────────
    @api.model
    def list_sessions(self):
        sessions = self.search(
            [("user_id", "=", self.env.user.id)], order="create_date desc",
        )
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

    # ─── Messaging API ──────────────────────────────────────────────
    def send_message(self, message):
        """
        Called via RPC.  Intercepts bill-creation commands before calling OpenAI.
        """
        self.ensure_one()
        msg = (message or "").strip()
        if not msg:
            return ""

        # Store user message
        self.env["prema.ai.message"].create({
            "session_id": self.id,
            "role": "user",
            "content": msg,
        })

        lower = msg.lower()

        # ── Intercept bill creation commands ────────────────────────
        create_cmds = (
            "create the draft", "create draft", "create bill",
            "create vendor bill", "make the draft", "make draft",
            "confirm create draft",
        )
        if any(c in lower for c in create_cmds):
            att = self.last_attachment_id
            if not att:
                assistant_reply = (
                    "No attachment found for this chat. "
                    "Upload a file first, then type 'create the draft'."
                )
            else:
                result = (
                    self.env["prema.ai.attachment"]
                    .sudo()
                    .process_attachment_by_id(att.id, confirmed=True)
                )
                assistant_reply = self._format_process_result(result)

            self.env["prema.ai.message"].create({
                "session_id": self.id,
                "role": "assistant",
                "content": assistant_reply,
            })
            return assistant_reply

        # ── Default: OpenAI call ────────────────────────────────────
        assistant_reply = self._call_openai(mode=self.model_mode or "primary")
        self.env["prema.ai.message"].create({
            "session_id": self.id,
            "role": "assistant",
            "content": assistant_reply,
        })

        # ── Log the action ──────────────────────────────────────────
        self._log_ai_action("chat_message", "prema.ai.session", self.id, msg[:120])

        return assistant_reply

    # ─── Result formatter ───────────────────────────────────────────
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

    # ─── Model resolution ───────────────────────────────────────────
    def _resolve_model(self, mode="primary"):
        """TASK 3 & 4: Read model name from system parameters."""
        param = self.env["ir.config_parameter"].sudo()
        if mode == "fast":
            return param.get_param("prema_ai.fast_model", DEFAULT_FAST_MODEL)
        elif mode == "vision":
            return param.get_param("prema_ai.vision_model", DEFAULT_VISION_MODEL)
        else:
            return param.get_param("prema_ai.primary_model", DEFAULT_PRIMARY_MODEL)

    # ─── TASK 11: System prompt ─────────────────────────────────────
    def _build_system_prompt(self):
        """Full system prompt describing tools, rules, and approval."""

        # Fetch correction memory for context
        memory = ""
        try:
            memory = self.env["prema.ai.correction"].build_memory_prompt(
                context_type=None, tags=None,
            )
        except Exception:
            pass

        prompt = f"""You are Prema AI — an intelligent ERP assistant running inside Odoo 18 Enterprise.

EXECUTION MODE: EXECUTE_WITH_APPROVAL
• You MUST ask the user for confirmation before creating, updating, or deleting any record.
• Read-only queries (search, list, analyze) can be answered immediately.
• Never delete records automatically.

AVAILABLE TOOLS (you can suggest these actions):
─ find_stale_leads — find CRM leads with no activity in 30+ days
─ show_overdue_tasks — list project tasks past their deadline
─ find_old_tickets — find helpdesk tickets open for 14+ days
─ find_unbilled_orders — sales orders confirmed but not yet invoiced
─ find_duplicate_expenses — expenses with same amount/date/employee
─ check_duplicate_bills — vendor bills with same vendor/amount/date
─ financial_summary — total income, expenses, balance
─ crm_pipeline_analysis — CRM pipeline stages and expected revenue
─ revenue_forecast — 6-month revenue projection
─ generate_email_template — draft an email template
─ generate_website_content — draft website page content
─ build_document_packet — organize documents into a named folder
─ system_audit — run a full system scan (accounts, security, logistics)
─ list_modules — list installed Odoo modules with status
─ check_module_health — check a specific module for issues
─ check_cron_jobs — review scheduled actions and their status

RESPONSE RULES:
1. Be concise and actionable.
2. For read-only queries, respond with data immediately.
3. For record-modifying actions, show a PREVIEW first and ask for approval.
4. If the user uploads a PDF/image, the system extracts data automatically.
   Then the user says "create draft" to create the bill.
5. Format numbers with appropriate currency symbols.
6. When suggesting fixes, explain what will change before asking for approval.

{memory}
"""
        return prompt.strip()

    # ─── TASK 2: OpenAI API call ────────────────────────────────────
    def _call_openai(self, mode="primary"):
        """Call OpenAI chat/completions endpoint."""
        self.ensure_one()

        api_key = (
            self.env["ir.config_parameter"]
            .sudo()
            .get_param("openai.api_key")
        )
        if not api_key:
            return (
                "⚠ OpenAI API key is missing. "
                "Please set system parameter: openai.api_key"
            )

        model = self._resolve_model(mode)
        system_prompt = self._build_system_prompt()

        messages = [{"role": "system", "content": system_prompt}]
        for msg in self.message_ids:
            role = msg.role if msg.role in ("user", "assistant", "system") else "user"
            messages.append({"role": role, "content": msg.content or ""})

        try:
            response = requests.post(
                "https://api.openai.com/v1/chat/completions",
                headers={
                    "Authorization": f"Bearer {api_key}",
                    "Content-Type": "application/json",
                },
                json={
                    "model": model,
                    "messages": messages,
                    "temperature": 0.2,
                    "max_tokens": 2000,
                },
                timeout=90,
            )
            response.raise_for_status()
            data = response.json()
            return (data["choices"][0]["message"]["content"] or "").strip()

        except requests.exceptions.Timeout:
            _logger.error("OpenAI API timeout (model=%s)", model)
            return "⚠ OpenAI request timed out. Please try again."
        except requests.exceptions.HTTPError as e:
            _logger.error("OpenAI HTTP error: %s — %s", e, e.response.text if e.response else "")
            return f"⚠ OpenAI error: {e}"
        except Exception as e:
            _logger.error("OpenAI unexpected error: %s", e)
            return f"⚠ AI error: {e}"

    # ─── Tool registry ──────────────────────────────────────────────
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
        income = self.env["account.move"].search(
            [("move_type", "=", "out_invoice")]
        ).mapped("amount_total")
        expense = self.env["account.move"].search(
            [("move_type", "=", "in_invoice")]
        ).mapped("amount_total")
        return {
            "total_income": sum(income),
            "total_expenses": sum(expense),
            "balance": sum(income) - sum(expense),
        }

    def _tool_crm_pipeline_analysis(self):
        stages = self.env["crm.stage"].search([])
        result = []
        for stage in stages:
            leads = self.env["crm.lead"].search([("stage_id", "=", stage.id)])
            result.append({
                "stage": stage.name,
                "count": len(leads),
                "expected_revenue": sum(leads.mapped("expected_revenue")),
            })
        return result

    def _tool_revenue_forecast(self):
        from datetime import date
        today = date.today()
        forecast = []
        for i in range(6):
            month_start = today.replace(day=1) + relativedelta(months=i)
            month_end = month_start + relativedelta(months=1, days=-1)
            invoices = self.env["account.move"].search([
                ("move_type", "=", "out_invoice"),
                ("invoice_date", ">=", month_start),
                ("invoice_date", "<=", month_end),
            ])
            forecast.append({
                "month": month_start.strftime("%Y-%m"),
                "projected_revenue": sum(invoices.mapped("amount_total")),
            })
        return forecast

    # ─── TASK 14: Action logging helper ─────────────────────────────
    def _log_ai_action(self, action_type, model, record_id, summary):
        try:
            self.env["prema.ai.audit.log"].sudo().create({
                "user_id": self.env.user.id,
                "action_type": action_type,
                "model": model or "",
                "record_id": record_id or 0,
                "summary": summary or "",
                "status": "completed",
            })
        except Exception as e:
            _logger.warning("Failed to log AI action: %s", e)
