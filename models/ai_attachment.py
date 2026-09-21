# FILE: /opt/odoo/custum-addons/prema_ai_auditor/models/ai_attachment.py
"""
AI Attachment Handler
1. Accepts base64 PDF or image from chat
2. Extracts text locally: PDF text layer / pdf2image+tesseract / tesseract
3. Parses the text into the logistics JSON schema via DeepSeek (text-only)
4. Applies ML predictions (account, tax) from local models
5. Creates draft vendor bill with attachment linked
6. Stores AI suggestion for correction learning

No OpenAI API is used — images never leave the server (tesseract OCR only).
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
        from odoo.addons.prema_ai_auditor.services import deepseek_client
        has_ai = bool(deepseek_client.get_api_key(self.env))

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
            # Local tesseract OCR → DeepSeek parse (no vision API)
            result = self._extract_image_via_tesseract(file_bytes)
            if result and "error" not in result and has_ai:
                parsed = self._parse_text_with_ai(result.get("raw_text", ""))
                if parsed and "error" not in parsed:
                    parsed["extraction_method"] = "image_ocr_ai"
                    return parsed
            return result

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
            from odoo.addons.prema_ai_auditor.services import deepseek_client
            if deepseek_client.get_api_key(self.env):
                result = self._parse_text_with_ai(text)
                if result and "error" not in result:
                    return result
            return {"raw_text": text[:4000], "extraction_method": "pdf_text_layer"}
        except Exception as e:
            return {"error": f"PDF extraction failed: {str(e)}"}

    # ---------------- AI TEXT PARSER ----------------

    _LOGISTICS_EXTRACTION_PROMPT = (
        "Extract freight/invoice document data and return ONLY valid JSON with these exact keys:\n"
        "vendor_name, invoice_number, invoice_date (YYYY-MM-DD), due_date (YYYY-MM-DD), currency,\n"
        "subtotal, tax_amount, total_amount,\n"
        "delivery_number (Delivery # or DR #),\n"
        "reference_number (Reference # or Ref #),\n"
        "booking_number (Booking #),\n"
        "bol_number (BOL # or Bill of Lading #),\n"
        "po_number (PO # or Purchase Order #),\n"
        "origin (pickup city or address),\n"
        "destination (delivery city or address),\n"
        "service_date (date of pickup or delivery, YYYY-MM-DD),\n"
        "line_items (list of {description, quantity, unit_price, amount}).\n"
        "Use null for missing fields. No markdown, no explanation."
    )

    def _parse_text_with_ai(self, raw_text: str) -> Dict[str, Any]:
        """Parse document text into the logistics JSON schema via DeepSeek."""
        try:
            from odoo.addons.prema_ai_auditor.services import deepseek_client
            raw = deepseek_client.deepseek_chat(
                self.env,
                [
                    {"role": "system", "content": (
                        "You are a logistics invoice parser. Return only valid JSON.")},
                    {"role": "user", "content": (
                        self._LOGISTICS_EXTRACTION_PROMPT
                        + "\n\nDOCUMENT TEXT:\n" + raw_text[:6000])},
                ],
                max_tokens=2000,
                temperature=0,
                timeout=60,
            )
            if not raw:
                return {"error": "AI parser returned empty response"}

            raw = re.sub(r"^```json\s*", "", raw.strip())
            raw = re.sub(r"\s*```$", "", raw.strip())
            parsed = json.loads(raw)
            parsed["extraction_method"] = "pdf_text_ai"
            return parsed

        except json.JSONDecodeError as e:
            return {"error": f"AI parser returned invalid JSON: {e}"}
        except Exception as e:
            _logger.warning("AI text parse failed: %s", e)
            return {"error": str(e)}

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

            from odoo.addons.prema_ai_auditor.services import deepseek_client
            if deepseek_client.get_api_key(self.env):
                result = self._parse_text_with_ai(text)
                if result and "error" not in result:
                    result["extraction_method"] = "pdf_ocr_ai"
                    return result
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

    def _build_reference(self, data: Dict[str, Any]) -> Optional[str]:
        prefix_map = [
            ("delivery_number", "DEL-"),
            ("reference_number", "REF-"),
            ("booking_number", "BK-"),
            ("bol_number", "BOL-"),
            ("po_number", "PO-"),
        ]
        known_prefixes = ("DEL-", "REF-", "BK-", "BOL-", "PO-")
        parts = []
        for key, prefix in prefix_map:
            val = (data.get(key) or "").strip()
            if not val:
                continue
            # Strip the prefix if the AI already included it in the value
            upper = val.upper()
            for kp in known_prefixes:
                if upper.startswith(kp):
                    val = val[len(kp):]
                    break
            if val:
                parts.append(f"{prefix}{val}")
        return " | ".join(parts) if parts else (data.get("invoice_number") or None)

    def _build_line_description(self, data: Dict[str, Any]) -> str:
        origin = (data.get("origin") or "").strip()
        destination = (data.get("destination") or "").strip()
        service_date = (data.get("service_date") or data.get("invoice_date") or "").strip()

        parts = ["Freight / Delivery Service"]
        if origin and destination:
            parts.append(f"Route: {origin} → {destination}")
        elif origin:
            parts.append(f"Origin: {origin}")
        elif destination:
            parts.append(f"Destination: {destination}")
        if service_date:
            parts.append(f"Date: {service_date}")
        return "\n".join(parts)

    def _create_draft_bill(self, data):
        try:
            partner = self._find_or_create_vendor(data.get("vendor_name"))

            ref = self._build_reference(data)
            line_desc = self._build_line_description(data)
            _logger.info("AI bill create | method=%s ref=%s vendor=%s",
                         data.get("extraction_method"), ref, data.get("vendor_name"))

            move_vals = {
                "move_type": "in_invoice",
                "partner_id": partner.id if partner else False,
                "ref": ref,
                "invoice_date": data.get("invoice_date") or False,
                "invoice_date_due": data.get("due_date") or False,
                "invoice_line_ids": [],
            }

            lines = data.get("line_items") or []
            if lines:
                for line in lines:
                    move_vals["invoice_line_ids"].append((0, 0, {
                        "name": line_desc,
                        "quantity": float(line.get("quantity", 1) or 1),
                        "price_unit": float(line.get("unit_price", 0) or line.get("amount", 0) or 0),
                    }))
            else:
                total = float(data.get("total_amount", 0) or data.get("subtotal", 0) or 0)
                move_vals["invoice_line_ids"].append((0, 0, {
                    "name": line_desc,
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
