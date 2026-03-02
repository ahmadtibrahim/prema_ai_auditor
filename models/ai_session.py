# File: prema_ai_auditor/models/ai_session.py
# NOTE: replace existing content with this entire file.
from odoo import api, fields, models
from odoo.exceptions import UserError
import requests

class PremaAISession(models.Model):
    """
    Conversation model for the Prema AI assistant.  Each session stores the user who
    owns it, a name (for display) and related messages.  There is no document
    analysis here; instead the assistant uses the OpenAI responses API with
    GPT‑5 mini:contentReference[oaicite:5]{index=5} to answer questions and optionally call tools.
    """
    _name = 'prema.ai.session'
    _description = 'Prema AI Session'

    name = fields.Char(string='Session Name', default='AI Chat')
    user_id = fields.Many2one('res.users', default=lambda self: self.env.user, ondelete='cascade')
    message_ids = fields.One2many('prema.ai.message', 'session_id', string='Messages', order='create_date asc')

    # -------------------------------------------------------------------------
    # Session management (model methods)
    # -------------------------------------------------------------------------
    @api.model
    def list_sessions(self):
        """Return all sessions for the current user (id and name)."""
        sessions = self.search([('user_id', '=', self.env.user.id)], order='create_date desc')
        return sessions.read(['id', 'name'])

    @api.model
    def create(self, vals):
        """
        Override create to ensure user_id is set if not provided.  This method is
        still model‑level so it can be called via RPC with args = [ {vals} ].
        """
        if 'user_id' not in vals:
            vals['user_id'] = self.env.user.id
        return super().create(vals)

    @api.model
    def rename_session(self, session_id, new_name):
        """
        Rename a session.  Receives the record id and new name as separate
        positional arguments (RPC passes id first).  Use @api.model to allow
        calling without record IDs in the first argument.
        """
        session = self.browse(session_id)
        if not session.exists():
            raise UserError('Session not found')
        session.name = new_name
        return True

    @api.model
    def delete_session(self, session_id):
        """Delete a session and all its messages."""
        session = self.browse(session_id)
        if not session.exists():
            return False
        session.unlink()
        return True

    # -------------------------------------------------------------------------
    # Messaging API (record method)
    # -------------------------------------------------------------------------
    def send_message(self, message):
        """
        Send a user message to the assistant.  This method is called on a
        session record via RPC (ids first).  It creates a user message,
        calls OpenAI with full conversation context, stores the assistant
        response and returns the text to the frontend.
        """
        self.ensure_one()
        if not message:
            return ''
        # Store user message
        user_msg = self.env['prema.ai.message'].create({
            'session_id': self.id,
            'role': 'user',
            'content': message,
        })
        # Call OpenAI and get assistant reply
        assistant_reply = self._call_openai()
        # Store assistant reply
        self.env['prema.ai.message'].create({
            'session_id': self.id,
            'role': 'assistant',
            'content': assistant_reply,
        })
        return assistant_reply

    # -------------------------------------------------------------------------
    # Internal: OpenAI call and tool registry
    # -------------------------------------------------------------------------
    def _call_openai(self):
        """
        Use OpenAI Responses API with GPT‑5 mini to generate a reply.  Builds
        conversation history from `message_ids` and includes a system prompt
        instructing the model to use tools when appropriate.  Returns the
        assistant’s text reply.  Note: because GPT‑5 mini supports very long
        contexts (400k tokens input, 128k output):contentReference[oaicite:6]{index=6}, you can
        include all messages without truncation.
        """
        self.ensure_one()
        api_key = self.env['ir.config_parameter'].sudo().get_param('openai.api_key')
        if not api_key:
            raise UserError('OpenAI API key is missing (set system parameter openai.api_key)')
        # Build system prompt describing available tools and context
        system_text = (
            "You are Prema’s intelligent assistant integrated into Odoo 18. "
            "You have full ORM access to CRM, Accounting, Sales, Fleet, Helpdesk, "
            "Expenses, Calendar, Contacts and Documents modules. "
            "You can search records, create/update/delete entries, detect duplicate "
            "bills, summarise finances, reconcile transactions, analyse leads and "
            "provide actionable advice. When necessary you will call one of the "
            "following tools by name with JSON arguments: \n"
            "- search_records(model, domain, fields) → list of dicts\n"
            "- create_record(model, values) → id\n"
            "- update_record(model, record_id, values) → true\n"
            "- delete_record(model, record_id) → true\n"
            "- check_duplicate_bills() → list of duplicate invoices\n"
            "- financial_summary() → summary dict with total income, expenses and balance\n"
            "- crm_pipeline_analysis() → dict of leads by stage and probability\n"
            "- revenue_forecast() → forecasted revenues for the next periods.\n"
            "Always ask for confirmation before creating, updating or deleting records. "
            "Respond in English and include helpful reasoning and suggestions."
        )
        # Build conversation items.  The responses API expects an array of
        # objects with role and content.  Each content must be a list of
        # {type, text} items:contentReference[oaicite:7]{index=7}.  We convert all prior
        # messages into input_text items.
        items = []
        # System prompt first
        items.append({
            'role': 'system',
            'content': [ {'type': 'input_text', 'text': system_text} ],
        })
        # Past conversation
        for msg in self.message_ids:
            items.append({
                'role': msg.role,
                'content': [ {'type': 'input_text', 'text': msg.content} ],
            })
        # POST to OpenAI
        headers = {
            'Authorization': f'Bearer {api_key}',
            'Content-Type': 'application/json',
        }
        payload = {
            'model': 'gpt-5-mini',
            'input': items,
        }
        try:
            response = requests.post('https://api.openai.com/v1/responses',
                                      headers=headers, json=payload, timeout=60)
            response.raise_for_status()
            data = response.json()
            # Extract assistant text
            return data['output'][0]['content'][0]['text']
        except Exception as e:
            return f"[OpenAI error] {e}"

    # -------------------------------------------------------------------------
    # Tool registry – example implementations
    # -------------------------------------------------------------------------
    def _tool_registry(self):
        """
        Return a mapping of tool names to functions.  Tools are called by the
        assistant via the responses API.  All functions must accept JSON
        arguments and return JSON‑serialisable results.
        """
        return {
            'search_records': self._tool_search_records,
            'create_record': self._tool_create_record,
            'update_record': self._tool_update_record,
            'delete_record': self._tool_delete_record,
            'check_duplicate_bills': self._tool_check_duplicate_bills,
            'financial_summary': self._tool_financial_summary,
            'crm_pipeline_analysis': self._tool_crm_pipeline_analysis,
            'revenue_forecast': self._tool_revenue_forecast,
        }

    # --- basic CRUD tools ---
    def _tool_search_records(self, model, domain, fields=None):
        records = self.env[model].search_read(domain, fields)
        return records

    def _tool_create_record(self, model, values):
        rec = self.env[model].create(values)
        return rec.id

    def _tool_update_record(self, model, record_id, values):
        rec = self.env[model].browse(record_id)
        rec.write(values)
        return True

    def _tool_delete_record(self, model, record_id):
        rec = self.env[model].browse(record_id)
        rec.unlink()
        return True

    # --- business tools ---
    def _tool_check_duplicate_bills(self):
        """
        Find potential duplicate vendor bills (same vendor, same amount and date).
        Returns a list of invoice names.  This uses account.move with type
        'in_invoice'.
        """
        moves = self.env['account.move'].search([('move_type', '=', 'in_invoice')])
        duplicates = []
        seen = set()
        for mv in moves:
            key = (mv.partner_id.id, mv.amount_total, mv.invoice_date)
            if key in seen:
                duplicates.append(mv.name)
            else:
                seen.add(key)
        return duplicates

    def _tool_financial_summary(self):
        """Return a simple summary of total income, expenses and balance from journal entries."""
        income = self.env['account.move'].search([('move_type', '=', 'out_invoice')]).mapped('amount_total')
        expense = self.env['account.move'].search([('move_type', '=', 'in_invoice')]).mapped('amount_total')
        return {
            'total_income': sum(income),
            'total_expenses': sum(expense),
            'balance': sum(income) - sum(expense),
        }

    def _tool_crm_pipeline_analysis(self):
        """Analyse leads/opportunities and return counts by stage and average probability."""
        leads = self.env['crm.lead'].search([])
        stage_counts = {}
        prob_sum = 0.0
        for ld in leads:
            stage = ld.stage_id.name or 'No Stage'
            stage_counts[stage] = stage_counts.get(stage, 0) + 1
            prob_sum += ld.probability or 0.0
        avg_prob = (prob_sum / len(leads)) if leads else 0.0
        return {
            'stages': stage_counts,
            'average_probability': avg_prob,
        }

    def _tool_revenue_forecast(self):
        """
        Very simple revenue forecast: uses past six months of sales orders (SO).
        Returns the average monthly revenue and a naive forecast for next month.
        """
        today = fields.Date.today()
        six_months_ago = today - relativedelta(months=6)
        orders = self.env['sale.order'].search([('date_order', '>=', six_months_ago)])
        monthly = {}
        for so in orders:
            month = so.date_order.strftime('%Y-%m')
            monthly[month] = monthly.get(month, 0) + so.amount_total
        if monthly:
            avg_rev = sum(monthly.values()) / len(monthly)
            return {
                'monthly_revenues': monthly,
                'average_monthly_revenue': avg_rev,
                'next_month_forecast': avg_rev,
            }
        return {
            'monthly_revenues': {},
            'average_monthly_revenue': 0.0,
            'next_month_forecast': 0.0,
        }

# Message model remains unchanged
class PremaAIMessage(models.Model):
    _name = 'prema.ai.message'
    _description = 'Prema AI Message'

    session_id = fields.Many2one('prema.ai.session', ondelete='cascade')
    role = fields.Selection([('user', 'User'), ('assistant', 'Assistant')], required=True)
    content = fields.Text(required=True)
    create_date = fields.Datetime(default=lambda self: fields.Datetime.now())