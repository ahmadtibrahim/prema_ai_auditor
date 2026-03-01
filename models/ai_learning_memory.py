from odoo import fields, models


class PremaAILearningMemory(models.Model):
    _name = "prema.ai.learning.memory"
    _description = "Prema AI Learning Memory"
    _order = "times_corrected desc, confidence_score desc"

    vendor_id = fields.Many2one("res.partner", required=True, ondelete="cascade", index=True)
    detected_keywords = fields.Text(required=True)
    suggested_account_id = fields.Many2one("account.account")
    corrected_account_id = fields.Many2one("account.account", required=True)
    analytic_account_id = fields.Many2one("account.analytic.account")
    times_corrected = fields.Integer(default=1)
    confidence_score = fields.Float(default=0.5)
