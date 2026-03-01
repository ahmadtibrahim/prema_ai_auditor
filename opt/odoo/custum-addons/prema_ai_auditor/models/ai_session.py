from odoo import models, fields, api
import requests
import json


class PremaAISession(models.Model):
    _name = "prema.ai.session"
    _description = "Prema AI Session"
    _order = "create_date desc"

    name = fields.Char(required=True)
    user_id = fields.Many2one(
        "res.users",
        required=True,
        default=lambda self: self.env.user,
        ondelete="cascade",
        index=True,
    )
    message_ids = fields.One2many(
        "prema.ai.message",
        "session_id",
    )

    # -------------------------------------------------------
    # SESSION MANAGEMENT
    # -------------------------------------------------------

    @api.model
    def get_or_create_user_session(self):
        session = self.search(
            [("user_id", "=", self.env.user.id)],
            limit=1,
        )
        if not session:
            session = self.create({
                "name": f"Session - {self.env.user.name}",
                "user_id": self.env.user.id,
            })
        return session

    @api.model
    def get_session_messages(self):
        session = self.get_or_create_user_session()
        return session.message_ids.sorted("create_date").read(
            ["id", "role", "content", "create_date"]
        )

    @api.model
    def add_message(self, role, content):
        session = self.get_or_create_user_session()
        return self.env["prema.ai.message"].create({
            "session_id": session.id,
            "role": role,
            "content": content,
        })

    # -------------------------------------------------------
    # TOOL REGISTRY
    # -------------------------------------------------------

    def _tool_registry(self):
        return {
            "scan_chart_of_accounts": self._tool_scan_chart_of_accounts,
        }

    # -------------------------------------------------------
    # TOOL IMPLEMENTATION
    # -------------------------------------------------------

    def _tool_scan_chart_of_accounts(self, payload=None):
        accounts = self.env["account.account"].search([])
        findings = []

        for acc in accounts:
            if not acc.code:
                findings.append({
                    "account_id": acc.id,
                    "issue": "Missing account code",
                })

        return findings

    # -------------------------------------------------------
    # SEND MESSAGE ENTRYPOINT
    # -------------------------------------------------------

    @api.model
    def send_user_message(self, content):
        if not content or not content.strip():
            return {"error": "Empty message"}

        session = self.get_or_create_user_session()

        user_message = self.env["prema.ai.message"].create({
            "session_id": session.id,
            "role": "user",
            "content": content.strip(),
        })

        assistant_reply = self._call_openai(session)

        return {
            "user": {
                "id": user_message.id,
                "role": "user",
                "content": user_message.content,
            },
            "assistant": assistant_reply,
        }

    # -------------------------------------------------------
    # OPENAI CALL
    # -------------------------------------------------------

    def _call_openai(self, session):
        api_key = self.env["ir.config_parameter"].sudo().get_param("openai.api_key")
        if not api_key:
            raise ValueError("OpenAI API key not configured.")

        headers = {
            "Authorization": f"Bearer {api_key}",
            "Content-Type": "application/json",
        }

        history = session.message_ids.sorted("create_date")[-20:]

        messages = [{
            "role": "system",
            "content": (
                "You are Prema AI running inside Odoo 18 Enterprise.\n"
                "You operate strictly through ORM.\n"
                "If user requests accounting scan, use available tools.\n"
                "Available tool:\n"
                "- scan_chart_of_accounts\n"
            ),
        }]

        for msg in history:
            messages.append({
                "role": msg.role,
                "content": msg.content,
            })

        payload = {
            "model": "gpt-4o-mini",
            "messages": messages,
            "tools": [
                {
                    "type": "function",
                    "function": {
                        "name": "scan_chart_of_accounts",
                        "description": "Scan Odoo chart of accounts for issues.",
                        "parameters": {
                            "type": "object",
                            "properties": {},
                        },
                    },
                }
            ],
            "tool_choice": "auto",
        }

        response = requests.post(
            "https://api.openai.com/v1/chat/completions",
            headers=headers,
            data=json.dumps(payload),
            timeout=30,
        )

        if response.status_code != 200:
            raise ValueError(response.text)

        data = response.json()
        choice = data["choices"][0]["message"]

        # ---------------------------------------------------
        # TOOL CALL HANDLING
        # ---------------------------------------------------

        if "tool_calls" in choice:
            tool_call = choice["tool_calls"][0]
            tool_name = tool_call["function"]["name"]

            tools = self._tool_registry()
            if tool_name not in tools:
                raise ValueError("Tool not registered.")

            result = tools[tool_name]()

            log = self.env["prema.ai.tool.log"].create({
                "user_id": self.env.user.id,
                "tool_name": tool_name,
                "input_payload": json.dumps({}),
                "output_payload": json.dumps(result),
                "status": "suggested",
            })

            assistant_message = self.env["prema.ai.message"].create({
                "session_id": session.id,
                "role": "assistant",
                "content": f"Tool '{tool_name}' executed. {len(result)} findings stored for approval.",
            })

            return {
                "id": assistant_message.id,
                "role": "assistant",
                "content": assistant_message.content,
                "tool_log_id": log.id,
            }

        # ---------------------------------------------------
        # NORMAL RESPONSE
        # ---------------------------------------------------

        reply_text = choice.get("content", "")

        assistant_message = self.env["prema.ai.message"].create({
            "session_id": session.id,
            "role": "assistant",
            "content": reply_text,
        })

        return {
            "id": assistant_message.id,
            "role": "assistant",
            "content": assistant_message.content,
        }
