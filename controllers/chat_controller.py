from odoo import http
from odoo.http import request


class PremaChatController(http.Controller):
    @http.route("/prema_ai/chat", type="json", auth="user")
    def chat(self, message):
        llm = request.env["prema.openai.client"]
        response = llm.call(
            [
                {
                    "role": "system",
                    "content": "You are a Canadian accounting AI auditor.",
                },
                {"role": "user", "content": message},
            ]
        )
        return response
