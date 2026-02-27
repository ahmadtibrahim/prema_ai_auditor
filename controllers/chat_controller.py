from odoo import http
from odoo.http import request


class PremaChatController(http.Controller):
    @http.route("/prema_ai/chat", type="json", auth="user")
    def chat(self, message):
        return request.env["prema.llm.service"].process(message)
