import json
import logging
from odoo import models, fields, api, _
from odoo.exceptions import UserError

_logger = logging.getLogger(__name__)


class PremaAiTaskQueue(models.Model):
    _name = 'prema.ai.task.queue'
    _description = 'Prema AI Task Queue'
    _order = 'create_date desc'

    session_id = fields.Many2one('prema.ai.session')
    name = fields.Char(required=True)
    action_type = fields.Selection([
        ('create_vendor_bill',   'Create Vendor Bill'),
        ('create_lead',          'Create CRM Lead'),
        ('create_task',          'Create Task'),
        ('create_meeting',       'Create Meeting'),
        ('update_record',        'Update Record'),
        ('analyze_data',         'Analyze Data'),
        ('system_audit',         'System Audit'),
        ('find_duplicates',      'Find Duplicate Documents'),
        ('organize_documents',   'Organize Documents into Folder'),
        ('move_documents',       'Move Documents'),
        ('tag_documents',        'Tag Documents'),
        ('custom',               'Custom Action'),
    ], required=True)
    state = fields.Selection([
        ('pending',   'Pending Approval'),
        ('approved',  'Approved'),
        ('executing', 'Executing'),
        ('done',      'Done'),
        ('rejected',  'Rejected'),
        ('failed',    'Failed'),
    ], default='pending')
    payload = fields.Text()
    preview_html = fields.Html()
    result = fields.Text()
    result_record_model = fields.Char()
    result_record_id = fields.Integer()
    result_summary = fields.Text()
    error_message = fields.Text()
    user_id = fields.Many2one('res.users', default=lambda self: self.env.user)

    def get_payload(self):
        try:
            return json.loads(self.payload or '{}')
        except Exception:
            return {}

    def action_approve(self):
        self.ensure_one()
        if self.state != 'pending':
            raise UserError(_('Only pending tasks can be approved.'))
        self.state = 'approved'
        self._execute()

    def action_reject(self):
        self.ensure_one()
        self.state = 'rejected'

    def _execute(self):
        self.state = 'executing'
        try:
            result = self.env['prema.ai.executor'].execute(self)
            self.state = 'done'
            self.result = json.dumps(result, default=str)
            self.result_summary = result.get('summary', '')
            if result.get('record_model'):
                self.result_record_model = result['record_model']
                self.result_record_id = result.get('record_id', 0)
        except Exception as e:
            _logger.exception("Task %s failed: %s", self.id, e)
            self.state = 'failed'
            self.error_message = str(e)

    def get_result_url(self):
        if self.result_record_model and self.result_record_id:
            return f'/web#model={self.result_record_model}&id={self.result_record_id}&view_type=form'
        return None
