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
    # raw text returned from AI if JSON parsing fails
    ai_summary = fields.Text()
    vendor_name = fields.Char()
    invoice_number = fields.Char()
    invoice_date = fields.Date()
    subtotal = fields.Monetary(currency_field="currency_id")
    tax = fields.Monetary(currency_field="currency_id")
    total = fields.Monetary(currency_field="currency_id")
    line_items = fields.Text(help="JSON-encoded list of line items returned by AI")
    currency_id = fields.Many2one(
        "res.currency",
        string="Currency",
        default=lambda self: self.env.company.currency_id,
    )
    ai_suggested_action = fields.Text()
    status = fields.Selection(
        [
            ("uploaded", "Uploaded"),
            ("analyzed", "Analyzed"),
            ("validated", "Validated"),
            ("draft_created", "Draft Created"),
            ("processed", "Processed"),
        ],
        default="uploaded",
        required=True,
    )
