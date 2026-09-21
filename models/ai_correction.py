# FILE: /opt/odoo/custum-addons/prema_ai_auditor/models/ai_correction.py
"""
AI Correction Memory - stores user corrections with vendor bill fields.
Users can edit AI suggestions and click Apply to create a draft bill.
"""

import json
import logging

from odoo import api, fields, models

_logger = logging.getLogger(__name__)
RETRAIN_THRESHOLD = 10


class PremaAICorrection(models.Model):
    _name = "prema.ai.correction"
    _description = "Prema AI Correction Memory"
    _order = "create_date desc"

    user_id = fields.Many2one(
        "res.users", default=lambda self: self.env.user, index=True,
    )
    context_type = fields.Selection([
        ("bill_creation", "Bill Creation from Attachment"),
        ("fix_rejection", "Fix Rejected"),
        ("fix_modification", "Fix Modified Before Approval"),
        ("chat_correction", "Chat Response Corrected"),
    ], required=True)

    # Original AI fields
    ai_suggestion = fields.Text()
    user_correction = fields.Text()
    lesson = fields.Text()
    tags = fields.Char()
    applied_count = fields.Integer(default=0)

    # ---- Vendor bill fields (editable by user) ----
    vendor_name = fields.Char(string="Vendor Name")
    invoice_number = fields.Char(string="Invoice Number / Ref")
    invoice_date = fields.Date(string="Invoice Date")
    due_date = fields.Date(string="Due Date")
    currency = fields.Char(string="Currency", default="CAD")
    subtotal = fields.Float(string="Subtotal")
    tax_amount = fields.Float(string="Tax Amount")
    total_amount = fields.Float(string="Total Amount")
    line_description = fields.Text(string="Line Description")
    account_code = fields.Char(string="Account Code")

    # ---- AI suggestion mirror fields (read-only) ----
    ai_vendor_name = fields.Char(string="AI Vendor", readonly=True)
    ai_invoice_number = fields.Char(string="AI Invoice #", readonly=True)
    ai_invoice_date = fields.Date(string="AI Date", readonly=True)
    ai_total_amount = fields.Float(string="AI Total", readonly=True)
    ai_tax_amount = fields.Float(string="AI Tax", readonly=True)

    # ---- Link to draft bill ----
    draft_move_id = fields.Many2one(
        "account.move", string="Created Draft Bill", readonly=True,
    )
    state = fields.Selection([
        ("pending", "Pending"),
        ("applied", "Applied"),
    ], default="pending")

    # ---- Auto-populate from AI suggestion ----
    @api.model_create_multi
    def create(self, vals_list):
        records = super().create(vals_list)
        records._populate_from_ai_suggestion()
        return records

    def _populate_from_ai_suggestion(self):
        """Parse ai_suggestion JSON and fill vendor bill fields."""
        for rec in self:
            if not rec.ai_suggestion:
                continue
            try:
                data = json.loads(rec.ai_suggestion) if isinstance(
                    rec.ai_suggestion, str) else rec.ai_suggestion
                if not isinstance(data, dict):
                    continue

                vals = {}
                # AI mirror fields
                if data.get("vendor_name"):
                    vals["ai_vendor_name"] = data["vendor_name"]
                    if not rec.vendor_name:
                        vals["vendor_name"] = data["vendor_name"]
                if data.get("invoice_number"):
                    vals["ai_invoice_number"] = data["invoice_number"]
                    if not rec.invoice_number:
                        vals["invoice_number"] = data["invoice_number"]
                if data.get("invoice_date"):
                    vals["ai_invoice_date"] = data["invoice_date"]
                    if not rec.invoice_date:
                        vals["invoice_date"] = data["invoice_date"]
                if data.get("total_amount"):
                    vals["ai_total_amount"] = float(data["total_amount"] or 0)
                    if not rec.total_amount:
                        vals["total_amount"] = float(data["total_amount"] or 0)
                if data.get("tax_amount"):
                    vals["ai_tax_amount"] = float(data["tax_amount"] or 0)
                    if not rec.tax_amount:
                        vals["tax_amount"] = float(data["tax_amount"] or 0)
                if data.get("subtotal"):
                    if not rec.subtotal:
                        vals["subtotal"] = float(data["subtotal"] or 0)
                if data.get("due_date"):
                    if not rec.due_date:
                        vals["due_date"] = data["due_date"]
                if data.get("currency"):
                    if not rec.currency:
                        vals["currency"] = data["currency"]
                if data.get("line_items") and isinstance(data["line_items"], list):
                    descs = [li.get("description", "") for li in data["line_items"] if li.get("description")]
                    if descs and not rec.line_description:
                        vals["line_description"] = "\n".join(descs)

                if vals:
                    rec.write(vals)
            except Exception as e:
                _logger.debug("Correction populate error: %s", e)

    # ---- APPLY button: create draft bill from user-corrected values ----
    def action_apply(self):
        """Create a draft vendor bill from the user-corrected fields."""
        self.ensure_one()
        if self.state == "applied" and self.draft_move_id:
            return {
                "type": "ir.actions.act_window",
                "res_model": "account.move",
                "res_id": self.draft_move_id.id,
                "view_mode": "form",
                "target": "current",
            }

        # Find or create vendor
        partner = None
        if self.vendor_name:
            partner = self.env["res.partner"].sudo().search(
                [("name", "ilike", self.vendor_name),
                 ("supplier_rank", ">", 0)], limit=1)
            if not partner:
                partner = self.env["res.partner"].sudo().search(
                    [("name", "ilike", self.vendor_name)], limit=1)
            if not partner:
                partner = self.env["res.partner"].sudo().create({
                    "name": self.vendor_name,
                    "supplier_rank": 1,
                })

        total = self.total_amount or self.subtotal or 0
        move_vals = {
            "move_type": "in_invoice",
            "partner_id": partner.id if partner else False,
            "ref": self.invoice_number or False,
            "invoice_date": self.invoice_date or False,
            "invoice_date_due": self.due_date or False,
            "invoice_line_ids": [(0, 0, {
                "name": self.line_description or self.invoice_number or "Invoice line",
                "quantity": 1,
                "price_unit": total,
            })],
        }

        move = self.env["account.move"].sudo().create(move_vals)

        # Save user correction for ML learning
        user_vals = {
            "vendor_name": self.vendor_name,
            "invoice_number": self.invoice_number,
            "invoice_date": str(self.invoice_date) if self.invoice_date else None,
            "total_amount": self.total_amount,
            "tax_amount": self.tax_amount,
        }
        self.write({
            "state": "applied",
            "draft_move_id": move.id,
            "user_correction": json.dumps(user_vals, default=str),
        })

        # Trigger retrain check
        total_count = self.search_count([])
        if total_count % RETRAIN_THRESHOLD == 0:
            self._trigger_retrain()

        return {
            "type": "ir.actions.act_window",
            "res_model": "account.move",
            "res_id": move.id,
            "view_mode": "form",
            "target": "current",
        }

    # ---- Existing methods (UNCHANGED) ----
    @api.model
    def record_correction(self, context_type, ai_suggestion, user_correction, tags=""):
        lesson = _generate_lesson(context_type, ai_suggestion, user_correction)
        existing = self.search([
            ("context_type", "=", context_type),
            ("lesson", "=", lesson),
        ], limit=1)
        if existing:
            existing.applied_count += 1
            return existing.id

        record = self.create({
            "context_type": context_type,
            "ai_suggestion": (
                json.dumps(ai_suggestion, default=str)
                if not isinstance(ai_suggestion, str) else ai_suggestion
            ),
            "user_correction": (
                json.dumps(user_correction, default=str)
                if not isinstance(user_correction, str) else user_correction
            ),
            "lesson": lesson,
            "tags": tags,
        })

        total = self.search_count([])
        if total % RETRAIN_THRESHOLD == 0:
            self._trigger_retrain()
        return record.id

    @api.model
    def get_relevant_lessons(self, context_type=None, tags=None, limit=10):
        domain = []
        if context_type:
            domain.append(("context_type", "=", context_type))
        if tags:
            for tag in [t.strip() for t in tags.split(",")][:3]:
                domain.append(("tags", "ilike", tag))
        corrections = self.search(
            domain, order="applied_count desc, create_date desc", limit=limit)
        return [
            {"lesson": c.lesson, "context": c.context_type, "count": c.applied_count}
            for c in corrections
        ]

    @api.model
    def build_memory_prompt(self, context_type=None, tags=None):
        lessons = self.get_relevant_lessons(
            context_type=context_type, tags=tags, limit=8)
        if not lessons:
            return ""
        lines = ["--- Learned from past user corrections ---"]
        for l in lessons:
            lines.append("- {}".format(l["lesson"]))
        lines.append("--- End corrections ---")
        return "\n".join(lines)

    @api.model
    def trigger_retrain(self):
        self._trigger_retrain()
        return {"success": True}

    def _trigger_retrain(self):
        try:
            from ..services.ml.engine import retrain_all
            retrain_all(self.env)
        except Exception as e:
            _logger.warning("ML retrain failed: %s", e)


def _generate_lesson(context_type, ai_suggestion, user_correction):
    try:
        if context_type == "bill_creation":
            ai = ai_suggestion if isinstance(ai_suggestion, dict) else json.loads(ai_suggestion or "{}")
            uc = user_correction if isinstance(user_correction, dict) else json.loads(user_correction or "{}")
            parts = []
            for field in ["partner_id", "account_id", "tax_ids", "ref", "amount_total"]:
                if ai.get(field) and uc.get(field) and str(ai[field]) != str(uc[field]):
                    parts.append("{}: '{}' -> '{}'".format(field, ai[field], uc[field]))
            if parts:
                return "Bill creation: " + "; ".join(parts)
        elif context_type == "fix_rejection":
            fix = ai_suggestion if isinstance(ai_suggestion, dict) else json.loads(ai_suggestion or "{}")
            reason = user_correction if isinstance(user_correction, str) else json.dumps(user_correction)
            return "Fix rejected on '{}': {}".format(fix.get("model", "?"), reason)
        elif context_type == "fix_modification":
            ai = ai_suggestion if isinstance(ai_suggestion, dict) else json.loads(ai_suggestion or "{}")
            uc = user_correction if isinstance(user_correction, dict) else json.loads(user_correction or "{}")
            return "Fix modified: {} -> {}".format(
                json.dumps(ai.get("values", {})), json.dumps(uc.get("values", {})))
    except Exception:
        pass
    return "Correction: {}".format(context_type)
