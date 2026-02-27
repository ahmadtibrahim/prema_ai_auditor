from odoo import models
import json


class PremaLLMService(models.AbstractModel):
    _name = "prema.llm.service"
    _description = "Prema LLM Orchestrator"

    def process(self, user_message):
        tools = self.env["prema.tool.registry"].get_tool_definitions()

        response = self.env["prema.openai.client"].call(
            {
                "model": "gpt-4.1",
                "messages": [
                    {"role": "system", "content": "You are a Canadian CFO auditor."},
                    {"role": "user", "content": user_message},
                ],
                "tools": tools,
                "tool_choice": "auto",
            }
        )

        msg = response["choices"][0]["message"]

        if "tool_calls" in msg:
            for call in msg["tool_calls"]:
                tool_name = call["function"]["name"]
                args = json.loads(call["function"]["arguments"])
                self.env["prema.tool.registry"].execute(tool_name, args)

            return {
                "reply": "Audit executed. See findings.",
                "health_score": self.env["prema.health.score"].compute_score(),
            }

        return {
            "reply": msg.get("content", ""),
            "health_score": self.env["prema.health.score"].compute_score(),
        }
