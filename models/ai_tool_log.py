from odoo import fields, models
from odoo.exceptions import UserError


class PremaAIToolLog(models.Model):
    _name = "prema.ai.tool.log"
    _description = "Prema AI Tool Execution Log"
    _order = "create_date desc"

    user_id = fields.Many2one("res.users", required=True)
    tool_name = fields.Char(required=True)
    input_payload = fields.Text()
    output_payload = fields.Text()

    status = fields.Selection(
        [
            ("suggested", "Suggested"),
            ("approved", "Approved"),
            ("executed", "Executed"),
            ("failed", "Failed"),
        ],
        default="suggested",
    )

    def action_approve(self):
        self.write({"status": "approved"})

    def action_execute(self):
        if self.status != "approved":
            raise UserError("Tool must be approved before execution.")
        self.write({"status": "executed"})

    def action_delete_log(self):
        self.unlink()
