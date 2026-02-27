from odoo import models
from odoo.exceptions import UserError


class ToolRegistry(models.AbstractModel):
    _name = "prema.tool.registry"
    _description = "Prema Tool Registry"

    def get_tools(self):
        return {
            "scan_unreconciled_bank": self._scan_unreconciled_bank,
            "scan_gst_anomalies": self._scan_gst_anomalies,
            "scan_duplicate_bills": self._scan_duplicate_bills,
        }

    def execute(self, tool_name, args):
        tools = self.get_tools()
        if tool_name not in tools:
            raise UserError("Unauthorized tool call")
        return tools[tool_name](**args)

    def _scan_unreconciled_bank(self):
        lines = self.env["account.bank.statement.line"].search([
            ("is_reconciled", "=", False),
            ("is_complete", "=", True),
        ])
        return lines.ids

    def _scan_gst_anomalies(self):
        move_lines = self.env["account.move.line"].search([
            ("display_type", "=", "tax"),
            ("move_id.state", "=", "posted"),
            ("tax_line_id", "!=", False),
        ])
        anomalies = []
        valid_rates = {0.0, 0.05, 0.13, 0.15}
        for line in move_lines:
            amount = round(line.tax_line_id.amount / 100, 2)
            if amount not in valid_rates:
                anomalies.append(line.id)
        return anomalies

    def _scan_duplicate_bills(self):
        moves = self.env["account.move"].search(
            [("move_type", "=", "in_invoice"), ("state", "=", "posted")]
        )
        seen = {}
        duplicates = []
        for move in moves:
            key = (move.partner_id.id, move.amount_total, move.invoice_date)
            if key in seen:
                duplicates.append(move.id)
            else:
                seen[key] = move.id
        return duplicates
