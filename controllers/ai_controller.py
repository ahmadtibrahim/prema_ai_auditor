"""
Prema AI HTTP Controller.
All JSON-RPC endpoints consumed by the OWL frontend.
"""
import base64
import json
import logging
from odoo import http
from odoo.http import request

_logger = logging.getLogger(__name__)

# ─────────────────────────────────────────────────────────────────────────────
# AI SYSTEM PROMPT — injected on every call
# ─────────────────────────────────────────────────────────────────────────────
_SYSTEM_PROMPT_BASE = """
You are Prema AI — an intelligent operational assistant embedded inside Odoo 18 Enterprise ERP.
You operate like a CEO with full visibility and control across the entire organization.

=== YOUR CAPABILITIES ===
You can perform ANY of these operations (always show a preview first, then wait for approval):

DOCUMENT MANAGEMENT:
- Find duplicate documents: "find duplicates in my documents"
- Organize into folders: "put all driver files into a folder called Driver Packets"
- Move documents: "move these invoices to the Vendor Bills folder"
- Tag documents: "tag all fleet documents with 'Fleet 2024'"
- Search documents: "find all PDF files named invoice"

ACCOUNTING:
- Create vendor bills from uploaded PDF invoices
- Review overdue invoices
- Analyze payment status
- Summarize financial position

CRM:
- Create leads and opportunities
- Review pipeline health
- Analyze deal stages

FLEET:
- Review vehicles needing service
- Analyze fleet costs

CALENDAR:
- Create meetings and events

SYSTEM:
- Audit Odoo configuration
- List installed modules
- Review cron jobs and mail templates
- Analyze model structures

=== BEHAVIOR RULES ===
1. Be CONCISE. Short answers. No essays.
2. Always present a preview before any action.
3. Wait for approval before executing.
4. Think like a CEO — be proactive about insights.
5. Use ✅ for completed actions, ⚠️ for warnings, 📋 for previews.

=== INTENT DETECTION ===
When the user asks you to DO something (not just explain), respond with a structured intent block
at the END of your message in this exact format:

<<<ACTION>>>
{
  "action_type": "find_duplicates|organize_documents|move_documents|tag_documents|create_vendor_bill|create_lead|create_meeting|system_audit|analyze_data|custom",
  "name": "Short task description",
  "payload": { ... action-specific data ... },
  "needs_data": true/false
}
<<<END_ACTION>>>

If you need more information from the user before creating the action, set "needs_data": true
and ask the specific question in your response text.
If no action is needed (just answering a question), do NOT include the ACTION block.

=== DOCUMENT ACTION PAYLOADS ===
find_duplicates: {"folder_id": null_or_id}
organize_documents: {"folder_name": "Driver Packets", "keywords": ["driver", "license", "permit"], "document_ids": []}
move_documents: {"document_ids": [1,2,3], "target_folder_id": 5}
tag_documents: {"document_ids": [1,2,3], "tag_names": ["Fleet 2024", "Important"]}
create_vendor_bill: {"invoice_data": { ... extracted fields ... }}
system_audit: {}
analyze_data: {"model": "account.move", "domain": [["state","=","draft"]]}
"""


class PremaAiController(http.Controller):

    # ── Session ───────────────────────────────────────────────────────────────

    @http.route('/prema_ai/session', type='json', auth='user', methods=['POST'])
    def get_session(self):
        session = request.env['prema.ai.session'].get_or_create_session()
        msgs = []
        for m in session.message_ids:
            msgs.append({'id': m.id, 'role': m.role, 'content': m.content,
                         'attachments': [{'id': a.id, 'name': a.name} for a in m.attachment_ids]})
        return {'session_id': session.id, 'messages': msgs}

    # ── Chat ──────────────────────────────────────────────────────────────────

    @http.route('/prema_ai/chat', type='json', auth='user', methods=['POST'])
    def chat(self, session_id, message, attachment_ids=None):
        env = request.env
        session = env['prema.ai.session'].browse(session_id)
        if not session.exists():
            return {'error': 'Session not found'}

        # Save user message
        user_msg = env['prema.ai.session.message'].create({
            'session_id': session.id,
            'role': 'user',
            'content': message or '',
            'attachment_ids': [(6, 0, attachment_ids or [])],
        })

        # Build live ERP context
        tools = env['prema.ai.odoo.tools']
        di = env['prema.ai.document.intelligence']
        live_context = self._build_live_context(tools, di)

        # Build conversation history
        history = []
        for m in session.message_ids.filtered(lambda x: x.id != user_msg.id).sorted('create_date'):
            history.append({'role': m.role, 'content': m.content})

        # Process attachments — extract invoice data if PDF/image
        attachment_context = ''
        auto_tasks = []
        if attachment_ids:
            for att_id in attachment_ids:
                invoice_data = di.process_attachment_for_invoice(att_id)
                if invoice_data and not invoice_data.get('error') and invoice_data.get('total_amount'):
                    attachment_context += f"\n\nExtracted invoice data:\n{json.dumps(invoice_data, default=str)}"
                    # Auto-create vendor bill preview task
                    preview_html = di.build_vendor_bill_preview_html(invoice_data)
                    task = env['prema.ai.task.queue'].create({
                        'session_id': session.id,
                        'name': f"Create vendor bill from {invoice_data.get('source_name', 'document')}",
                        'action_type': 'create_vendor_bill',
                        'payload': json.dumps({'invoice_data': invoice_data}, default=str),
                        'preview_html': preview_html,
                        'state': 'pending',
                    })
                    auto_tasks.append({'task_id': task.id, 'name': task.name, 'preview_html': preview_html})

        # Call AI
        full_message = (message or '') + attachment_context
        ai_response_raw = self._call_ai(
            system=_SYSTEM_PROMPT_BASE + f"\n\n=== LIVE ERP DATA ===\n{live_context}",
            history=history,
            user_message=full_message,
            env=env,
        )

        # Parse ACTION intent from AI response
        response_text, action_tasks = self._parse_ai_actions(ai_response_raw, session, env, di, tools)

        # Save assistant message
        env['prema.ai.session.message'].create({
            'session_id': session.id,
            'role': 'assistant',
            'content': response_text,
        })

        return {
            'response': response_text,
            'pending_tasks': auto_tasks + action_tasks,
        }

    def _build_live_context(self, tools, di):
        """Summarize live ERP state for AI context."""
        parts = []
        try:
            parts.append(f"Accounting: {json.dumps(tools.get_accounting_summary(), default=str)}")
        except Exception:
            pass
        try:
            parts.append(f"CRM: {json.dumps(tools.get_crm_summary(), default=str)}")
        except Exception:
            pass
        try:
            parts.append(f"Fleet: {json.dumps(tools.get_fleet_summary(), default=str)}")
        except Exception:
            pass
        try:
            parts.append(f"Documents: {json.dumps(tools.get_documents_summary(), default=str)}")
        except Exception:
            pass
        return '\n'.join(parts)

    def _parse_ai_actions(self, ai_response, session, env, di, tools):
        """
        Extract <<<ACTION>>> blocks from AI response.
        Creates prema.ai.task.queue records with previews.
        Returns (clean_text, list_of_task_dicts).
        """
        import re
        tasks = []
        clean = ai_response

        pattern = r'<<<ACTION>>>(.*?)<<<END_ACTION>>>'
        matches = re.findall(pattern, ai_response, re.DOTALL)

        for match in matches:
            try:
                action = json.loads(match.strip())
                if action.get('needs_data'):
                    continue  # AI needs more info, no task yet

                action_type = action.get('action_type', 'custom')
                payload = action.get('payload', {})

                # For document organization, scan documents to find matches
                preview_html = self._build_preview_for_action(action_type, payload, di, tools)

                task = env['prema.ai.task.queue'].create({
                    'session_id': session.id,
                    'name': action.get('name', action_type),
                    'action_type': action_type,
                    'payload': json.dumps(payload, default=str),
                    'preview_html': preview_html,
                    'state': 'pending',
                })
                tasks.append({'task_id': task.id, 'name': task.name, 'preview_html': preview_html})
            except Exception as e:
                _logger.warning("Action parse failed: %s | raw: %s", e, match[:200])

        # Remove ACTION blocks from displayed text
        clean = re.sub(pattern, '', ai_response, flags=re.DOTALL).strip()
        return clean, tasks

    def _build_preview_for_action(self, action_type, payload, di, tools):
        """Generate HTML preview for an action before execution."""
        try:
            if action_type == 'find_duplicates':
                result = di.find_duplicate_documents(folder_id=payload.get('folder_id'))
                return di.build_duplicate_preview_html(result)
                # Also hydrate payload with actual duplicate data for execution
            elif action_type == 'organize_documents':
                # Find matching documents for the proposed folder
                result = di.find_documents_for_folder(
                    folder_name=payload.get('folder_name', 'New Folder'),
                    keywords=payload.get('keywords', []),
                    model_name=payload.get('model_name'),
                    tag_names=payload.get('tag_names'),
                )
                # Inject found document IDs into payload
                payload['document_ids'] = [d['id'] for d in result.get('documents', [])]
                return di.build_organize_preview_html(payload.get('folder_name', 'Folder'), result)
            elif action_type == 'system_audit':
                ctx = tools.get_full_system_context()
                acc = tools.get_accounting_summary()
                return f"""<div class='prema-preview'><h5>🔍 System Audit</h5>
                    <p>Modules installed: <strong>{ctx.get('installed_modules_count')}</strong></p>
                    <p>Draft vendor bills: <strong>{acc.get('draft_vendor_bills', 0)}</strong></p>
                    <p>Overdue invoices: <strong>{acc.get('overdue_invoices', 0)}</strong></p>
                    </div>"""
            elif action_type == 'analyze_data':
                model = payload.get('model', 'account.move')
                count = tools.count_records(model, domain=payload.get('domain', []))
                return f"<div class='prema-preview'><h5>📊 Analyze {model}</h5><p>Records found: <strong>{count}</strong></p></div>"
        except Exception as e:
            _logger.warning("Preview build failed for %s: %s", action_type, e)
        return f"<div class='prema-preview'><p>Action: <strong>{action_type}</strong></p><p>{json.dumps(payload, default=str)[:300]}</p></div>"

    def _call_ai(self, system, history, user_message, env):
        """Call Anthropic Claude API."""
        import requests as rlib
        api_key = env['ir.config_parameter'].sudo().get_param('prema_ai.api_key', '')
        if not api_key or 'REPLACE' in api_key:
            return ("⚠️ **API key not set.**\n\n"
                    "Go to **Settings → Technical → System Parameters** and set `prema_ai.api_key` "
                    "to your Anthropic API key.")
        messages = list(history)[-20:]  # keep last 20 turns
        messages.append({'role': 'user', 'content': user_message})
        try:
            resp = rlib.post(
                'https://api.anthropic.com/v1/messages',
                headers={'x-api-key': api_key, 'anthropic-version': '2023-06-01',
                         'content-type': 'application/json'},
                json={'model': 'claude-opus-4-6', 'max_tokens': 2000,
                      'system': system, 'messages': messages},
                timeout=60,
            )
            resp.raise_for_status()
            return resp.json()['content'][0]['text']
        except Exception as e:
            _logger.error("AI API error: %s", e)
            return f"⚠️ AI service error: {e}"

    # ── Task Endpoints ────────────────────────────────────────────────────────

    @http.route('/prema_ai/tasks', type='json', auth='user', methods=['POST'])
    def get_tasks(self, session_id):
        tasks = request.env['prema.ai.task.queue'].search(
            [('session_id', '=', session_id)], order='create_date desc')
        return [{'id': t.id, 'name': t.name, 'action_type': t.action_type,
                 'state': t.state, 'preview_html': t.preview_html or '',
                 'result_url': t.get_result_url(),
                 'result_summary': t.result_summary or ''} for t in tasks]

    @http.route('/prema_ai/task/approve', type='json', auth='user', methods=['POST'])
    def approve_task(self, task_id):
        task = request.env['prema.ai.task.queue'].browse(task_id)
        if not task.exists():
            return {'error': 'Task not found'}
        task.action_approve()
        return {'state': task.state, 'result_url': task.get_result_url(),
                'result_summary': task.result_summary or task.error_message or '',
                'error': task.error_message}

    @http.route('/prema_ai/task/reject', type='json', auth='user', methods=['POST'])
    def reject_task(self, task_id):
        task = request.env['prema.ai.task.queue'].browse(task_id)
        if task.exists():
            task.action_reject()
        return {'state': 'rejected'}

    # ── Document Upload ───────────────────────────────────────────────────────

    @http.route('/prema_ai/upload', type='http', auth='user', methods=['POST'], csrf=False)
    def upload_document(self, **kwargs):
        file = kwargs.get('file')
        if not file:
            return request.make_response(
                json.dumps({'error': 'No file'}),
                headers=[('Content-Type', 'application/json')])
        content = file.read()
        att = request.env['ir.attachment'].sudo().create({
            'name': file.filename,
            'datas': base64.b64encode(content),
            'mimetype': file.content_type or 'application/octet-stream',
            'res_model': 'prema.ai.session',
        })
        return request.make_response(
            json.dumps({'attachment_id': att.id, 'name': att.name}),
            headers=[('Content-Type', 'application/json')])

    # ── System Info ───────────────────────────────────────────────────────────

    @http.route('/prema_ai/system/folders', type='json', auth='user', methods=['POST'])
    def list_folders(self):
        return request.env['prema.ai.document.intelligence'].list_folders()

    @http.route('/prema_ai/system/audit', type='json', auth='user', methods=['POST'])
    def system_audit(self):
        tools = request.env['prema.ai.odoo.tools']
        return {
            'accounting': tools.get_accounting_summary(),
            'crm': tools.get_crm_summary(),
            'fleet': tools.get_fleet_summary(),
            'documents': tools.get_documents_summary(),
            'system': tools.get_full_system_context(),
        }
