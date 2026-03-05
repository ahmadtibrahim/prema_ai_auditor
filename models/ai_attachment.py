# FILE: /opt/odoo/custum-addons/prema_ai_auditor/models/ai_attachment.py
"""
AI Attachment Handler
TASK 5: Vision model read from prema_ai.vision_model system parameter.
"""

import base64
import io
import json
import logging
import os
import re
import shutil
from typing import Any, Dict, Optional

import requests
from odoo import api, fields, models

_logger = logging.getLogger(__name__)

DEFAULT_VISION_MODEL = "gpt-4o"


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

    # ─── Upload & extract ───────────────────────────────────────────
    @api.model
    def upload_and_extract(self, session_id, filename, file_b64, mimetype):
        record = self.create({
            "session_id": session_id,
            "original_filename": filename,
            "file_data": file_b64,
            "mimetype": mimetype or "application/octet-stream",
            "state": "pending",
        })

        # Auto-bind to session
        session = self.env["prema.ai.session"].browse(session_id)
        if session.exists():
            session.last_attachment_id = record.id

        result = record._extract_data()
        if result.get("error"):
            record.write({"state": "error", "error_message": result["error"]})
            return {"error": result["error"], "attachment_id": record.id}

        # Apply ML predictions
        extracted = result.get("extracted", {})
        extracted = record._apply_ml_predictions(extracted)

        record.write({
            "state": "extracted",
            "extracted_data": json.dumps(extracted, default=str),
        })
        return {"attachment_id": record.id, "extracted": extracted}

    # ─── Extraction dispatcher ──────────────────────────────────────
    def _extract_data(self):
        self.ensure_one()
        if not self.file_data:
            return {"error": "No file data"}

        file_bytes = base64.b64decode(self.file_data)
        mime = (self.mimetype or "").lower()
        param = self.env["ir.config_parameter"].sudo()
        api_key = param.get_param("openai.api_key")

        file_b64 = self.file_data
        if isinstance(file_b64, bytes):
            file_b64 = file_b64.decode("utf-8")

        # Try OpenAI Vision first
        if api_key:
            vision_result = self._extract_via_openai_vision(file_b64, mime, api_key)
            if not vision_result.get("error"):
                return {"extracted": vision_result}
            _logger.warning(
                "OpenAI Vision failed, falling back to OCR: %s",
                vision_result.get("error"),
            )

        # Fallback to local OCR
        if "pdf" in mime:
            ocr_result = self._extract_pdf_via_ocr(file_bytes)
        elif mime.startswith("image/"):
            ocr_result = self._extract_image_via_tesseract(file_bytes)
        else:
            return {"error": f"Unsupported file type: {mime}"}

        if ocr_result.get("error"):
            return ocr_result

        return {"extracted": self._parse_raw_text(ocr_result.get("raw_text", ""))}

    # ─── TASK 5: OpenAI Vision — model from system parameter ───────
    def _extract_via_openai_vision(self, file_b64, mimetype, api_key):
        try:
            param = self.env["ir.config_parameter"].sudo()
            model = param.get_param("prema_ai.vision_model", DEFAULT_VISION_MODEL)

            prompt = (
                "Extract invoice data from this document and return ONLY valid JSON with keys: "
                "vendor_name, invoice_number, invoice_date, due_date, currency, "
                "subtotal, tax_amount, total_amount, line_items (list of {description, quantity, unit_price, amount}). "
                "Use null for missing fields. No markdown, no explanation."
            )

            image_url = f"data:{mimetype};base64,{file_b64}"

            response = requests.post(
                "https://api.openai.com/v1/chat/completions",
                headers={
                    "Authorization": f"Bearer {api_key}",
                    "Content-Type": "application/json",
                },
                json={
                    "model": model,
                    "messages": [{
                        "role": "user",
                        "content": [
                            {"type": "text", "text": prompt},
                            {"type": "image_url", "image_url": {"url": image_url}},
                        ],
                    }],
                    "max_tokens": 2000,
                    "temperature": 0,
                },
                timeout=120,
            )
            response.raise_for_status()
            data = response.json()
            raw = (data["choices"][0]["message"]["content"] or "").strip()

            # Clean markdown fences
            raw = re.sub(r"^```json\s*", "", raw)
            raw = re.sub(r"\s*```$", "", raw)

            parsed = json.loads(raw)
            parsed["extraction_method"] = "openai_vision"
            return parsed

        except json.JSONDecodeError as e:
            return {"error": f"Vision returned invalid JSON: {e}"}
        except Exception as e:
            return {"error": f"Vision API failed: {e}"}

    # ─── PDF OCR ────────────────────────────────────────────────────
    def _extract_pdf_via_ocr(self, file_bytes):
        try:
            from pdf2image import convert_from_bytes
            import pytesseract

            poppler_path = self._detect_poppler_path()
            images = convert_from_bytes(file_bytes, dpi=300, poppler_path=poppler_path)

            texts = []
            for img in images[:3]:
                texts.append(pytesseract.image_to_string(img))

            text = "\n".join([t for t in texts if t]).strip()
            if not text:
                return {"error": "OCR produced no text"}

            return {"raw_text": text[:4000], "extraction_method": "pdf_ocr_fallback"}
        except Exception as e:
            return {"error": f"PDF OCR failed: {e}"}

    def _detect_poppler_path(self):
        configured = (
            self.env["ir.config_parameter"]
            .sudo()
            .get_param("prema_ai.poppler_path") or ""
        ).strip()
        if configured:
            return configured

        for bin_name in ("pdftoppm", "pdftocairo", "pdfinfo", "pdftotext"):
            p = shutil.which(bin_name)
            if p:
                return os.path.dirname(p)

        return "/usr/bin"

    # ─── Image OCR ──────────────────────────────────────────────────
    def _extract_image_via_tesseract(self, image_bytes):
        try:
            from PIL import Image
            import pytesseract

            img = Image.open(io.BytesIO(image_bytes))
            text = (pytesseract.image_to_string(img) or "").strip()
            if not text:
                return {"error": "Image OCR produced no text"}
            return {"raw_text": text[:4000], "extraction_method": "image_tesseract"}
        except Exception as e:
            return {"error": f"OCR failed: {e}"}

    # ─── Raw text parser ────────────────────────────────────────────
    def _parse_raw_text(self, text):
        result = {"extraction_method": "ocr_text_parse", "raw_text": text[:2000]}

        # Simple regex extraction
        inv_match = re.search(r"(?:invoice|inv|bill)\s*#?\s*:?\s*(\S+)", text, re.I)
        if inv_match:
            result["invoice_number"] = inv_match.group(1)

        date_match = re.search(r"(\d{1,2}[/-]\d{1,2}[/-]\d{2,4})", text)
        if date_match:
            result["invoice_date"] = date_match.group(1)

        total_match = re.search(
            r"(?:total|amount\s*due|balance\s*due)\s*:?\s*\$?([\d,]+\.?\d*)", text, re.I,
        )
        if total_match:
            result["total_amount"] = total_match.group(1).replace(",", "")

        return result

    # ─── ML predictions ─────────────────────────────────────────────
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

    # ─── Process (create draft bill) ────────────────────────────────
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
            # Find or create vendor
            partner = self._find_or_create_vendor(data.get("vendor_name"))

            # Build move values
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

            # Attach original file
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

            # Store for correction learning
            try:
                self.env["prema.ai.correction"].record_correction(
                    context_type="bill_creation",
                    ai_suggestion=data,
                    user_correction=data,
                    tags="bill,ocr",
                )
            except Exception:
                pass

            # Log the action
            try:
                self.env["prema.ai.audit.log"].sudo().create({
                    "user_id": self.env.user.id,
                    "action_type": "create_draft_bill",
                    "model": "account.move",
                    "record_id": move.id,
                    "summary": f"Draft bill created from {self.original_filename}",
                    "status": "completed",
                })
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
            [("name", "ilike", vendor_name), ("supplier_rank", ">", 0)], limit=1,
        )
        if not partner:
            partner = self.env["res.partner"].search(
                [("name", "ilike", vendor_name)], limit=1,
            )
        if not partner:
            partner = self.env["res.partner"].create({
                "name": vendor_name,
                "supplier_rank": 1,
            })
        return partner
