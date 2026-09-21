"""DeepSeek client tests — param resolution, response parsing, retries.

All network calls are mocked; nothing hits the DeepSeek API.
"""
from unittest import mock

from odoo.exceptions import UserError
from odoo.tests.common import TransactionCase

from odoo.addons.prema_ai_auditor.services import deepseek_client


class TestDeepSeekClient(TransactionCase):

    def test_param_resolution(self):
        ICP = self.env['ir.config_parameter'].sudo()
        ICP.set_param('deepseek.api_key', 'sk-test')
        ICP.set_param('deepseek.model', 'deepseek-chat')
        self.assertEqual(deepseek_client.get_api_key(self.env), 'sk-test')
        self.assertEqual(deepseek_client.get_model(self.env), 'deepseek-chat')

    def test_fallback_params(self):
        # the DB carries BOTH 'deepseek.api_key' (new name) and 'deepseek'
        # (legacy fallback) — clear both or get_api_key falls through
        ICP = self.env['ir.config_parameter'].sudo()
        ICP.set_param('deepseek.api_key', False)
        ICP.set_param('deepseek', False)
        ICP.set_param('deepseek.model', False)
        self.assertEqual(deepseek_client.get_api_key(self.env), '')
        self.assertEqual(deepseek_client.get_model(self.env),
                         deepseek_client.DEFAULT_MODEL)

    def test_missing_api_key_raises_user_error(self):
        ICP = self.env['ir.config_parameter'].sudo()
        ICP.set_param('deepseek.api_key', False)
        ICP.set_param('deepseek', False)
        with self.assertRaises(UserError):
            deepseek_client.deepseek_chat(self.env, [{'role': 'user',
                                                      'content': 'hi'}])

    def test_success_parses_content(self):
        self.env['ir.config_parameter'].sudo().set_param(
            'deepseek.api_key', 'sk-test')
        messages = [{'role': 'user', 'content': 'hi'}]
        with mock.patch.object(deepseek_client.requests, 'post') as post:
            resp = mock.Mock()
            resp.status_code = 200
            resp.ok = True
            resp.json.return_value = {
                'choices': [{'message': {'content': ' hello ' }}]}
            post.return_value = resp
            out = deepseek_client.deepseek_chat(self.env, messages)
        self.assertEqual(out, 'hello')
        post.assert_called_once()
        payload = post.call_args.kwargs['json']
        self.assertEqual(payload['messages'], messages)
        self.assertIn('Authorization', post.call_args.kwargs['headers'])

    def test_retry_on_429_then_success(self):
        from requests.exceptions import HTTPError
        self.env['ir.config_parameter'].sudo().set_param(
            'deepseek.api_key', 'sk-test')
        with mock.patch.object(deepseek_client.requests, 'post') as post:
            bad = mock.Mock(status_code=429, ok=False, headers={})
            bad.raise_for_status.side_effect = HTTPError('429')
            good = mock.Mock(status_code=200, ok=True)
            good.json.return_value = {
                'choices': [{'message': {'content': 'ok'}}]}
            post.side_effect = [bad, good]
            with mock.patch.object(deepseek_client.time, 'sleep'):
                out = deepseek_client.deepseek_chat(self.env, [], retries=1)
        self.assertEqual(out, 'ok')
        self.assertEqual(post.call_count, 2)

    def test_persistent_500_raises_user_error(self):
        from requests.exceptions import HTTPError
        self.env['ir.config_parameter'].sudo().set_param(
            'deepseek.api_key', 'sk-test')
        with mock.patch.object(deepseek_client.requests, 'post') as post:
            bad = mock.Mock(status_code=500, ok=False, headers={})
            bad.raise_for_status.side_effect = HTTPError('500')
            post.return_value = bad
            with mock.patch.object(deepseek_client.time, 'sleep'):
                with self.assertRaises(UserError):
                    deepseek_client.deepseek_chat(self.env, [], retries=1)
        self.assertEqual(post.call_count, 2)

    def test_retryable_timeout_recovers(self):
        from requests.exceptions import Timeout
        self.env['ir.config_parameter'].sudo().set_param(
            'deepseek.api_key', 'sk-test')
        with mock.patch.object(deepseek_client.requests, 'post') as post:
            good = mock.Mock(status_code=200, ok=True)
            good.json.return_value = {
                'choices': [{'message': {'content': 'recovered'}}]}
            post.side_effect = [Timeout('slow'), good]
            with mock.patch.object(deepseek_client.time, 'sleep'):
                out = deepseek_client.deepseek_chat(self.env, [], retries=1)
        self.assertEqual(out, 'recovered')
