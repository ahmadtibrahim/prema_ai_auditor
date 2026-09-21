"""Prema AI CRM action audit trail.

One row per AI-performed CRM write: who (the Odoo user whose session
issued the request), when, what record, old/new values, the AI action
name, and the original request text. Complemented by an internal
chatter note (mail.mt_note) on the lead — internal notes are never
emailed to customers.

Read-only for all internal users, append-only (no unlink).
"""
import logging

from odoo import fields, models

_logger = logging.getLogger(__name__)


class PremaAiCrmAction(models.Model):
    _name = 'prema.ai.crm.action'
    _description = 'Prema AI CRM Action (audit trail)'
    _order = 'create_date desc, id desc'

    session_id = fields.Many2one('prema.ai.session',
                                 string='AI Session',
                                 ondelete='set null')
    user_id = fields.Many2one('res.users', string='Acting User',
                              required=True, index=True,
                              default=lambda self: self.env.user)
    lead_id = fields.Many2one('crm.lead', string='Lead / Opportunity',
                              ondelete='cascade', index=True)
    action = fields.Char(string='AI Action', required=True, index=True)
    old_value = fields.Text(string='Old Value')
    new_value = fields.Text(string='New Value')
    request_text = fields.Text(string='AI Request / Context')
    outcome = fields.Selection([('done', 'Done'),
                                ('preview', 'Previewed (not applied)'),
                                ('error', 'Error')],
                               string='Outcome', default='done')
    create_date = fields.Datetime(string='Timestamp', readonly=True,
                                  index=True)
