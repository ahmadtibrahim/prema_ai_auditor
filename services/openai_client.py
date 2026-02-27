import json

import requests

from odoo import models
from odoo.exceptions import UserError


class OpenAIClient(models.AbstractModel):
    _name = "prema.openai.client"
    _description = "OpenAI Client"

    def call(self, payload, timeout=45, retries=2):
        api_key = self.env["ir.config_parameter"].sudo().get_param("openai.api_key")
        if not api_key:
            raise UserError("OpenAI API key is not configured.")

        headers = {
            "Authorization": f"Bearer {api_key}",
            "Content-Type": "application/json",
        }

        failure_count_param = "prema_ai_auditor.llm_failure_count"
        failures = int(self.env["ir.config_parameter"].sudo().get_param(failure_count_param, default="0"))
        if failures >= 3:
            raise UserError("LLM circuit breaker is open. Try again later.")

        last_error = None
        for _idx in range(retries + 1):
            try:
                response = requests.post(
                    "https://api.openai.com/v1/chat/completions",
                    headers=headers,
                    data=json.dumps(payload),
                    timeout=timeout,
                )
                response.raise_for_status()
                self.env["ir.config_parameter"].sudo().set_param(failure_count_param, "0")
                return response.json()
            except requests.RequestException as exc:
                last_error = exc

        self.env["ir.config_parameter"].sudo().set_param(failure_count_param, str(failures + 1))
        raise UserError(f"OpenAI request failed: {last_error}")
