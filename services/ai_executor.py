"""
AI Executor: Dispatches approved tasks. Only called after user approval.
"""
import logging
from odoo import models, api

_logger = logging.getLogger(__name__)


class PremaAiExecutor(models.AbstractModel):
    _name = 'prema.ai.executor'
    _description = 'Prema AI Task Executor'

    @api.model
    def execute(self, task):
        handler = getattr(self, f'_exec_{task.action_type}', self._exec_unknown)
        payload = task.get_payload()
        result = handler(payload, task)
        self.env['prema.ai.audit.log'].create({
            'session_id': task.session_id.id if task.session_id else False,
            'task_id': task.id,
            'action': task.action_type,
            'model_name': result.get('record_model', ''),
            'record_id': result.get('record_id', 0),
            'details': str(result)[:2000],
            'success': 'error' not in result,
        })
        return result

    def _exec_unknown(self, payload, task):
        return {'error': f'No handler for action type: {task.action_type}'}

    # ── Document Actions ──────────────────────────────────────────────────────

    def _exec_find_duplicates(self, payload, task):
        di = self.env['prema.ai.document.intelligence']
        result = di.find_duplicate_documents(folder_id=payload.get('folder_id'))
        # Auto-remove if payload says so, otherwise just return the result
        if payload.get('auto_remove') and result.get('duplicates'):
            return di.remove_duplicates(result['duplicates'])
        return {**result, 'success': True,
                'summary': f"Found {result['duplicate_groups']} duplicate groups in {result['total_scanned']} documents."}

    def _exec_organize_documents(self, payload, task):
        di = self.env['prema.ai.document.intelligence']
        return di.organize_documents_into_folder(
            folder_name=payload['folder_name'],
            document_ids=payload['document_ids'],
            parent_folder_id=payload.get('parent_folder_id'),
        )

    def _exec_move_documents(self, payload, task):
        di = self.env['prema.ai.document.intelligence']
        return di.move_documents(payload['document_ids'], payload['target_folder_id'])

    def _exec_tag_documents(self, payload, task):
        di = self.env['prema.ai.document.intelligence']
        return di.tag_documents(payload['document_ids'], payload['tag_names'])

    def _exec_create_vendor_bill(self, payload, task):
        di = self.env['prema.ai.document.intelligence']
        return di.create_vendor_bill(payload['invoice_data'])

    # ── Business Record Actions ───────────────────────────────────────────────

    def _exec_create_lead(self, payload, task):
        tools = self.env['prema.ai.odoo.tools']
        vals = payload.get('values', {}); vals.setdefault('type', 'opportunity')
        return tools.create_record('crm.lead', vals)

    def _exec_create_task(self, payload, task):
        return self.env['prema.ai.odoo.tools'].create_record('project.task', payload.get('values', {}))

    def _exec_create_meeting(self, payload, task):
        return self.env['prema.ai.odoo.tools'].create_record('calendar.event', payload.get('values', {}))

    def _exec_update_record(self, payload, task):
        tools = self.env['prema.ai.odoo.tools']
        return tools.update_record(payload.get('model'), payload.get('record_id'), payload.get('values', {}))

    def _exec_analyze_data(self, payload, task):
        tools = self.env['prema.ai.odoo.tools']
        records = tools.read_records(payload.get('model', 'account.move'),
                                     domain=payload.get('domain', []), limit=50)
        return {'success': True, 'count': len(records) if isinstance(records, list) else 0,
                'records': records[:10] if isinstance(records, list) else records,
                'summary': f"Analyzed {payload.get('model')} records."}

    def _exec_system_audit(self, payload, task):
        tools = self.env['prema.ai.odoo.tools']
        return {
            'success': True,
            'system_context': tools.get_full_system_context(),
            'accounting': tools.get_accounting_summary(),
            'crm': tools.get_crm_summary(),
            'fleet': tools.get_fleet_summary(),
            'documents': tools.get_documents_summary(),
            'summary': 'Full system audit completed.',
        }

    def _exec_custom(self, payload, task):
        tools = self.env['prema.ai.odoo.tools']
        op = payload.get('operation', 'read')
        if op == 'read':
            return tools.read_records(payload.get('model'), domain=payload.get('domain', []),
                                      field_names=payload.get('fields'), limit=payload.get('limit', 20))
        elif op == 'create':
            return tools.create_record(payload.get('model'), payload.get('values', {}))
        elif op == 'update':
            return tools.update_record(payload.get('model'), payload.get('record_id'), payload.get('values', {}))
        return {'error': 'Unknown operation'}
