# FILE: /opt/odoo/custum-addons/prema_ai_auditor/models/audit_log.py
"""
TASK 14: Action Logging Model
Logs every AI action for auditability.
"""

from odoo import fields, models


class PremaAIAuditLog(models.Model):
    _name = "prema.ai.audit.log"
    _description = "Prema AI Audit Log"
    _order = "create_date desc"

    user_id = fields.Many2one("res.users", string="User", index=True)
    action_type = fields.Char(string="Action Type", index=True)
    model = fields.Char(string="Model")
    record_id = fields.Integer(string="Record ID")
    summary = fields.Text(string="Summary")
    status = fields.Selection([
        ("completed", "Completed"),
        ("failed", "Failed"),
        ("rejected", "Rejected"),
        ("pending", "Pending"),
    ], default="completed", index=True)
    timestamp = fields.Datetime(
        string="Timestamp", default=fields.Datetime.now, index=True,
    )
