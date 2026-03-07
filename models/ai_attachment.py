# FILE: /opt/odoo/custum-addons/prema_ai_auditor/models/ai_attachment.py
"""
AI Attachment Handler
1. Accepts base64 PDF or image from chat
2. Sends to OpenAI GPT-4o Vision for extraction (via /v1/responses)
3. Falls back to Tesseract OCR if vision fails
4. Applies ML predictions (account, tax) from local models
5. Creates draft vendor bill with attachment linked
6. Stores AI suggestion for correction learning

COMMIT NOTE (what changed)
fix(vision): switch _extract_via_openai_vision from /v1/chat/completions to /v1/responses
- Endpoint: /v1/chat/completions -> /v1/responses
- Body: messages -> input, max_tokens -> max_output_tokens, added instructions
- Parse: choices[0].message.content -> output_text
- Model read from prema_ai.vision_model system parameter (default gpt-4o)
- ALL OTHER LOGIC UNCHANGED
"""

import base64
import io
import os
import json
import logging
import re
import shutil
import subprocess
import tempfile
from typing import Any, Dict, Optional, Tuple

import requests

from odoo import api, fields, models

_logger = logging.getLogger(__name__)


class PremaAIAttachment(models.Model):
    _name = "prema.ai.attachment"
    _description = "Prema AI Attachment Bill Creator"

    session_id = fields.Many2one("prema.ai.session", ondelete="cascade", index=True)
    user_id = fields.Many2one("res.users", default=lambda self: self.env.user)
    original_filename = fields.Char()
    file_data = fields.Binary()
    mimetype = fields.Char()
    extracted_data = fields.Text()
    draft_move_id = fields.Many2one("account.move", string="Created Draft Bill")
    state = fields.Selection([
        ("pending", "Pending"),
        ("extracted", "Extracted"),
        ("draft_created", "Draft Created"),
        ("error", "Error"),
    ], default="pending")
    error_message = fields.Text()

    @api.model
    def upload_and_extract(self, session_id, filename, file_b64, mimetype):
        record = self.create({
            "session_id": session_id,
            "original_filename": filename,
            "file_data": file_b64,
            "mimetype": mimetype or "application/octet-stream",
            "state": "pending",
        })

        # auto-bind latest uploaded attachment to the session
        try:
            self.env["prema.ai.session"].browse(session_id).sudo().write({
                "last_attachment_id": record.id
            })
        except Exception as e:
            _logger.warning("Failed to set session.last_attachment_id: %s", e)

        extracted = record._extract_bill_data(file_b64, mimetype, filename)

        if "error" in extracted:
            record.write({"state": "error", "error_message": extracted["error"]})
            return {"error": extracted["error"], "attachment_id": record.id}

        enhanced = record._apply_ml_predictions(extracted)

        record.write({
            "state": "extracted",
            "extracted_data": json.dumps(enhanced, default=str),
        })

        return {
            "attachment_id": record.id,
            "extracted": enhanced,
            "message": "✅ Data extracted. Review and confirm.",
        }

    def _extract_bill_data(self, file_b64: str, mimetype: str, filename: str) -> Dict[str, Any]:
        api_key = self.env["ir.config_parameter"].sudo().get_param("openai.api_key") or None

        file_bytes, err = self._safe_b64decode(file_b64)
        if err:
            return {"error": err}

        is_pdf = ((mimetype or "").lower() == "application/pdf") or ((filename or "").lower().endswith(".pdf"))
        is_image = (mimetype or "").lower().startswith("image/") or (
            (filename or "").lower().endswith((".png", ".jpg", ".jpeg", ".webp", ".gif"))
        )

        if is_pdf:
            # 1) Try text-layer extraction first
            result = self._extract_from_pdf_text_layer(file_bytes)
            if result and "error" not in result:
                return result
            # 2) OCR fallback (scanned PDF)
            return self._extract_pdf_via_ocr(file_bytes)

        if is_image:
            if api_key:
                result = self._extract_via_openai_vision(file_b64, mimetype, api_key)
                if result and "error" not in result:
                    return result
            return self._extract_image_via_tesseract(file_bytes)

        return {"error": "Unsupported file type"}

    # ---------------- PDF TEXT LAYER ----------------

    def _extract_from_pdf_text_layer(self, file_bytes: bytes) -> Dict[str, Any]:
        try:
            import pdfplumber
            text_parts = []
            with pdfplumber.open(io.BytesIO(file_bytes)) as pdf:
                for page in pdf.pages[:3]:
                    t = page.extract_text(layout=True) or ""
                    if t.strip():
                        text_parts.append(t)
            text = "\n\n".join(text_parts).strip()
            if not text:
                return {"error": "No text layer found in PDF"}
            return {"raw_text": text[:4000], "extraction_method": "pdf_text_layer"}
        except Exception as e:
            return {"error": f"PDF extraction failed: {str(e)}"}

    # ---------------- PDF OCR ----------------

    def _extract_pdf_via_ocr(self, file_bytes: bytes) -> Dict[str, Any]:
        try:
            from pdf2image import convert_from_bytes
            import pytesseract

            poppler_path = self._detect_poppler_path()

            images = convert_from_bytes(
                file_bytes,
                dpi=300,
                poppler_path=poppler_path,
            )

            texts = []
            for img in images[:3]:
                texts.append(pytesseract.image_to_string(img))

            text = "\n".join([t for t in texts if t]).strip()
            if not text:
                return {"error": "OCR produced no text"}

            return {"raw_text": text[:4000], "extraction_method": "pdf_ocr_fallback"}

        except Exception as e:
            return {"error": f"PDF OCR failed: {str(e)}"}

    def _detect_poppler_path(self) -> Optional[str]:
        configured = (self.env["ir.config_parameter"].sudo().get_param("prema_ai.poppler_path") or "").strip()
        if configured:
            return configured

        for bin_name in ("pdftoppm", "pdftocairo", "pdfinfo", "pdftotext"):
            p = shutil.which(bin_name)
            if p:
                return os.path.dirname(p)

        return "/usr/bin"

    # ---------------- IMAGE OCR ----------------

    def _extract_image_via_tesseract(self, image_bytes: bytes) -> Dict[str, Any]:
        try:
            from PIL import Image
            import pytesseract

            img = Image.open(io.BytesIO(image_bytes))
            text = (pytesseract.image_to_string(img) or "").strip()

            if not text:
                return {"error": "Image OCR produced no text"}

            return {"raw_text": text[:4000], "extraction_method": "image_tesseract"}

        except Exception as e:
            return {"error": f"OCR failed: {str(e)}"}

    # ---------------- OPENAI VISION via /v1/responses ----------------

    def _extract_via_openai_vision(self, file_b64: str, mimetype: str, api_key: str) -> Dict[str, Any]:
        """
        Extract invoice data using OpenAI Vision via the Responses API.
        Endpoint: POST https://api.openai.com/v1/responses
        """
        try:
            param = self.env["ir.config_parameter"].sudo()
            model = param.get_param("prema_ai.vision_model", "gpt-4o")

            prompt = (
                "Extract invoice data from this document and return ONLY valid JSON with keys: "
                "vendor_name, invoice_number, invoice_date, due_date, currency, "
                "subtotal, tax_amount, total_amount, line_items "
                "(list of {description, quantity, unit_price, amount}). "
                "Use null for missing fields. No markdown, no explanation."
            )

            image_url = f"data:{mimetype};base64,{file_b64}"

            response = requests.post(
                "https://api.openai.com/v1/responses",
                headers={
                    "Authorization": f"Bearer {api_key}",
                    "Content-Type": "application/json",
                },
                json={
                    "model": model,
                    "instructions": "You are an invoice data extraction engine. Return only valid JSON.",
                    "input": [{
                        "role": "user",
                        "content": [
                            {"type": "input_text", "text": prompt},
                            {"type": "input_image", "image_url": image_url},
                        ],
                    }],
                    "max_output_tokens": 2000,
                    "temperature": 0,
                    "store": False,
                },
                timeout=120,
            )
            response.raise_for_status()
            data = response.json()

            # Extract text from response
            raw = data.get("output_text", "")
            if not raw:
                # Fallback: walk output array
                for item in data.get("output", []):
                    if item.get("type") == "message" and item.get("content"):
                        for block in item["content"]:
                            if block.get("type") == "output_text" and block.get("text"):
                                raw = block["text"]
                                break
                    if raw:
                        break

            if not raw:
                return {"error": "Vision returned empty response"}

            raw = raw.strip()

            # Clean markdown fences
            raw = re.sub(r"^```json\s*", "", raw)
            raw = re.sub(r"\s*```$", "", raw)

            parsed = json.loads(raw)
            parsed["extraction_method"] = "openai_vision"
            return parsed

        except json.JSONDecodeError as e:
            return {"error": f"Vision returned invalid JSON: {e}"}
        except requests.exceptions.HTTPError as e:
            body = ""
            try:
                body = e.response.text[:300] if e.response is not None else ""
            except Exception:
                pass
            _logger.warning("Vision API HTTP error: %s — %s", e, body)
            return {"error": f"Vision API error: {e}"}
        except Exception as e:
            _logger.warning("Vision extraction failed: %s", e)
            return {"error": str(e)}

    # ---------------- HELPERS ----------------

    def _safe_b64decode(self, file_b64: str) -> Tuple[bytes, Optional[str]]:
        try:
            if not file_b64:
                return b"", "Empty upload"
            return base64.b64decode(file_b64), None
        except Exception:
            return b"", "Invalid base64 payload"

    # ---------------- ML PREDICTIONS ----------------

    def _apply_ml_predictions(self, extracted):
        try:
            from ..services.ml.engine import (
                predict_account,
                predict_tax,
                check_duplicate_fingerprint,
            )

            vendor = extracted.get("vendor_name", "")
            desc = extracted.get("line_items", [{}])[0].get("description", "") if extracted.get("line_items") else ""

            account_pred = predict_account(vendor, desc)
            if account_pred:
                extracted["ml_suggested_account"] = account_pred

            tax_pred = predict_tax(vendor, float(extracted.get("total_amount", 0) or 0))
            if tax_pred:
                extracted["ml_suggested_tax"] = tax_pred

            dup = check_duplicate_fingerprint(
                self.env, vendor,
                extracted.get("invoice_number"),
                extracted.get("total_amount", 0),
            )
            if dup:
                extracted["ml_duplicate_warning"] = dup

        except Exception as e:
            _logger.debug("ML predictions skipped: %s", e)

        return extracted

    # ---------------- PROCESS (create draft bill) ----------------

    @api.model
    def process_attachment_by_id(self, attachment_id, confirmed=False):
        record = self.browse(attachment_id)
        if not record.exists():
            return {"error": "Attachment not found"}
        return record._process(confirmed=confirmed)

    def _process(self, confirmed=False):
        self.ensure_one()
        if self.state == "draft_created" and self.draft_move_id:
            return {"error": "Draft already created", "move_id": self.draft_move_id.id}

        if not self.extracted_data:
            return {"error": "No extracted data"}

        try:
            data = json.loads(self.extracted_data)
        except json.JSONDecodeError:
            return {"error": "Invalid extracted data JSON"}

        if not confirmed:
            return {"confirmation_required": True, "extracted": data}

        return self._create_draft_bill(data)

    def _create_draft_bill(self, data):
        try:
            partner = self._find_or_create_vendor(data.get("vendor_name"))

            move_vals = {
                "move_type": "in_invoice",
                "partner_id": partner.id if partner else False,
                "ref": data.get("invoice_number"),
                "invoice_date": data.get("invoice_date") or False,
                "invoice_date_due": data.get("due_date") or False,
                "invoice_line_ids": [],
            }

            lines = data.get("line_items") or []
            if lines:
                for line in lines:
                    move_vals["invoice_line_ids"].append((0, 0, {
                        "name": line.get("description", "Invoice line"),
                        "quantity": float(line.get("quantity", 1) or 1),
                        "price_unit": float(line.get("unit_price", 0) or line.get("amount", 0) or 0),
                    }))
            else:
                total = float(data.get("total_amount", 0) or data.get("subtotal", 0) or 0)
                move_vals["invoice_line_ids"].append((0, 0, {
                    "name": data.get("invoice_number") or "Invoice line",
                    "quantity": 1,
                    "price_unit": total,
                }))

            move = self.env["account.move"].sudo().create(move_vals)

            if self.file_data:
                self.env["ir.attachment"].sudo().create({
                    "name": self.original_filename or "invoice",
                    "type": "binary",
                    "datas": self.file_data,
                    "res_model": "account.move",
                    "res_id": move.id,
                    "mimetype": self.mimetype,
                })

            self.write({"state": "draft_created", "draft_move_id": move.id})

            try:
                self.env["prema.ai.correction"].record_correction(
                    context_type="bill_creation",
                    ai_suggestion=data,
                    user_correction=data,
                    tags="bill,ocr",
                )
            except Exception:
                pass

            return {
                "success": True,
                "move_id": move.id,
                "partner": partner.name if partner else "Unknown",
                "amount": data.get("total_amount"),
            }

        except Exception as e:
            self.write({"state": "error", "error_message": str(e)})
            _logger.error("Draft bill creation failed: %s", e)
            return {"error": str(e)}

    def _find_or_create_vendor(self, vendor_name):
        if not vendor_name:
            return None
        partner = self.env["res.partner"].search(
            [("name", "ilike", vendor_name), ("supplier_rank", ">", 0)], limit=1)
        if not partner:
            partner = self.env["res.partner"].search(
                [("name", "ilike", vendor_name)], limit=1)
        if not partner:
            partner = self.env["res.partner"].create({
                "name": vendor_name,
                "supplier_rank": 1,
            })
        return partner
