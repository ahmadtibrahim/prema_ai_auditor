from odoo import models, fields, api
from odoo.exceptions import UserError
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
    document_ids = fields.One2many("prema.ai.document", "session_id")

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
    # SEND MESSAGE ENTRYPOINT (RECORD BASED)
    # -------------------------------------------------------

    def send_user_message(self, content):
        self.ensure_one()

        if not content or not content.strip():
            return {"error": "Empty message"}

        user_message = self.env["prema.ai.message"].create({
            "session_id": self.id,
            "role": "user",
            "content": content.strip(),
        })

        assistant_reply = self._call_openai(self)

        return {
            "user": {
                "id": user_message.id,
                "role": "user",
                "content": user_message.content,
            },
            "assistant": assistant_reply,
        }

    def analyze_uploaded_document(self, attachment_id):
        self.ensure_one()

        attachment = self.env["ir.attachment"].browse(attachment_id)
        if not attachment.exists():
            raise UserError("Attachment not found.")

        if not attachment.datas:
            raise UserError("Attachment content is empty.")

        api_key = self.env["ir.config_parameter"].sudo().get_param("openai.api_key")
        if not api_key:
            raise UserError("OpenAI API key not configured.")

        vision_prompt = (
            "Extract a JSON object with keys: vendor_name, bill_date, total_amount, tax_amount, "
            "line_items (array of {description, quantity, unit_price, amount}), keywords (array), "
            "document_type (bill/license/insurance/unknown), and suggested_action. "
            "Return only valid JSON."
        )

        payload = {
            "model": "gpt-4o-mini",
            "messages": [
                {
                    "role": "user",
                    "content": [
                        {"type": "text", "text": vision_prompt},
                        {
                            "type": "image_url",
                            "image_url": {
                                "url": f"data:{attachment.mimetype or 'application/octet-stream'};base64,{attachment.datas}"
                            },
                        },
                    ],
                }
            ],
            "response_format": {"type": "json_object"},
        }

        try:
            response = requests.post(
                "https://api.openai.com/v1/chat/completions",
                headers={
                    "Authorization": f"Bearer {api_key}",
                    "Content-Type": "application/json",
                },
                data=json.dumps(payload),
                timeout=45,
            )
            response.raise_for_status()
            raw_content = response.json()["choices"][0]["message"].get("content", "{}")
            parsed_data = json.loads(raw_content)
        except (requests.RequestException, KeyError, json.JSONDecodeError) as error:
            raise UserError(f"Document analysis failed: {error}")

        document = self.env["prema.ai.document"].create({
            "name": attachment.name or "Uploaded Document",
            "session_id": self.id,
            "attachment_id": attachment.id,
            "document_type": parsed_data.get("document_type", "unknown"),
            "ai_summary": json.dumps(parsed_data),
            "ai_suggested_action": parsed_data.get("suggested_action", ""),
            "status": "analyzed",
        })

        self.env["prema.ai.tool.log"].create({
            "user_id": self.env.user.id,
            "tool_name": "analyze_document",
            "input_payload": json.dumps({"attachment_id": attachment.id}),
            "output_payload": json.dumps(parsed_data),
            "status": "suggested",
            "session_id": self.id,
        })

        return {
            "document_id": document.id,
            "parsed_data": parsed_data,
            "status": document.status,
        }

    def create_draft_bill_from_ai(self, parsed_data, attachment_id):
        self.ensure_one()
        partner_name = (parsed_data or {}).get("vendor_name")
        if not partner_name:
            raise UserError("Vendor name is required to create a draft bill.")

        partner = self.env["res.partner"].search([("name", "=", partner_name)], limit=1)
        if not partner:
            partner = self.env["res.partner"].create({"name": partner_name, "supplier_rank": 1})

        keywords = ", ".join((parsed_data or {}).get("keywords", []))
        suggested_account = self.env["prema.ai.learning.engine"].suggest_account(partner.id, keywords)
        if not suggested_account:
            suggested_account = self.env["account.account"].search(
                [
                    ("company_id", "=", self.env.company.id),
                    ("account_type", "in", ["expense", "expense_direct_cost"]),
                    ("deprecated", "=", False),
                ],
                limit=1,
            )
        if not suggested_account:
            raise UserError("No suitable expense account found for draft bill line.")

        line_items = (parsed_data or {}).get("line_items") or []
        if not line_items:
            line_items = [{
                "description": "AI Suggested Expense",
                "quantity": 1.0,
                "unit_price": (parsed_data or {}).get("total_amount") or 0.0,
                "amount": (parsed_data or {}).get("total_amount") or 0.0,
            }]

        invoice_lines = []
        for item in line_items:
            quantity = item.get("quantity") or 1.0
            price_unit = item.get("unit_price")
            if price_unit is None:
                amount = item.get("amount") or 0.0
                price_unit = amount / quantity if quantity else amount
            invoice_lines.append((0, 0, {
                "name": item.get("description") or "AI Line",
                "quantity": quantity,
                "price_unit": price_unit,
                "account_id": suggested_account.id,
            }))

        bill_vals = {
            "move_type": "in_invoice",
            "partner_id": partner.id,
            "invoice_date": (parsed_data or {}).get("bill_date") or fields.Date.context_today(self),
            "invoice_line_ids": invoice_lines,
            "created_from_ai": True,
            "ai_session_id": self.id,
            "ai_detected_keywords": keywords,
        }
        bill = self.env["account.move"].create(bill_vals)

        attachment = self.env["ir.attachment"].browse(attachment_id)
        if attachment.exists():
            attachment.write({
                "res_model": "account.move",
                "res_id": bill.id,
            })

            document = self.env["prema.ai.document"].search(
                [
                    ("session_id", "=", self.id),
                    ("attachment_id", "=", attachment.id),
                ],
                limit=1,
            )
            if document:
                document.write({"status": "processed"})

        self.env["prema.ai.tool.log"].create({
            "user_id": self.env.user.id,
            "tool_name": "create_draft_bill",
            "input_payload": json.dumps({"attachment_id": attachment_id, "parsed_data": parsed_data}),
            "output_payload": json.dumps({"bill_id": bill.id}),
            "status": "executed",
            "session_id": self.id,
            "bill_id": bill.id,
        })

        return {
            "bill_id": bill.id,
            "bill_name": bill.name,
            "partner_id": partner.id,
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
