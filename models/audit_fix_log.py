# FILE: /opt/odoo/custum-addons/prema_ai_auditor/models/audit_fix_log.py

from odoo import fields, models


class PremaAuditFixLog(models.Model):
    _name = "prema.audit.fix.log"
    _description = "Prema Audit Fix Log"
    _order = "create_date desc"

    issue_id = fields.Many2one(
        "prema.audit.issue", required=True, ondelete="cascade",
    )
    action = fields.Text()
    result = fields.Text()
    user_id = fields.Many2one("res.users")
    approved = fields.Boolean()
