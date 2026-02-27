import json

import requests

from odoo import models
from odoo.exceptions import UserError


class OpenAIClient(models.AbstractModel):
    _name = "prema.openai.client"
    _description = "OpenAI Client"

    def call(self, messages):
        api_key = self.env["ir.config_parameter"].sudo().get_param("openai.api_key")
        if not api_key:
            raise UserError("OpenAI API key is not configured.")

        headers = {
            "Authorization": f"Bearer {api_key}",
            "Content-Type": "application/json",
        }

        payload = {
            "model": "gpt-4.1",
            "messages": messages,
            "temperature": 0.2,
        }

        response = requests.post(
            "https://api.openai.com/v1/chat/completions",
            headers=headers,
            data=json.dumps(payload),
            timeout=60,
        )
        response.raise_for_status()
        return response.json()
