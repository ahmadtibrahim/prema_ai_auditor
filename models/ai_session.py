from odoo import api, models, fields
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

    def action_rename_session(self, new_name):
        self.ensure_one()

        if self.user_id != self.env.user:
            raise UserError("You can only rename your own chat sessions.")

        sanitized_name = (new_name or "").strip()
        if not sanitized_name:
            raise UserError("Session name cannot be empty.")

        self.write({"name": sanitized_name})
        return {"id": self.id, "name": sanitized_name}

    def action_delete_session(self):
        self.ensure_one()

        if self.user_id != self.env.user:
            raise UserError("You can only delete your own chat sessions.")

        self.unlink()
        return True

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
        self.ensure_one()
        session_id = False
        if args:
            first_arg = args[0]
            if isinstance(first_arg, int):
                session_id = first_arg
            elif isinstance(first_arg, (list, tuple)) and first_arg:
                session_id = first_arg[0]

        attachment_id = kwargs.get("attachment_id")

        if not session_id:
            raise UserError("Session context missing.")

        session = self.browse(session_id)
        session.ensure_one()
        if session.user_id != self.env.user:
            raise UserError("You can only analyze documents in your own sessions.")

        if not attachment_id:
            raise UserError("attachment_id is required.")

        api_key = self.env["ir.config_parameter"].sudo().get_param("openai.api_key")
        if not api_key:
            raise UserError("OpenAI API key not configured.")

        attachment = self.env["ir.attachment"].browse(attachment_id)
        if not attachment:
            raise UserError("No document uploaded.")

        if not attachment.datas:
            raise UserError("Empty file.")

        if attachment.res_model != "prema.ai.session" or attachment.res_id != session.id:
            raise UserError("Attachment does not belong to this session.")

        if isinstance(attachment.datas, bytes):
            base64_string = attachment.datas.decode("utf-8")
        else:
            base64_string = attachment.datas

        mimetype = attachment.mimetype or "application/octet-stream"
        file_data = f"data:{mimetype};base64,{base64_string}"

        payload = {
            "model": "gpt-4.1-mini",
            "input": [
                {
                    "role": "user",
                    "content": [
                        {"type": "input_file", "file_data": file_data},
                        {"type": "input_text", "text": "Extract structured invoice data as JSON only."},
                    ],
                }
            ],
        }

        try:
            response = requests.post(
                "https://api.openai.com/v1/responses",
                headers={
                    "Authorization": f"Bearer {api_key}",
                    "Content-Type": "application/json",
                },
                json=payload,
                timeout=60,
            )
        except requests.RequestException as exc:
            raise UserError(f"OpenAI request failed: {exc}")

        if response.status_code != 200:
            raise UserError(response.text)

        try:
            data = response.json()
        except ValueError as exc:
            raise UserError(f"OpenAI response is not valid JSON: {exc}")
        text_output = ""
        for block in data.get("output", []):
            for item in block.get("content", []):
                if item.get("type") == "output_text":
                    text_output += item.get("text", "")

        if not text_output:
            raise UserError("AI returned empty result.")

        parsed_data = None
        if text_output:
            try:
                parsed_data = json.loads(text_output)
            except json.JSONDecodeError:
                parsed_data = None

        document_vals = {
            "name": attachment.name,
            "attachment_id": attachment.id,
            "session_id": session.id,
            "status": "analyzed",
            "ai_summary": text_output,
        }

        if parsed_data:
            document_vals.update({
                "vendor_name": parsed_data.get("vendor_name"),
                "invoice_number": parsed_data.get("invoice_number"),
                "invoice_date": parsed_data.get("invoice_date"),
                "subtotal": parsed_data.get("subtotal"),
                "tax": parsed_data.get("tax"),
                "total": parsed_data.get("total"),
                "line_items": json.dumps(parsed_data.get("line_items", [])),
            })

        document = self.env["prema.ai.document"].create(document_vals)

        self.env["prema.ai.tool.log"].create({
            "user_id": self.env.user.id,
            "tool_name": "analyze_document",
            "input_payload": json.dumps({"attachment_id": attachment_id}),
            "output_payload": text_output,
            "status": "executed",
            "session_id": session.id,
        })

        return {
            "document_id": document.id,
            "parsed_data": parsed_data or text_output,
            "status": document.status,
        }

    @api.model
    def create_draft_bill_from_ai(self, *args, **kwargs):
        session_id = False
        if args:
            first_arg = args[0]
            if isinstance(first_arg, int):
                session_id = first_arg
            elif isinstance(first_arg, (list, tuple)) and first_arg:
                session_id = first_arg[0]

        if not session_id:
            raise UserError("Session context missing.")

        session = self.browse(session_id)
        session.ensure_one()
        if session.user_id != self.env.user:
            raise UserError("You can only create draft bill suggestions in your own sessions.")

        parsed_data = kwargs.get("parsed_data")
        attachment_id = kwargs.get("attachment_id")
        if not parsed_data or not attachment_id:
            raise UserError("parsed_data and attachment_id are required")

        if isinstance(parsed_data, str):
            try:
                parsed_data = json.loads(parsed_data)
            except json.JSONDecodeError:
                raise UserError("parsed_data must be valid JSON")

        if not isinstance(parsed_data, dict):
            raise UserError("parsed_data must be a JSON object")

        vendor_name = parsed_data.get("vendor_name") or "Unknown Vendor"
        partner = self.env["res.partner"].search([("name", "=ilike", vendor_name)], limit=1)
        if not partner:
            partner = self.env["res.partner"].create({"name": vendor_name})

        invoice_number = parsed_data.get("invoice_number")
        invoice_date = parsed_data.get("invoice_date")
        existing = self.env["account.move"].search([
            ("move_type", "=", "in_invoice"),
            ("partner_id", "=", partner.id),
            ("invoice_date", "=", invoice_date),
            ("ref", "=", invoice_number),
        ], limit=1)
        if existing:
            raise UserError("A bill with this vendor and invoice number already exists.")

        expense_account = self.env["account.account"].search([
            ("account_type", "=", "expense"),
        ], limit=1)
        if not expense_account:
            raise UserError("No expense account found to build draft bill suggestion.")

        move_vals = {
            "move_type": "in_invoice",
            "partner_id": partner.id,
            "invoice_date": invoice_date,
            "ref": invoice_number,
            "invoice_line_ids": [],
        }

        line_items = parsed_data.get("line_items") or []
        if not isinstance(line_items, list):
            raise UserError("line_items must be an array")

        for line in line_items:
            if not isinstance(line, dict):
                continue
            move_vals["invoice_line_ids"].append((0, 0, {
                "name": line.get("description") or "AI extracted line",
                "quantity": line.get("quantity", 1),
                "price_unit": line.get("unit_price", 0.0),
                "account_id": expense_account.id,
            }))

        tool_log = self.env["prema.ai.tool.log"].create({
            "user_id": self.env.user.id,
            "session_id": session.id,
            "tool_name": "create_draft_bill_from_ai",
            "input_payload": json.dumps({"parsed_data": parsed_data, "attachment_id": attachment_id}),
            "output_payload": json.dumps(move_vals),
            "status": "suggested",
        })

        self.env["prema.ai.document"].search([
            ("session_id", "=", session.id),
            ("attachment_id", "=", attachment_id),
        ], limit=1).write({"status": "draft_created"})

        return {
            "bill_name": invoice_number,
            "tool_log_id": tool_log.id,
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

        try:
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
            response.raise_for_status()
            data = response.json()
        except requests.RequestException as exc:
            raise UserError(f"OpenAI chat request failed: {exc}")
        except ValueError as exc:
            raise UserError(f"OpenAI chat response is not valid JSON: {exc}")

        output = data.get("output", [])
        if not output:
            raise UserError("No output returned from OpenAI.")

        tool_call = next((item for item in output if item.get("type") == "tool_call"), None)
        if tool_call:
            tool_name = tool_call.get("name")
            if not tool_name:
                raise UserError("OpenAI returned a tool call without a tool name.")

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

        text_output = ""
        for block in output:
            for item in block.get("content", []):
                if item.get("type") == "output_text":
                    text_output += item.get("text", "")

        if not text_output:
            text_output = "I could not generate a response."

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
