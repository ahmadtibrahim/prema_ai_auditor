from odoo import fields, models


class PremaAIDocument(models.Model):
    _name = "prema.ai.document"
    _description = "Prema AI Document"
    _order = "create_date desc"

    name = fields.Char(required=True)
    session_id = fields.Many2one("prema.ai.session", required=True, ondelete="cascade", index=True)
    attachment_id = fields.Many2one("ir.attachment", required=True, ondelete="cascade")
    document_type = fields.Selection(
        [
            ("bill", "Bill"),
            ("license", "License"),
            ("insurance", "Insurance"),
            ("unknown", "Unknown"),
        ],
        default="unknown",
        required=True,
    )
    ai_summary = fields.Text()
    ai_suggested_action = fields.Text()
    status = fields.Selection(
        [
            ("draft", "Draft"),
            ("analyzed", "Analyzed"),
            ("processed", "Processed"),
        ],
        default="draft",
        required=True,
    )
