# FILE: /opt/odoo/custum-addons/prema_ai_auditor/models/ai_config.py
"""
Prema AI Global Settings — singleton model.
Stores custom instructions, source reference files, attachment limits,
and structured rules framework for all chat modes.
"""

from odoo import api, fields, models


class PremaAISettings(models.Model):
    _name = "prema.ai.settings"
    _description = "Prema AI Settings"

    name = fields.Char(default="Prema AI Settings", readonly=True)

    # ── General Instructions ─────────────────────────────────────────
    custom_instructions = fields.Text(
        string="General AI Instructions",
        help=(
            "Additional instructions appended to the AI system prompt on every conversation. "
            "Use this for company rules, terminology, response style, or standing context.\n\n"
            "Example:\n"
            "- Always prioritise Canadian tax rules\n"
            "- Our fuel surcharge is 8 cents per km\n"
            "- Never quote rates without checking the load board first"
        ),
    )

    # ── Structured Rules Framework ────────────────────────────────────
    pricing_rules = fields.Text(
        string="Pricing Engine Rules",
        help="Rules the AI applies in Pricing Review mode: rate tables, surcharges, minimum margins, etc.",
    )
    lead_gen_instructions = fields.Text(
        string="Lead Generation Instructions",
        help="Instructions for the AI in Lead Generation mode: target corridors, ideal shipper profile, outreach tone.",
    )
    duplicate_prevention_rules = fields.Text(
        string="Duplicate Prevention Rules",
        help="Criteria the AI uses to detect and skip duplicate leads or vendors.",
    )
    routing_dispatch_rules = fields.Text(
        string="Routing / Dispatch Rules",
        help="Business rules for dispatch assignments, lane priorities, driver restrictions.",
    )
    cost_calc_rules = fields.Text(
        string="Cost Calculation Rules",
        help="Rules the AI applies in Logistics Estimate mode: fuel rates, overhead, margins, surcharges.",
    )
    messaging_rules = fields.Text(
        string="Messaging Rules",
        help="Tone, sign-off, and formatting rules for AI-drafted emails and messages.",
    )

    # ── Source Document Library ──────────────────────────────────────
    source_library_enabled = fields.Boolean(
        string="Enable Source Library",
        default=True,
        help="When enabled, the AI reads source reference files as background context in every session.",
    )
    source_attachment_ids = fields.Many2many(
        "ir.attachment",
        "prema_ai_settings_att_rel",
        "settings_id",
        "attachment_id",
        string="Source Reference Files",
        help=(
            "Upload PDFs, Word docs, or text files (rate cards, SOPs, compliance docs, broker agreements). "
            "The AI reads these as background context. Toggle 'Enable Source Library' to turn off without removing files."
        ),
    )

    # ── Attachment Limits (admin-configurable) ───────────────────────
    max_files_per_chat = fields.Integer(
        string="Max Files per Message",
        default=5,
        help="Maximum number of file attachments allowed per chat message.",
    )
    max_images_per_chat = fields.Integer(
        string="Max Images per Message",
        default=3,
        help="Maximum number of image attachments allowed per chat message.",
    )
    max_total_upload_mb = fields.Integer(
        string="Max Total Upload Size (MB)",
        default=50,
        help="Maximum combined file size in MB for attachments per message.",
    )
    allowed_file_types = fields.Char(
        string="Allowed File Types",
        default=".pdf,.jpg,.jpeg,.png,.webp,.gif,.tiff,.xlsx,.csv,.doc,.docx",
        help="Comma-separated list of allowed file extensions for chat attachments.",
    )

    @api.model
    def get_singleton(self):
        """Return (or create) the single global settings record."""
        rec = self.sudo().search([], limit=1)
        if not rec:
            rec = self.sudo().create({"name": "Prema AI Settings"})
        return rec

    @api.model
    def get_chat_limits(self):
        """Return attachment limits as a dict for the frontend."""
        cfg = self.get_singleton()
        return {
            "max_files_per_chat": cfg.max_files_per_chat or 5,
            "max_images_per_chat": cfg.max_images_per_chat or 3,
            "max_total_upload_mb": cfg.max_total_upload_mb or 50,
            "allowed_file_types": cfg.allowed_file_types or ".pdf,.jpg,.jpeg,.png,.webp,.gif,.tiff,.xlsx,.csv,.doc,.docx",
            "source_library_enabled": cfg.source_library_enabled,
        }

    @api.model
    def action_open(self):
        """Server-action target: open the singleton in a form view."""
        rec = self.get_singleton()
        return {
            "type": "ir.actions.act_window",
            "res_model": "prema.ai.settings",
            "res_id": rec.id,
            "view_mode": "form",
            "target": "current",
        }
