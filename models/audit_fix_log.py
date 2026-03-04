from odoo import fields, models


class PremaAuditFixLog(models.Model):
    _name = "prema.audit.fix.log"
    _description = "Prema Audit Fix Log"
    _order = "create_date desc"

    issue_id = fields.Many2one("prema.audit.issue", ondelete="set null", index=True)
    user_id = fields.Many2one("res.users", string="User", readonly=True)
    approved = fields.Boolean()
    action = fields.Text(string="Fix Action (JSON)")
    result = fields.Text()
    create_date = fields.Datetime(readonly=True)
