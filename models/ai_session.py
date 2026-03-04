import json
import logging
from odoo import models, fields, api

_logger = logging.getLogger(__name__)


class PremaAiSession(models.Model):
    _name = 'prema.ai.session'
    _description = 'Prema AI Session'
    _order = 'create_date desc'

    name = fields.Char(default='AI Session')
    user_id = fields.Many2one('res.users', default=lambda self: self.env.user)
    # FIX #1: No 'order' param here — ordering defined on message model below
    message_ids = fields.One2many('prema.ai.session.message', 'session_id', string='Messages')
    state = fields.Selection([('active', 'Active'), ('closed', 'Closed')], default='active')

    @api.model
    def get_or_create_session(self):
        session = self.search([('user_id', '=', self.env.uid), ('state', '=', 'active')], limit=1)
        if not session:
            session = self.create({'name': 'AI Session', 'user_id': self.env.uid})
        return session


class PremaAiSessionMessage(models.Model):
    _name = 'prema.ai.session.message'
    _description = 'Prema AI Message'
    _order = 'create_date asc, id asc'   # FIX #1: order lives HERE on the model

    session_id = fields.Many2one('prema.ai.session', ondelete='cascade', required=True)
    role = fields.Selection([('user', 'User'), ('assistant', 'Assistant'), ('system', 'System')],
                            required=True, default='user')
    content = fields.Text(required=True)
    attachment_ids = fields.Many2many(
        'ir.attachment',
        'prema_ai_msg_att_rel', 'message_id', 'attachment_id',
        string='Attachments'
    )
    metadata = fields.Text()

    def get_metadata(self):
        try:
            return json.loads(self.metadata or '{}')
        except Exception:
            return {}
