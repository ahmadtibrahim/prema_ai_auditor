"""Post-OpenAI era: bill-scan text parse via DeepSeek, image OCR → DeepSeek,
and voice transcription via local faster-whisper — never the OpenAI API.

Covers:
  - _parse_text_with_ai: mocked deepseek_client.deepseek_chat, invalid JSON
  - _extract_bill_data image path: mocked tesseract → DeepSeek parse (image_ocr_ai)
  - OCR-empty image → friendly error, no AI call
  - no DeepSeek key configured → raw OCR fallback, no AI call
  - transcribe_audio: mocked local_whisper.transcribe_bytes (no model download)
"""
import base64
import io as _io
from unittest import mock

from odoo.tests.common import TransactionCase


def _tiny_png_b64():
    buf = _io.BytesIO()
    from PIL import Image
    Image.new('RGB', (12, 12), 'white').save(buf, format='PNG')
    return base64.b64encode(buf.getvalue()).decode()


class TestBillExtractLocalAi(TransactionCase):

    def _attachment(self):
        return self.env['prema.ai.attachment'].create({
            'original_filename': 'scan.png',
            'file_data': _tiny_png_b64(),
            'mimetype': 'image/png',
        })

    def _patch_services(self, ds_text='{"vendor_name": "Acme Trucking"}', key='sk-test'):
        return (
            mock.patch(
                'odoo.addons.prema_ai_auditor.services.deepseek_client.deepseek_chat',
                return_value=ds_text),
            mock.patch(
                'odoo.addons.prema_ai_auditor.services.deepseek_client.get_api_key',
                return_value=key),
        )

    def test_parse_text_with_ai_uses_deepseek(self):
        att = self._attachment()
        with mock.patch(
                'odoo.addons.prema_ai_auditor.services.deepseek_client.deepseek_chat',
                return_value='{"vendor_name": "Acme Trucking", "invoice_number": "INV-9"}') as ds:
            out = att._parse_text_with_ai('SOME DOCUMENT TEXT')
        self.assertEqual(out['vendor_name'], 'Acme Trucking')
        self.assertEqual(out['extraction_method'], 'pdf_text_ai')
        # DeepSeek got the extraction prompt + the document text
        msgs = ds.call_args[0][1]
        self.assertEqual(msgs[0]['role'], 'system')
        self.assertIn('SOME DOCUMENT TEXT', msgs[1]['content'])

    def test_parse_text_with_ai_invalid_json_returns_error(self):
        att = self._attachment()
        with mock.patch(
                'odoo.addons.prema_ai_auditor.services.deepseek_client.deepseek_chat',
                return_value='not json at all'):
            out = att._parse_text_with_ai('SOME DOCUMENT TEXT')
        self.assertIn('error', out)
        self.assertIn('invalid JSON', out['error'])

    def test_image_ocr_then_deepseek_parse(self):
        att = self._attachment()
        ds, key = self._patch_services()
        with ds, key, mock.patch(
                'pytesseract.image_to_string',
                return_value='Acme Trucking  INVOICE #778  Total 1,200.00'):
            out = att._extract_bill_data(_tiny_png_b64(), 'image/png', 'scan.png')
        self.assertEqual(out['vendor_name'], 'Acme Trucking')
        self.assertEqual(out['extraction_method'], 'image_ocr_ai')

    def test_image_ocr_empty_no_ai_call(self):
        att = self._attachment()
        ds, key = self._patch_services()
        with ds as m_ds, key, mock.patch(
                'pytesseract.image_to_string', return_value='   '):
            out = att._extract_bill_data(_tiny_png_b64(), 'image/png', 'scan.png')
        self.assertEqual(out['error'], 'Image OCR produced no text')
        m_ds.assert_not_called()

    def test_image_no_ai_key_returns_raw_ocr(self):
        att = self._attachment()
        with mock.patch(
                'odoo.addons.prema_ai_auditor.services.deepseek_client.get_api_key',
                return_value=False), mock.patch(
                'pytesseract.image_to_string',
                return_value='Acme Trucking  INVOICE #778'):
            out = att._extract_bill_data(_tiny_png_b64(), 'image/png', 'scan.png')
        self.assertEqual(out['extraction_method'], 'image_tesseract')
        self.assertNotIn('vendor_name', out)


class TestTranscribeLocalWhisper(TransactionCase):

    def _session(self):
        return self.env['prema.ai.session'].create({'name': 'WhisperTest'})

    def test_transcribe_audio_returns_text(self):
        session = self._session()
        with mock.patch(
                'odoo.addons.prema_ai_auditor.services.local_whisper.transcribe_bytes',
                return_value={'text': 'hello from the call'}) as tb:
            out = session.transcribe_audio(
                base64.b64encode(b'fake-audio-bytes').decode(), 'audio/webm')
        self.assertEqual(out, {'text': 'hello from the call'})
        # ext derived from mimetype; decoded bytes passed through
        self.assertEqual(tb.call_args[0][1], 'webm')
        self.assertEqual(tb.call_args[0][0], b'fake-audio-bytes')

    def test_transcribe_audio_ext_mapping(self):
        session = self._session()
        for mime, ext in [('audio/mp4', 'mp4'), ('audio/wav', 'wav'),
                          ('audio/ogg', 'ogg'), ('application/octet-stream', 'webm')]:
            with mock.patch(
                    'odoo.addons.prema_ai_auditor.services.local_whisper.transcribe_bytes',
                    return_value={'text': 'x'}) as tb:
                session.transcribe_audio(base64.b64encode(b'data').decode(), mime)
            self.assertEqual(tb.call_args[0][1], ext, mime)

    def test_transcribe_audio_error_shape(self):
        session = self._session()
        with mock.patch(
                'odoo.addons.prema_ai_auditor.services.local_whisper.transcribe_bytes',
                return_value={'error': 'Transcription failed: boom'}):
            out = session.transcribe_audio(base64.b64encode(b'data').decode(), 'audio/webm')
        self.assertEqual(out, {'error': 'Transcription failed: boom'})
