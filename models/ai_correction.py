# FILE: /opt/odoo/custum-addons/prema_ai_auditor/models/ai_correction.py
"""
AI Correction Memory — stores user corrections and triggers ML retraining.
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
    ai_suggestion = fields.Text()
    user_correction = fields.Text()
    lesson = fields.Text()
    tags = fields.Char()
    applied_count = fields.Integer(default=0)

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
            domain, order="applied_count desc, create_date desc", limit=limit,
        )
        return [
            {"lesson": c.lesson, "context": c.context_type, "count": c.applied_count}
            for c in corrections
        ]

    @api.model
    def build_memory_prompt(self, context_type=None, tags=None):
        lessons = self.get_relevant_lessons(
            context_type=context_type, tags=tags, limit=8,
        )
        if not lessons:
            return ""
        lines = ["--- Learned from past user corrections ---"]
        for l in lessons:
            lines.append("• {}".format(l["lesson"]))
        lines.append("--- End corrections ---")
        return "\n".join(lines)

    @api.model
    def trigger_retrain(self):
        self._trigger_retrain()
        return {"success": True}

    def _trigger_retrain(self):
        try:
            from ..services.ml.engine import retrain_all
            result = retrain_all(self.env)
            _logger.info("Prema ML retrain complete: %s", result)
        except Exception as e:
            _logger.warning("Prema ML retrain failed: %s", e)


def _generate_lesson(context_type, ai_suggestion, user_correction):
    try:
        if context_type == "bill_creation":
            ai = (
                ai_suggestion
                if isinstance(ai_suggestion, dict)
                else json.loads(ai_suggestion or "{}")
            )
            uc = (
                user_correction
                if isinstance(user_correction, dict)
                else json.loads(user_correction or "{}")
            )
            parts = []
            for field in ["partner_id", "account_id", "tax_ids", "ref", "amount_total"]:
                if ai.get(field) and uc.get(field) and str(ai[field]) != str(uc[field]):
                    parts.append("{}: '{}' → '{}'".format(field, ai[field], uc[field]))
            if parts:
                return "Bill creation: " + "; ".join(parts)
        elif context_type == "fix_rejection":
            fix = (
                ai_suggestion
                if isinstance(ai_suggestion, dict)
                else json.loads(ai_suggestion or "{}")
            )
            reason = (
                user_correction
                if isinstance(user_correction, str)
                else json.dumps(user_correction)
            )
            return "Fix rejected on '{}' ({}): {}".format(
                fix.get("model", "?"), fix.get("description", ""), reason,
            )
        elif context_type == "fix_modification":
            ai = (
                ai_suggestion
                if isinstance(ai_suggestion, dict)
                else json.loads(ai_suggestion or "{}")
            )
            uc = (
                user_correction
                if isinstance(user_correction, dict)
                else json.loads(user_correction or "{}")
            )
            return "Fix modified on '{}': {} → {}".format(
                ai.get("model", "?"),
                json.dumps(ai.get("values", {})),
                json.dumps(uc.get("values", {})),
            )
    except Exception:
        pass
    return "Correction recorded for: {}".format(context_type)
