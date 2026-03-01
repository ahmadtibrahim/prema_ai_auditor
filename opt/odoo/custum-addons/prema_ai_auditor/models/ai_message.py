from odoo import models, fields, api


class PremaAIMessage(models.Model):
    _name = "prema.ai.message"
    _description = "Prema AI Message"
    _order = "create_date asc"

    session_id = fields.Many2one(
        "prema.ai.session",
        required=True,
        ondelete="cascade",
        index=True,
    )

    user_id = fields.Many2one(
        "res.users",
        related="session_id.user_id",
        store=True,
        index=True,
        readonly=True,
    )

    role = fields.Selection(
        [
            ("system", "System"),
            ("user", "User"),
            ("assistant", "Assistant"),
        ],
        required=True,
        index=True,
    )

    content = fields.Text(required=True)

    # create_date handled automatically by Odoo
