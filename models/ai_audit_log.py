from odoo import models, fields


class PremaAiAuditLog(models.Model):
    _name = 'prema.ai.audit.log'
    _description = 'Prema AI Audit Log'
    _order = 'create_date desc'

    session_id = fields.Many2one('prema.ai.session')
    task_id = fields.Many2one('prema.ai.task.queue')
    user_id = fields.Many2one('res.users', default=lambda self: self.env.user)
    action = fields.Char()
    model_name = fields.Char()
    record_id = fields.Integer()
    details = fields.Text()
    success = fields.Boolean(default=True)
