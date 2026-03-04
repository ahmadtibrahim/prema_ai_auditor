"""
OdooTools: Complete ORM access layer for Prema AI.
Gives the AI read/write/create access to all models + full system introspection.
"""
import json
import logging
from odoo import models, api, fields

_logger = logging.getLogger(__name__)


class OdooTools(models.AbstractModel):
    _name = 'prema.ai.odoo.tools'
    _description = 'Prema AI ORM Tools'

    # ── Generic ORM ──────────────────────────────────────────────────────────

    @api.model
    def read_records(self, model_name, domain=None, field_names=None, limit=50, order=None):
        try:
            M = self.env[model_name].sudo()
            recs = M.search(domain or [], limit=limit, order=order)
            return recs.read(field_names) if field_names else recs.read(self._safe_fields(M))
        except Exception as e:
            return {'error': str(e)}

    @api.model
    def count_records(self, model_name, domain=None):
        try:
            return self.env[model_name].sudo().search_count(domain or [])
        except Exception as e:
            return {'error': str(e)}

    @api.model
    def create_record(self, model_name, values):
        try:
            rec = self.env[model_name].sudo().create(values)
            return {'success': True, 'record_model': model_name, 'record_id': rec.id}
        except Exception as e:
            return {'error': str(e)}

    @api.model
    def update_record(self, model_name, record_id, values):
        try:
            rec = self.env[model_name].sudo().browse(record_id)
            if not rec.exists():
                return {'error': f'{model_name}/{record_id} not found'}
            rec.write(values)
            return {'success': True, 'record_id': record_id}
        except Exception as e:
            return {'error': str(e)}

    @api.model
    def search_records(self, model_name, domain, field_names=None, limit=100):
        return self.read_records(model_name, domain=domain, field_names=field_names, limit=limit)

    def _safe_fields(self, Model, max_fields=12):
        """Return a sensible subset of fields to avoid binary/compute overload."""
        skip_types = {'binary', 'serialized'}
        result = []
        for fname, f in Model._fields.items():
            if f.type not in skip_types and not fname.startswith('_'):
                result.append(fname)
            if len(result) >= max_fields:
                break
        return result or ['id', 'name']

    # ── Business Summaries ────────────────────────────────────────────────────

    @api.model
    def get_accounting_summary(self):
        try:
            M = self.env['account.move'].sudo()
            today = fields.Date.today()
            return {
                'draft_vendor_bills': M.search_count([('move_type', '=', 'in_invoice'), ('state', '=', 'draft')]),
                'posted_vendor_bills': M.search_count([('move_type', '=', 'in_invoice'), ('state', '=', 'posted')]),
                'draft_customer_invoices': M.search_count([('move_type', '=', 'out_invoice'), ('state', '=', 'draft')]),
                'overdue_invoices': M.search_count([
                    ('move_type', '=', 'out_invoice'), ('state', '=', 'posted'),
                    ('payment_state', 'not in', ['paid', 'in_payment']),
                    ('invoice_date_due', '<', today),
                ]),
                'total_partners': self.env['res.partner'].sudo().search_count([('customer_rank', '>', 0)]),
            }
        except Exception as e:
            return {'error': str(e)}

    @api.model
    def get_crm_summary(self):
        try:
            L = self.env['crm.lead'].sudo()
            return {
                'open_leads': L.search_count([('active', '=', True), ('type', '=', 'lead')]),
                'open_opportunities': L.search_count([('active', '=', True), ('type', '=', 'opportunity')]),
                'won_opportunities': L.search_count([('active', '=', True), ('stage_id.is_won', '=', True)]),
            }
        except Exception as e:
            return {'error': str(e)}

    @api.model
    def get_fleet_summary(self):
        try:
            V = self.env['fleet.vehicle'].sudo()
            return {
                'total_vehicles': V.search_count([]),
                'active_vehicles': V.search_count([('active', '=', True)]),
                'vehicles_needing_service': self.env['fleet.vehicle.log.services'].sudo().search_count([
                    ('state_id.done', '=', False)
                ]),
            }
        except Exception as e:
            return {'error': str(e)}

    @api.model
    def get_documents_summary(self):
        """Summarize Odoo Documents module state."""
        try:
            Doc = self.env['documents.document'].sudo()
            Folder = self.env['documents.folder'].sudo()
            return {
                'total_documents': Doc.search_count([]),
                'total_folders': Folder.search_count([]),
                'folders': [{'id': f.id, 'name': f.name} for f in Folder.search([], limit=50)],
            }
        except Exception as e:
            return {'error': str(e)}

    # ── System Introspection ──────────────────────────────────────────────────

    @api.model
    def list_installed_modules(self):
        mods = self.env['ir.module.module'].sudo().search([('state', '=', 'installed')], order='name')
        return [{'name': m.name, 'display_name': m.shortdesc} for m in mods]

    @api.model
    def list_models(self, keyword=None):
        domain = [('transient', '=', False)]
        if keyword:
            domain.append(('model', 'ilike', keyword))
        mods = self.env['ir.model'].sudo().search(domain, limit=100, order='model')
        return [{'model': m.model, 'name': m.name} for m in mods]

    @api.model
    def get_model_fields(self, model_name):
        try:
            fs = self.env['ir.model.fields'].sudo().search([
                ('model_id.model', '=', model_name),
                ('ttype', 'not in', ['binary']),
            ], limit=60, order='name')
            return [{'name': f.name, 'type': f.ttype, 'label': f.field_description} for f in fs]
        except Exception as e:
            return {'error': str(e)}

    @api.model
    def list_cron_jobs(self):
        crons = self.env['ir.cron'].sudo().search([], order='name')
        return [{'name': c.name, 'active': c.active,
                 'interval': f"{c.interval_number} {c.interval_type}",
                 'next_call': str(c.nextcall)} for c in crons]

    @api.model
    def list_mail_templates(self, keyword=None):
        domain = [('name', 'ilike', keyword)] if keyword else []
        ts = self.env['mail.template'].sudo().search(domain, limit=50, order='name')
        return [{'id': t.id, 'name': t.name, 'model': t.model} for t in ts]

    @api.model
    def get_system_params(self):
        p = self.env['ir.config_parameter'].sudo()
        return {k: p.get_param(k) for k in ['web.base.url', 'mail.catchall.domain', 'database.uuid']}

    @api.model
    def get_full_system_context(self):
        import os
        rules_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'rules', 'ai_governance_rules.txt')
        governance = open(rules_path).read() if os.path.exists(rules_path) else ''
        return {
            'installed_modules_count': self.env['ir.module.module'].sudo().search_count([('state', '=', 'installed')]),
            'models_count': self.env['ir.model'].sudo().search_count([]),
            'users_count': self.env['res.users'].sudo().search_count([('active', '=', True)]),
            'governance_rules': governance,
            'addon_paths': ['/opt/odoo/custom-addons', '/opt/odoo/custum-addons'],
            'erp_url': self.env['ir.config_parameter'].sudo().get_param('web.base.url'),
        }
