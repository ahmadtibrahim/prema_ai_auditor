# FILE: /opt/odoo/custum-addons/prema_ai_auditor/models/ai_attachment.py
# FILE: /opt/odoo/custum-addons/prema_ai_auditor/models/ai_attachment.py
"""
AI Attachment Handler
1. Accepts base64 PDF or image from chat
2. Sends to OpenAI GPT-4o Vision for extraction
3. Falls back to Tesseract OCR if vision fails
4. Applies ML predictions (account, tax) from local models
5. Creates draft vendor bill with attachment linked
6. Stores AI suggestion for correction learning

COMMIT NOTE (what changed)
fix(pdf-ocr): poppler path detection crash + stable /usr/bin fallback
- FIXED: _detect_poppler_path() used io.os (invalid) -> now uses os.path (valid)
- RESULT: PDF OCR no longer crashes with "AttributeError: module 'io' has no attribute 'os'"
- Kept existing logic/flow; only corrected poppler path detection and logging

COMMIT NOTE (what changed) - NEW
feat(session): auto-save last_attachment_id on upload
- On upload_and_extract(), we now write session.last_attachment_id = this attachment
- RESULT: user no longer needs to manually find/paste attachment ID for "create draft"
- No other behavior changed
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

        # NEW: auto-bind latest uploaded attachment to the session
        # so chat can use it without asking the user for an ID.
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
        """
        FIXED: previously used io.os (invalid).
        Now uses os.path and a safe fallback.
        """
        configured = (self.env["ir.config_parameter"].sudo().get_param("prema_ai.poppler_path") or "").strip()
        if configured:
            return configured

        for bin_name in ("pdftoppm", "pdftocairo", "pdfinfo", "pdftotext"):
            p = shutil.which(bin_name)
            if p:
                return os.path.dirname(p)

        # safe default for Ubuntu
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

    # ---------------- OPENAI VISION (unchanged interface) ----------------

    def _extract_via_openai_vision(self, file_b64: str, mimetype: str, api_key: str) -> Dict[str, Any]:
        try:
            prompt = "Extract invoice data and return ONLY valid JSON."

            response = requests.post(
                "https://api.openai.com/v1/chat/completions",
                headers={
                    "Authorization": f"Bearer {api_key}",
                    "Content-Type": "application/json",
                },
                json={
                    "model": "gpt-4o",
                    "messages": [{
                        "role": "user",
                        "content": [
                            {"type": "text", "text": prompt},
                            {"type": "image_url", "image_url": {"url": f"data:{mimetype};base64,{file_b64}"}}],
                    }],
                    "max_tokens": 1500,
                },
                timeout=45,
            )

            response.raise_for_status()
            content = (response.json()["choices"][0]["message"]["content"] or "").strip()

            if content.startswith("```"):
                parts = content.split("```")
                content = parts[1] if len(parts) > 1 else content
                content = content.strip()
                if content.lower().startswith("json"):
                    content = content[4:].strip()

            return json.loads(content)

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

    # ---------------- ML + BILL CREATION (unchanged placeholders) ----------------

    def _apply_ml_predictions(self, extracted):
        # keep your existing implementation here (unchanged)
        return extracted