import json

import requests

from odoo import fields, models
from odoo.exceptions import UserError

OPENAI_API_KEY_PARAM = "openai.api_key"


class PremaAISession(models.Model):
    _name = "prema.ai.session"
    _description = "Prema AI Session"
    _order = "create_date desc"

    name = fields.Char(default="AI Session")
    user_id = fields.Many2one("res.users", default=lambda self: self.env.user)
    message_ids = fields.One2many("prema.ai.message", "session_id")

    def send_message(self, content):
        self.ensure_one()

        if self.user_id != self.env.user:
            raise UserError("You can only send messages in your own sessions.")

        message_text = (content or "").strip()
        if not message_text:
            raise UserError("Message content cannot be empty.")

        self.env["prema.ai.message"].create(
            {
                "session_id": self.id,
                "role": "user",
                "content": message_text,
            }
        )

        assistant_reply = self._call_openai()

        self.env["prema.ai.message"].create(
            {
                "session_id": self.id,
                "role": "assistant",
                "content": assistant_reply,
            }
        )

        return assistant_reply

    def _tool_registry(self):
        return {
            "search_records": self._tool_search_records,
            "create_record": self._tool_create_record,
            "update_record": self._tool_update_record,
            "delete_record": self._tool_delete_record,
            "run_python": self._tool_run_python_safe,
            "check_duplicate_bills": self._tool_check_duplicate_bills,
            "financial_summary": self._tool_financial_summary,
            "crm_pipeline_analysis": self._tool_crm_pipeline_analysis,
            "revenue_forecast": self._tool_revenue_forecast,
        }

    def _tool_search_records(self, model, domain, fields):
        return self.env[model].search_read(domain or [], fields or [])

    def _tool_create_record(self, model, values, confirmed=False):
        if not confirmed:
            return "Confirmation required before creating records."
        return self.env[model].create(values or {}).id

    def _tool_update_record(self, model, record_id, values, confirmed=False):
        if not confirmed:
            return "Confirmation required before updating records."
        self.env[model].browse(record_id).write(values or {})
        return True

    def _tool_delete_record(self, model, record_id, confirmed=False):
        if not confirmed:
            return "Confirmation required before deleting records."
        self.env[model].browse(record_id).unlink()
        return True

    def _tool_run_python_safe(self, code=None, confirmed=False):
        if not confirmed:
            return "Confirmation required before running server-side Python."
        raise UserError("run_python is disabled in production-safe mode.")

    def _tool_check_duplicate_bills(self):
        grouped = self.env["account.move"].read_group(
            [("move_type", "=", "in_invoice"), ("state", "!=", "cancel")],
            ["ref", "partner_id", "id:count"],
            ["ref", "partner_id"],
            lazy=False,
        )
        duplicates = []
        for row in grouped:
            if row.get("id_count", 0) > 1 and row.get("ref") and row.get("partner_id"):
                duplicates.append(
                    {
                        "partner_id": row["partner_id"][0],
                        "partner_name": row["partner_id"][1],
                        "reference": row["ref"],
                        "count": row["id_count"],
                    }
                )
        return duplicates

    def _tool_financial_summary(self):
        moves = self.env["account.move"].search([
            ("state", "=", "posted"),
            ("move_type", "in", ["out_invoice", "out_refund", "in_invoice", "in_refund"]),
        ])
        revenue = sum(moves.filtered(lambda m: m.move_type in ("out_invoice", "out_refund")).mapped("amount_total_signed"))
        expense = -sum(moves.filtered(lambda m: m.move_type in ("in_invoice", "in_refund")).mapped("amount_total_signed"))
        return {
            "posted_moves": len(moves),
            "revenue": revenue,
            "expense": expense,
            "net": revenue - expense,
        }

    def _tool_crm_pipeline_analysis(self):
        leads = self.env["crm.lead"].search([])
        stage_breakdown = {}
        for lead in leads:
            stage = lead.stage_id.name or "Undefined"
            stage_breakdown.setdefault(stage, {"count": 0, "expected_revenue": 0.0})
            stage_breakdown[stage]["count"] += 1
            stage_breakdown[stage]["expected_revenue"] += lead.expected_revenue or 0.0
        return stage_breakdown

    def _tool_revenue_forecast(self):
        leads = self.env["crm.lead"].search([("type", "=", "opportunity")])
        weighted = sum((lead.expected_revenue or 0.0) * ((lead.probability or 0.0) / 100.0) for lead in leads)
        return {
            "opportunity_count": len(leads),
            "weighted_forecast": weighted,
        }

    def _call_openai(self):
        self.ensure_one()

        api_key = self.env["ir.config_parameter"].sudo().get_param(OPENAI_API_KEY_PARAM)
        if not api_key:
            raise UserError(f"OpenAI API key is not configured in System Parameters ({OPENAI_API_KEY_PARAM})")

        messages = [
            {
                "role": "system",
                "content": (
                    "You are connected to a live Odoo 18 ERP. "
                    "You may request tools:\n"
                    "- search_records\n"
                    "- create_record\n"
                    "- update_record\n"
                    "- delete_record\n"
                    "Always ask confirmation before destructive actions."
                ),
            }
        ]
        for msg in self.message_ids.sorted("create_date")[-20:]:
            messages.append({"role": msg.role, "content": msg.content})

        tool_specs = []
        for name in self._tool_registry().keys():
            tool_specs.append(
                {
                    "type": "function",
                    "name": name,
                    "description": f"Execute {name} on Odoo ORM.",
                    "parameters": {"type": "object", "additionalProperties": True},
                }
            )

        try:
            response = requests.post(
                "https://api.openai.com/v1/responses",
                headers={
                    "Authorization": f"Bearer {api_key}",
                    "Content-Type": "application/json",
                },
                json={
                    "model": "gpt-4.1-mini",
                    "input": messages,
                    "tools": tool_specs,
                    "tool_choice": "auto",
                },
                timeout=60,
            )
            response.raise_for_status()
            data = response.json()
        except requests.RequestException as exc:
            raise UserError(f"OpenAI chat request failed: {exc}")
        except ValueError as exc:
            raise UserError(f"OpenAI chat response is not valid JSON: {exc}")

        output = data.get("output", [])
        tool_calls = [item for item in output if item.get("type") == "function_call"]
        if tool_calls:
            tools = self._tool_registry()
            tool_result_messages = []
            for call in tool_calls:
                tool_name = call.get("name")
                if tool_name not in tools:
                    raise UserError(f"Tool not registered: {tool_name}")
                arguments = call.get("arguments") or "{}"
                params = json.loads(arguments) if isinstance(arguments, str) else (arguments or {})
                result = tools[tool_name](**params)
                tool_result_messages.append({
                    "type": "function_call_output",
                    "call_id": call.get("call_id"),
                    "output": json.dumps(result),
                })

            followup = requests.post(
                "https://api.openai.com/v1/responses",
                headers={
                    "Authorization": f"Bearer {api_key}",
                    "Content-Type": "application/json",
                },
                json={
                    "model": "gpt-4.1-mini",
                    "input": tool_result_messages,
                    "previous_response_id": data.get("id"),
                },
                timeout=60,
            )
            followup.raise_for_status()
            data = followup.json()
            output = data.get("output", [])

        text_output = ""
        for block in output:
            for item in block.get("content", []):
                if item.get("type") == "output_text":
                    text_output += item.get("text", "")

        return text_output or "I could not generate a response."
