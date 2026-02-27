from odoo import http
from odoo.http import request


class PremaChatController(http.Controller):
    @http.route("/prema_ai/chat", type="json", auth="user")
    def chat(self, message):
        if not request.env.user.has_group("prema_ai_auditor.group_prema_ai_master"):
            return {"reply": "Access denied."}

        schema = request.env["prema.model.introspector"].get_schema_cached()
        diagnostics = request.env["prema.ai.self.heal"].diagnose()

        return request.env["prema.llm.service"].process(
            message=message,
            schema=schema,
            diagnostics=diagnostics,
        )
