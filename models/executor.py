# FILE: /opt/odoo/custum-addons/prema_ai_auditor/models/executor.py
"""
TASK 13: AI Task Executor
Flow: read task → verify approved → call tool → record result → log action
"""

import json
import logging

from odoo import api, fields, models

_logger = logging.getLogger(__name__)


class PremaAITask(models.Model):
    _name = "prema.ai.task"
    _description = "Prema AI Task Queue"
    _order = "create_date desc"

    name = fields.Char(required=True)
    session_id = fields.Many2one("prema.ai.session", ondelete="set null", index=True)
    user_id = fields.Many2one(
        "res.users", default=lambda self: self.env.user, index=True,
    )
    action_type = fields.Selection([
        ("system_audit", "System Audit"),
        ("find_stale_leads", "Find Stale Leads"),
        ("show_overdue_tasks", "Show Overdue Tasks"),
        ("find_old_tickets", "Find Old Tickets"),
        ("find_unbilled_orders", "Find Unbilled Orders"),
        ("find_duplicate_expenses", "Find Duplicate Expenses"),
        ("check_duplicate_bills", "Check Duplicate Bills"),
        ("generate_email_template", "Generate Email Template"),
        ("generate_website_content", "Generate Website Content"),
        ("build_document_packet", "Build Document Packet"),
        ("check_cron_jobs", "Check Cron Jobs"),
        ("list_modules", "List Modules"),
        ("check_module_health", "Check Module Health"),
        ("financial_summary", "Financial Summary"),
        ("crm_pipeline_analysis", "CRM Pipeline"),
        ("revenue_forecast", "Revenue Forecast"),
        ("custom", "Custom Action"),
    ], required=True)
    params = fields.Text(default="{}")
    state = fields.Selection([
        ("pending", "Pending Approval"),
        ("approved", "Approved"),
        ("rejected", "Rejected"),
        ("running", "Running"),
        ("completed", "Completed"),
        ("failed", "Failed"),
    ], default="pending", index=True)
    result = fields.Text()
    error_message = fields.Text()

    # ─── Approval ───────────────────────────────────────────────────
    def action_approve(self):
        """Approve and execute the task."""
        self.ensure_one()
        if self.state != "pending":
            return {"error": "Task is not pending approval"}
        self.state = "approved"
        return self._execute()

    def action_reject(self):
        """Reject the task."""
        self.ensure_one()
        self.state = "rejected"
        self._log("rejected", "Task rejected by user")
        return {"success": True}

    # ─── Execution ──────────────────────────────────────────────────
    def _execute(self):
        """Execute the approved task."""
        self.ensure_one()
        if self.state not in ("approved", "pending"):
            return {"error": f"Cannot execute task in state '{self.state}'"}

        self.state = "running"

        try:
            params = json.loads(self.params or "{}")
        except json.JSONDecodeError:
            params = {}

        try:
            from ..services import odoo_tools

            tool_map = {
                "system_audit": lambda: self._run_system_audit(),
                "find_stale_leads": lambda: odoo_tools.tool_find_stale_leads(
                    self.env, days=params.get("days", 30),
                ),
                "show_overdue_tasks": lambda: odoo_tools.tool_show_overdue_tasks(self.env),
                "find_old_tickets": lambda: odoo_tools.tool_find_old_tickets(
                    self.env, days=params.get("days", 14),
                ),
                "find_unbilled_orders": lambda: odoo_tools.tool_find_unbilled_orders(self.env),
                "find_duplicate_expenses": lambda: odoo_tools.tool_find_duplicate_expenses(self.env),
                "check_duplicate_bills": lambda: self.env["prema.ai.session"]._tool_check_duplicate_bills(self),
                "generate_email_template": lambda: odoo_tools.tool_generate_email_template(
                    self.env,
                    subject=params.get("subject", ""),
                    body_text=params.get("body_text", ""),
                ),
                "build_document_packet": lambda: odoo_tools.tool_build_document_packet(
                    self.env,
                    folder_name=params.get("folder_name", "Packet"),
                    attachment_ids=params.get("attachment_ids"),
                    domain=params.get("domain"),
                ),
                "check_cron_jobs": lambda: odoo_tools.tool_check_cron_jobs(self.env),
                "list_modules": lambda: odoo_tools.tool_list_modules(self.env),
                "check_module_health": lambda: odoo_tools.tool_check_module_health(
                    self.env, module_name=params.get("module_name", ""),
                ),
                "financial_summary": lambda: self.env["prema.ai.session"]._tool_financial_summary(self),
                "crm_pipeline_analysis": lambda: self.env["prema.ai.session"]._tool_crm_pipeline_analysis(self),
                "revenue_forecast": lambda: self.env["prema.ai.session"]._tool_revenue_forecast(self),
            }

            handler = tool_map.get(self.action_type)
            if not handler:
                raise ValueError(f"Unknown action type: {self.action_type}")

            result = handler()
            self.write({
                "state": "completed",
                "result": json.dumps(result, default=str),
            })
            self._log("completed", f"Task completed: {self.action_type}")
            return {"success": True, "result": result}

        except Exception as e:
            _logger.error("Task execution failed [%s]: %s", self.action_type, e)
            self.write({
                "state": "failed",
                "error_message": str(e),
            })
            self._log("failed", f"Task failed: {e}")
            return {"error": str(e)}

    def _run_system_audit(self):
        """Trigger a full audit scan."""
        scan_id = self.env["prema.audit.scan"].run_scan()
        results = self.env["prema.audit.scan"].get_scan_results(scan_id)
        return results

    # ─── Logging ────────────────────────────────────────────────────
    def _log(self, status, summary):
        try:
            self.env["prema.ai.audit.log"].sudo().create({
                "user_id": self.env.user.id,
                "action_type": self.action_type,
                "model": "prema.ai.task",
                "record_id": self.id,
                "summary": summary[:500],
                "status": status,
            })
        except Exception as e:
            _logger.warning("Failed to log task action: %s", e)
