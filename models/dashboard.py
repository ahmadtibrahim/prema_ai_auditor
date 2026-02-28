from odoo import fields, models


class PremaAIDashboard(models.Model):
    _name = "prema.ai.dashboard"
    _description = "Prema AI Dashboard"

    name = fields.Char(default="Prema AI Dashboard")
