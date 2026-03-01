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

    # =====================================================
    # TOOL REGISTRY
    # =====================================================

    def _tool_registry(self):
        return {
            "scan_chart_of_accounts": self._tool_scan_chart_of_accounts,
        }

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

    # =====================================================
    # CHAT MESSAGE ENTRYPOINT
    # =====================================================

    def send_user_message(self, content):
        self.ensure_one()

        if not content or not content.strip():
            return {"error": "Empty message"}

        user_message = self.env["prema.ai.message"].create({
            "session_id": self.id,
            "role": "user",
            "content": content.strip(),
        })

        assistant_reply = self._call_openai()

        return {
            "user": {
                "id": user_message.id,
                "role": "user",
                "content": user_message.content,
            },
            "assistant": assistant_reply,
        }

    # =====================================================
    # DOCUMENT ANALYSIS (VISION)
    # =====================================================

    @api.model
    def analyze_uploaded_document(self, *args, **kwargs):
        attachment_id = kwargs.get("attachment_id")

        if not attachment_id:
            raise ValueError("attachment_id is required.")

        api_key = self.env["ir.config_parameter"].sudo().get_param("openai.api_key")
        if not api_key:
            raise ValueError("OpenAI API key not configured.")

        attachment = self.env["ir.attachment"].browse(attachment_id)
        if not attachment:
            raise ValueError("Attachment not found.")

        file_base64 = attachment.datas
        if not file_base64:
            raise ValueError("Attachment has no data.")

        response = requests.post(
            "https://api.openai.com/v1/responses",
            headers={
                "Authorization": f"Bearer {api_key}",
                "Content-Type": "application/json",
            },
            json={
                "model": "gpt-4.1-mini",
                "input": [
                    {
                        "role": "user",
                        "content": [
                            {
                                "type": "input_text",
                                "text": "Extract structured invoice data as JSON. Return only valid JSON."
                            },
                            {
                                "type": "input_image",
                                "image_base64": file_base64
                            }
                        ],
                    }
                ],
            },
            timeout=60,
        )

        if response.status_code != 200:
            raise ValueError(response.text)

        data = response.json()

        output_text = ""
        if data.get("output"):
            for item in data["output"][0].get("content", []):
                if item.get("type") == "output_text":
                    output_text += item.get("text", "")

        document = self.env["prema.ai.document"].create({
            "name": attachment.name,
            "attachment_id": attachment.id,
            "raw_ai_response": output_text,
            "status": "analyzed",
        })

        self.env["prema.ai.tool.log"].create({
            "user_id": self.env.user.id,
            "tool_name": "analyze_document",
            "input_payload": json.dumps({"attachment_id": attachment_id}),
            "output_payload": output_text,
            "status": "executed",
        })

        return {
            "document_id": document.id,
            "parsed_data": output_text,
        }

    # =====================================================
    # OPENAI CHAT CALL
    # =====================================================

    def _call_openai(self):
        self.ensure_one()

        api_key = self.env["ir.config_parameter"].sudo().get_param("openai.api_key")
        if not api_key:
            raise ValueError("OpenAI API key not configured.")

        history = self.message_ids.sorted("create_date")[-20:]

        messages = [{
            "role": "system",
            "content": "You are Prema AI running inside Odoo 18 Enterprise. Operate strictly through ORM.",
        }]

        for msg in history:
            messages.append({
                "role": msg.role,
                "content": msg.content,
            })

        response = requests.post(
            "https://api.openai.com/v1/responses",
            headers={
                "Authorization": f"Bearer {api_key}",
                "Content-Type": "application/json",
            },
            json={
                "model": "gpt-4.1-mini",
                "input": messages,
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
            },
            timeout=60,
        )

        if response.status_code != 200:
            raise ValueError(response.text)

        data = response.json()
        output = data.get("output", [])
        if not output:
            raise ValueError("No output returned from OpenAI.")

        message_block = output[0]

        # Tool call
        if message_block.get("type") == "tool_call":
            tool_name = message_block["name"]

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
                "session_id": self.id,
                "role": "assistant",
                "content": f"Tool '{tool_name}' executed. {len(result)} findings stored for approval.",
            })

            return {
                "id": assistant_message.id,
                "role": "assistant",
                "content": assistant_message.content,
                "tool_log_id": log.id,
            }

        # Normal response
        text_output = ""
        for item in message_block.get("content", []):
            if item.get("type") == "output_text":
                text_output += item.get("text", "")

        assistant_message = self.env["prema.ai.message"].create({
            "session_id": self.id,
            "role": "assistant",
            "content": text_output,
        })

        return {
            "id": assistant_message.id,
            "role": "assistant",
            "content": assistant_message.content,
        }