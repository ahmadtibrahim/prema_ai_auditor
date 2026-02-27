from odoo import models


class PremaLLMService(models.AbstractModel):
    _name = "prema.llm.service"
    _description = "Prema LLM Orchestrator"

    def ask_auditor(self, message):
        openai_client = self.env["prema.openai.client"]
        return openai_client.call(
            [
                {
                    "role": "system",
                    "content": "You are a Canadian accounting AI auditor.",
                },
                {"role": "user", "content": message},
            ]
        )
