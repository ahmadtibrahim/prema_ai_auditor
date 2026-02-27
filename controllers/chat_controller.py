from odoo import http
from odoo.http import request


class PremaChatController(http.Controller):
    @http.route("/prema_ai/session", type="json", auth="user")
    def session(self):
        session = request.env["prema.ai.session"].sudo().create(
            {
                "name": f"Session - {request.env.user.name}",
                "user_id": request.env.user.id,
            }
        )
        return {"id": session.id}

    @http.route("/prema_ai/chat", type="json", auth="user")
    def chat(self, message, session_id=None, mode="advice_only"):
        if not request.env.user.has_group("prema_ai_auditor.group_prema_ai_master"):
            return {"reply": "Access denied.", "health_score": 0}

        if session_id:
            request.env["prema.ai.message"].sudo().create(
                {
                    "session_id": session_id,
                    "role": "user",
                    "content": message,
                }
            )

        schema = request.env["prema.model.introspector"].get_schema_cached()
        diagnostics = request.env["prema.ai.self.heal"].diagnose()
        response = request.env["prema.llm.service"].process(
            message=message,
            schema=schema,
            diagnostics=diagnostics,
        )

        summary = ""
        if session_id:
            summary = request.env["prema.ai.document.processor"].sudo().summarize_session_documents(session_id)

        draft_hint = ""
        if mode == "draft":
            draft_hint = "\nDraft creation is available only after explicit approval."

        reply = f"{response['reply']}\n\n{summary}{draft_hint}".strip()

        if session_id:
            request.env["prema.ai.message"].sudo().create(
                {
                    "session_id": session_id,
                    "role": "assistant",
                    "content": reply,
                }
            )

        response["reply"] = reply
        return response

    @http.route("/prema_ai/document_summary", type="json", auth="user")
    def document_summary(self, session_id):
        summary = request.env["prema.ai.document.processor"].sudo().summarize_session_documents(session_id)
        return {"summary": summary}
