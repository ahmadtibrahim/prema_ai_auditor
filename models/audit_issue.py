import json
from odoo import api, fields, models


class PremaAuditIssue(models.Model):
    _name = "prema.audit.issue"
    _description = "Prema Audit Issue"
    _order = "risk asc, id asc"

    scan_id = fields.Many2one("prema.audit.scan", required=True, ondelete="cascade", index=True)
    category = fields.Char()
    code = fields.Char()
    risk = fields.Selection([("critical", "Critical"), ("high", "High"), ("medium", "Medium"), ("low", "Low")], required=True, default="low")
    title = fields.Char(required=True)
    detail = fields.Text()
    affected_model = fields.Char()
    affected_ids = fields.Text()
    fix_action = fields.Text()
    fix_state = fields.Selection([
        ("no_fix", "No Auto-Fix"), ("pending", "Pending Approval"),
        ("approved", "Approved"), ("rejected", "Rejected"),
        ("executed", "Executed"), ("failed", "Failed"),
    ], default="no_fix")
    fix_executed_by = fields.Many2one("res.users")
    fix_executed_at = fields.Datetime()
    fix_result = fields.Text()

    @api.model
    def approve_fix(self, issue_id):
        issue = self.browse(issue_id)
        issue.ensure_one()
        if issue.fix_state != "pending":
            return {"error": "Not in pending state"}
        if not issue.fix_action:
            return {"error": "No fix action"}
        try:
            fix = json.loads(issue.fix_action)
        except Exception:
            return {"error": "Invalid fix JSON"}
        try:
            fix_type = fix.get("type")
            if fix_type == "update_record":
                self.env[fix["model"]].browse(fix["record_id"]).write(fix["values"])
                result = "Updated {} ID {}".format(fix["model"], fix["record_id"])
            elif fix_type == "delete_record":
                self.env[fix["model"]].browse(fix["record_id"]).unlink()
                result = "Deleted {} ID {}".format(fix["model"], fix["record_id"])
            elif fix_type == "create_record":
                r = self.env[fix["model"]].create(fix["values"])
                result = "Created {} ID {}".format(fix["model"], r.id)
            else:
                return {"error": "Unknown fix type: {}".format(fix_type)}
        except Exception as e:
            issue.write({"fix_state": "failed", "fix_result": str(e)})
            self._log_fix(issue, fix, "FAILED: {}".format(e), approved=False)
            return {"error": str(e)}
        issue.write({
            "fix_state": "executed",
            "fix_executed_by": self.env.user.id,
            "fix_executed_at": fields.Datetime.now(),
            "fix_result": result,
        })
        self._log_fix(issue, fix, result, approved=True)
        return {"success": True, "result": result}

    @api.model
    def reject_fix(self, issue_id, reason=""):
        issue = self.browse(issue_id)
        issue.ensure_one()
        issue.write({"fix_state": "rejected", "fix_result": "Rejected: {}".format(reason)})
        try:
            fix = json.loads(issue.fix_action or "{}")
        except Exception:
            fix = {}
        try:
            self.env["prema.ai.correction"].record_correction(
                context_type="fix_rejection",
                ai_suggestion=fix,
                user_correction=reason or "No reason given",
                tags=issue.category or "",
            )
        except Exception:
            pass
        self._log_fix(issue, fix, "REJECTED: {}".format(reason), approved=False)
        return {"success": True}

    def _log_fix(self, issue, fix, result, approved):
        self.env["prema.audit.fix.log"].create({
            "issue_id": issue.id,
            "action": json.dumps(fix, default=str),
            "result": result,
            "user_id": self.env.user.id,
            "approved": approved,
        })
