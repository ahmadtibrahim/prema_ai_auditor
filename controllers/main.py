# /opt/odoo/custum-addons/prema_ai_auditor/controllers/main.py

from odoo import http
from odoo.http import request


class PremaAIController(http.Controller):

    # -----------------------------------------------------
    # CHAT ENDPOINT
    # -----------------------------------------------------

    @http.route("/prema_ai/chat", type="json", auth="user")
    def prema_ai_chat(self, message=None):
        if not message or not message.strip():
            return {
                "error": "Empty message"
            }

        try:
            result = request.env["prema.ai.session"].sudo().send_user_message(message)

            return result

        except Exception as e:
            return {
                "error": str(e)
            }

    # -----------------------------------------------------
    # LOAD HISTORY
    # -----------------------------------------------------

    @http.route("/prema_ai/history", type="json", auth="user")
    def prema_ai_history(self):
        try:
            messages = request.env["prema.ai.session"].sudo().get_session_messages()
            return {
                "messages": messages
            }
        except Exception as e:
            return {
                "error": str(e)
            }