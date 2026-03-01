from odoo import fields, models


class AccountMove(models.Model):
    _inherit = "account.move"

    created_from_ai = fields.Boolean(default=False)
    ai_session_id = fields.Many2one("prema.ai.session", readonly=True)
    ai_detected_keywords = fields.Text(readonly=True)

    def write(self, vals):
        track_account_change = "invoice_line_ids" in vals
        before_snapshot = {}
        if track_account_change:
            for move in self.filtered(lambda m: m.move_type == "in_invoice" and m.created_from_ai):
                before_snapshot[move.id] = {
                    line.id: line.account_id.id for line in move.invoice_line_ids
                }

        result = super().write(vals)

        if track_account_change and before_snapshot:
            learning_engine = self.env["prema.ai.learning.engine"]
            for move in self.filtered(lambda m: m.id in before_snapshot):
                previous_map = before_snapshot[move.id]
                for line in move.invoice_line_ids:
                    old_account_id = previous_map.get(line.id)
                    new_account_id = line.account_id.id
                    if old_account_id and new_account_id and old_account_id != new_account_id:
                        learning_engine.record_correction(
                            move.partner_id.id,
                            old_account_id,
                            new_account_id,
                            move.ai_detected_keywords,
                        )

        return result
