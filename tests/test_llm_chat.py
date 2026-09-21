"""DeepSeek-era chat caps — history window, context budget, attachments.

Covers:
  - _call_llm history: ≤20 messages, ~30K char budget, newest retained,
    no image/parts arrays (text-only)
  - _ctx_invoice_attachments capped at 5 files
  - image uploads go through the OCR-to-text branch
"""
import base64
import io as _io
from unittest import mock

from odoo.tests.common import TransactionCase


def _ds_patch():
    return mock.patch(
        'odoo.addons.prema_ai_auditor.services.deepseek_client.deepseek_chat')


class TestLlmChatCaps(TransactionCase):

    def _make_session(self):
        return self.env['prema.ai.session'].create({'name': 'ChatCaps'})

    def test_history_window_and_newest_retained(self):
        session = self._make_session()
        for i in range(30):
            self.env['prema.ai.message'].create({
                'session_id': session.id,
                'role': 'user' if i % 2 == 0 else 'assistant',
                'content': ('old msg %02d ' % i) + ('x' * 150)})
        with _ds_patch() as ds:
            ds.return_value = 'ok'
            session.send_message('the final question')
        msgs = ds.call_args[0][1]
        # system prompt is message 0
        self.assertEqual(msgs[0]['role'], 'system')
        # 1 ERP context + 1 'loaded' ack + 20 history (19 old + the new
        # user message just created)
        hist = [m for m in msgs if m['role'] in ('user', 'assistant')]
        self.assertEqual(len(hist), 22)
        self.assertEqual(hist[-1]['content'], 'the final question')
        contents = [m['content'] for m in hist]
        self.assertFalse(any(c.startswith('old msg 00') for c in contents))
        self.assertTrue(any(c.startswith('old msg 29') for c in contents))
        # no image/parts arrays anywhere — plain-string content only
        for m in msgs:
            self.assertIsInstance(m['content'], str)

    def test_history_char_budget_drops_long_old_messages(self):
        session = self._make_session()
        for i in range(3):
            self.env['prema.ai.message'].create({
                'session_id': session.id, 'role': 'user',
                'content': ('fat %d ' % i) + ('y' * 12000)})
        with _ds_patch() as ds:
            ds.return_value = 'ok'
            session.send_message('final')
        msgs = ds.call_args[0][1]
        contents = [m['content'] for m in msgs if m['role'] in ('user',
                                                                'assistant')]
        # newest first: 'final' + 'fat 2' + 'fat 1' fit the 30K budget;
        # 'fat 0' crosses it and is dropped
        self.assertEqual(sum(1 for c in contents if c.startswith('fat')), 2)
        self.assertTrue(any(c.startswith('fat 2') for c in contents))
        self.assertFalse(any(c.startswith('fat 0') for c in contents))

    def test_invoice_attachments_capped_at_five(self):
        session = self._make_session()
        journal = (self.env['account.journal'].search(
            [('type', '=', 'purchase')], limit=1)
            or self.env['account.journal'].search([], limit=1))
        move = self.env['account.move'].create({
            'move_type': 'in_invoice',
            'journal_id': journal.id,
        })
        for i in range(7):
            self.env['ir.attachment'].create({
                'name': 'inv_att_%d.txt' % i,
                'res_model': 'account.move',
                'res_id': move.id,
                'datas': base64.b64encode(b'hello from file %d' % i),
                'mimetype': 'text/plain',
            })
        out = session._ctx_invoice_attachments()
        self.assertIn('=== INVOICE ATTACHMENTS — 5 files scanned ===', out)
        self.assertNotIn('inv_att_5.txt', out)
        self.assertNotIn('inv_att_6.txt', out)

    def test_image_upload_ocrs_to_text(self):
        session = self._make_session()
        buf = _io.BytesIO()
        from PIL import Image
        Image.new('RGB', (10, 10), 'white').save(buf, format='PNG')
        b64 = base64.b64encode(buf.getvalue()).decode()
        with mock.patch('pytesseract.image_to_string',
                        return_value='FAKE OCR RESULT'):
            text = session._extract_b64_file_content(
                b64, 'image/png', 'photo.png')
        self.assertIn('FAKE OCR RESULT', text)

    def test_unreadable_image_returns_empty(self):
        session = self._make_session()
        with mock.patch('pytesseract.image_to_string', return_value=''):
            text = session._extract_b64_file_content(
                base64.b64encode(b'not really an image').decode(),
                'image/png', 'broken.png')
        self.assertEqual(text, '')
