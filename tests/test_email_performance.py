"""Cold-email performance branch — 'which cold mail got me results'.

Covers:
  - explicit email phrases reach _handle_email_performance (ONE DeepSeek
    call, never _call_llm) and produce a ranking-aware reply
  - the snapshot handed to DeepSeek carries real subject/reply data
  - LLM failure → deterministic markdown fallback with real subjects
  - read-only: no prema.ai.crm.action rows are created
  - non-email phrases return None (CRM analysis / operator untouched)
"""
import json
from unittest import mock

from odoo.tests.common import TransactionCase

from odoo.addons.prema_ai_auditor.services import crm_operator

SUBJ_A = ('Weekly LTL & FTL Route Availability: Toronto, Ottawa and '
          'Montreal corridor')
SUBJ_B = 'Carrier Introduction - Mississauga Based Fleet'


def _ds_patch():
    return mock.patch(
        'odoo.addons.prema_ai_auditor.services.deepseek_client.deepseek_chat')


class TestEmailPerformance(TransactionCase):
    @classmethod
    def setUpClass(cls):
        super().setUpClass()
        cls.st_outreach = cls.env.ref(
            'premafirm_ai_engine.crm_stage_outreach_sent')

    def _make_session(self):
        return self.env['prema.ai.session'].create({'name': 'EmailPerf'})

    def _seed(self):
        """One lead with an outbound + Re: reply under SUBJ_A, one lead
        messaged under SUBJ_B with no reply (and no stage movement).

        Uses direct mail.message.create: message_post() does not persist a
        subject on note messages. The clone carries the full prod history,
        so thread assertions below are merge-tolerant (looked up by key)."""
        subtype = self.env.ref('mail.mt_note').id
        lead_a = self.env['crm.lead'].create({
            'name': 'Reply Co', 'type': 'opportunity',
            'stage_id': self.st_outreach.id,
        })
        lead_b = self.env['crm.lead'].create({
            'name': 'Silent Co', 'type': 'opportunity',
            'stage_id': self.st_outreach.id,
        })
        for lead, subject in ((lead_a, SUBJ_A), (lead_b, SUBJ_B)):
            self.env['mail.message'].create({
                'model': 'crm.lead', 'res_id': lead.id,
                'message_type': 'email', 'subtype_id': subtype,
                'subject': subject, 'body': 'cold outbound',
                'email_from': 'premafirm@example.com',
            })
        self.env['mail.message'].create({
            'model': 'crm.lead', 'res_id': lead_a.id,
            'message_type': 'email', 'subtype_id': subtype,
            'subject': 'Re: ' + SUBJ_A, 'body': 'we are interested',
            'email_from': 'customer@example.com',
        })
        return lead_a, lead_b

    @staticmethod
    def _norm(subject):
        """Mirror the op's normalization (strip Re:/Fw: prefixes)."""
        s = (subject or '').strip()
        while True:
            low = s.lower()
            if low.startswith('re:'):
                s = s[3:].strip()
            elif low.startswith('fw:') or low.startswith('fwd:'):
                s = s[s.index(':') + 1:].strip()
            else:
                break
        return ' '.join(s.lower().split())

    def _row_by_subject(self, out, subject):
        """Find a ranked row whose normalized subject matches."""
        want = self._norm(subject)
        for r in out['top']:
            if self._norm(r.get('subject')) == want:
                return r
        return None

    def test_explicit_phrase_reaches_email_branch_not_llm(self):
        session = self._make_session()
        self._seed()
        with _ds_patch() as ds, mock.patch.object(
                session.__class__, '_call_llm',
                side_effect=AssertionError('must not call _call_llm')):
            ds.return_value = 'mock email analysis'
            reply = session.send_message(
                'which cold mail got me results the most')
        self.assertIn('reply', reply)
        self.assertEqual(reply['reply'], 'mock email analysis')
        ds.assert_called_once()
        # the snapshot given to DeepSeek carries real subject/reply data
        snapshot = ds.call_args[0][1][-1]['content']
        self.assertIn('COLD EMAIL PERFORMANCE SNAPSHOT', snapshot)
        self.assertIn(SUBJ_A[:30], snapshot)
        self.assertIn('replied 1 (100.0%)', snapshot)  # seeded reply thread
        # read-only: zero audit rows
        self.assertEqual(self.env['prema.ai.crm.action'].search_count([]), 0)

    def test_llm_failure_falls_back_to_deterministic(self):
        session = self._make_session()
        self._seed()
        with _ds_patch() as ds, mock.patch.object(
                session.__class__, '_call_llm',
                side_effect=AssertionError('must not call _call_llm')):
            ds.side_effect = Exception('api down')
            reply = session.send_message('which email got me results')
        body = reply['reply']
        self.assertIn('## Cold Mail Performance', body)
        self.assertIn(SUBJ_A[:30], body)   # real subject from the ranking
        self.assertIn('unavailable', body)  # fallback note
        self.assertEqual(self.env['prema.ai.crm.action'].search_count([]), 0)

    def test_op_ranks_by_replies(self):
        self._seed()
        # clone carries the full prod history — use a wide top and look up
        # the seeded threads by normalized subject
        out = crm_operator.op_get_email_performance(self.env, top=1000)
        self.assertGreater(out['total_threads'], 900)  # prod history present
        self.assertIn('open/click', out['note'])
        row_a = self._row_by_subject(out, SUBJ_A)
        row_b = self._row_by_subject(out, SUBJ_B)
        self.assertIsNotNone(row_a)
        self.assertIsNotNone(row_b)
        self.assertEqual(row_a['sent'], 1)        # only the seeded lead
        self.assertEqual(row_a['replied'], 1)     # Re: fingerprint
        self.assertIn('Reply Co', row_a['companies'])
        self.assertEqual(row_b['replied'], 0)     # silent thread
        self.assertEqual(row_b['sent'], 1)
        # ranking order: replied threads beat silent ones
        self.assertLess(out['top'].index(row_a), out['top'].index(row_b))

    def test_truncated_subjects_merge_into_full_thread(self):
        """Long subjects are stored truncated with '…' — a reply under the
        truncated form must merge into the full-subject thread."""
        subtype = self.env.ref('mail.mt_note').id
        lead_a = self.env['crm.lead'].create({
            'name': 'Reply Co', 'type': 'opportunity',
            'stage_id': self.st_outreach.id,
        })
        lead_c = self.env['crm.lead'].create({
            'name': 'Trunc Co', 'type': 'opportunity',
            'stage_id': self.st_outreach.id,
        })
        full = SUBJ_A
        truncated = SUBJ_A[:30] + '…'
        for lead, subject in ((lead_a, full), (lead_c, truncated)):
            self.env['mail.message'].create({
                'model': 'crm.lead', 'res_id': lead.id,
                'message_type': 'email', 'subtype_id': subtype,
                'subject': subject, 'body': 'cold outbound',
                'email_from': 'premafirm@example.com',
            })
        self.env['mail.message'].create({
            'model': 'crm.lead', 'res_id': lead_a.id,
            'message_type': 'email', 'subtype_id': subtype,
            'subject': 'Re: ' + full, 'body': 'replied',
            'email_from': 'customer@example.com',
        })
        self.env['mail.message'].create({
            'model': 'crm.lead', 'res_id': lead_c.id,
            'message_type': 'email', 'subtype_id': subtype,
            'subject': 'Re: ' + truncated, 'body': 'replied',
            'email_from': 'customer@example.com',
        })
        out = crm_operator.op_get_email_performance(self.env, top=1000)
        row = self._row_by_subject(out, full)
        self.assertIsNotNone(row)
        # both leads + both replies in ONE thread after the merge
        self.assertEqual(row['sent'], 2)
        self.assertEqual(row['replied'], 2)
        self.assertIn('Reply Co', row['companies'])
        self.assertIn('Trunc Co', row['companies'])
        # the truncated key no longer exists as its own thread
        self.assertIsNone(self._row_by_subject(out, truncated))

    def test_non_email_phrase_returns_none(self):
        session = self._make_session()
        # CRM analysis phrases are NOT email triggers
        self.assertIsNone(session._handle_email_performance('analyze my crm'))
        # plain pipeline reads are NOT email triggers
        self.assertIsNone(session._handle_email_performance(
            'show me the pipeline'))

    def test_plain_pipeline_read_still_operator(self):
        session = self._make_session()
        with mock.patch.object(
                session.__class__, '_call_responses_text',
                return_value=json.dumps({'is_crm_operator': True,
                                         'intent': 'get_pipeline_summary'})), \
                _ds_patch() as ds:
            reply = session.send_message('show me the pipeline')
        self.assertIn('Pipeline summary', reply['reply'])
        ds.assert_not_called()  # neither deterministic branch ran

    def test_email_analysis_skipped_when_file_uploaded(self):
        session = self._make_session()
        with mock.patch.object(
                session.__class__, '_call_llm',
                return_value='file reply') as llm, _ds_patch() as ds:
            reply = session.send_message(
                'which cold mail got me results',
                attachment_data=[{'filename': 'x.pdf', 'file_b64': 'eA==',
                                  'mimetype': 'application/pdf'}])
        self.assertEqual(reply['reply'], 'file reply')
        llm.assert_called_once()
        ds.assert_not_called()
