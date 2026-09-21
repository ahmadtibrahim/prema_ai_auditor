"""Deterministic CRM analysis branch — 'analyze my crm' & friends.

Covers:
  - explicit phrases reach _handle_crm_analysis (ONE DeepSeek call, never
    _call_llm) and produce a pipeline-aware reply
  - read-only: no prema.ai.crm.action rows are created
  - LLM failure → deterministic markdown fallback with real stage names
  - plain pipeline reads ('show me the pipeline') still route to the
    operator (router) instead
  - bare 'analyze' does NOT trigger the heavy attachment scan
"""
import json
from unittest import mock

from odoo.tests.common import TransactionCase


def _ds_patch():
    return mock.patch(
        'odoo.addons.prema_ai_auditor.services.deepseek_client.deepseek_chat')


class TestCrmAnalysis(TransactionCase):
    @classmethod
    def setUpClass(cls):
        super().setUpClass()
        cls.st_outreach = cls.env.ref(
            'premafirm_ai_engine.crm_stage_outreach_sent')

    def _make_session(self):
        return self.env['prema.ai.session'].create({'name': 'Analysis'})

    def test_explicit_phrase_reaches_analysis_not_llm(self):
        session = self._make_session()
        self.env['crm.lead'].create({
            'name': 'Analysis Co', 'type': 'opportunity',
            'stage_id': self.st_outreach.id,
        })
        with _ds_patch() as ds, mock.patch.object(
                session.__class__, '_call_llm',
                side_effect=AssertionError('must not call _call_llm')):
            ds.return_value = 'mock narrative'
            reply = session.send_message('analyze my crm')
        self.assertIn('reply', reply)
        self.assertEqual(reply['reply'], 'mock narrative')
        ds.assert_called_once()
        # the snapshot given to DeepSeek carries real pipeline data
        snapshot = ds.call_args[0][1][-1]['content']
        self.assertIn('PIPELINE', snapshot)
        self.assertIn('OUTREACH SENT', snapshot)
        # read-only: zero audit rows
        self.assertEqual(self.env['prema.ai.crm.action'].search_count([]), 0)

    def test_llm_failure_falls_back_to_deterministic(self):
        session = self._make_session()
        with _ds_patch() as ds, mock.patch.object(
                session.__class__, '_call_llm',
                side_effect=AssertionError('must not call _call_llm')):
            ds.side_effect = Exception('api down')
            reply = session.send_message('pipeline health')
        body = reply['reply']
        self.assertIn('## Pipeline Health', body)
        self.assertIn('OUTREACH SENT', body)  # real stage names
        self.assertIn('unavailable', body)    # fallback note
        self.assertEqual(self.env['prema.ai.crm.action'].search_count([]), 0)

    def test_plain_pipeline_read_still_operator(self):
        session = self._make_session()
        with mock.patch.object(
                session.__class__, '_call_responses_text',
                return_value=json.dumps({'is_crm_operator': True,
                                         'intent': 'get_pipeline_summary'})), \
                _ds_patch() as ds:
            reply = session.send_message('show me the pipeline')
        self.assertIn('Pipeline summary', reply['reply'])
        ds.assert_not_called()  # deterministic branch did not run

    def test_bare_analyze_has_no_attachment_sections(self):
        session = self._make_session()
        out = session._gather_erp_context('analyze my crm')
        # the incident trigger: bare 'analyze' must not pull the heavy
        # attachment scan into the context
        self.assertNotIn('INVOICE ATTACHMENTS', out)
        self.assertNotIn('ODOO ATTACHMENTS', out)
        self.assertNotIn('SOURCE LIBRARY', out)

    def test_analysis_skipped_when_file_uploaded(self):
        session = self._make_session()
        with mock.patch.object(
                session.__class__, '_call_llm',
                return_value='file reply') as llm:
            reply = session.send_message(
                'analyze this file',
                attachment_data=[{'filename': 'x.pdf', 'file_b64': 'eA==',
                                  'mimetype': 'application/pdf'}])
        self.assertEqual(reply['reply'], 'file reply')
        llm.assert_called_once()
