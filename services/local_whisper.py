"""
Local Whisper transcription via faster-whisper — no API, no audio leaves the box.

Shared by the Prema AI chat voice button (Odoo worker) and the Asterisk call
transcriber (/opt/prema/call_transcriber.py, standalone — imports this FILE
directly via sys.path, NOT through the odoo.addons package, because the addon
package __init__ chain needs a booted Odoo).

Model: faster-whisper `base` (~145 MB) downloaded once into /opt/prema/whisper_models
on first use. Override with env PREMA_WHISPER_MODEL (e.g. 'small') and
PREMA_WHISPER_MODEL_DIR. The model is loaded lazily per-process and kept as a
module-level singleton (thread-safe init).
"""

import logging
import os
import tempfile
import threading

_logger = logging.getLogger(__name__)

MODEL_DIR = os.environ.get("PREMA_WHISPER_MODEL_DIR", "/opt/prema/whisper_models")
MODEL_NAME = os.environ.get("PREMA_WHISPER_MODEL", "base")

_LOCK = threading.Lock()
_MODEL = None


def _get_model():
    """Lazy-load the WhisperModel once per process (cpu/int8 for low RAM)."""
    global _MODEL
    if _MODEL is None:
        with _LOCK:
            if _MODEL is None:
                from faster_whisper import WhisperModel
                _logger.info("Loading local Whisper model %s (cpu/int8)…", MODEL_NAME)
                _MODEL = WhisperModel(
                    MODEL_NAME,
                    device="cpu",
                    compute_type="int8",
                    download_root=MODEL_DIR,
                )
                _logger.info("Local Whisper model %s loaded.", MODEL_NAME)
    return _MODEL


def transcribe_file(path, language="en"):
    """Transcribe an audio file. Returns {"text": ...} or {"error": ...}."""
    try:
        model = _get_model()
        segments, info = model.transcribe(str(path), language=language, beam_size=1)
        parts = [seg.text.strip() for seg in segments if seg.text and seg.text.strip()]
        text = " ".join(parts)
        _logger.info("Local Whisper transcribed %.1fs of audio (%s) -> %d chars",
                     getattr(info, "duration", 0.0) or 0.0, language, len(text))
        return {"text": text}
    except Exception as exc:
        _logger.warning("Local Whisper transcription failed: %s", exc)
        return {"error": f"Transcription failed: {exc}"}


def transcribe_bytes(data, ext="webm", language="en"):
    """Transcribe raw audio bytes (webm/mp4/wav/ogg — decoded by PyAV)."""
    fd, path = tempfile.mkstemp(suffix=f".{ext}")
    try:
        with os.fdopen(fd, "wb") as f:
            f.write(data)
        return transcribe_file(path, language=language)
    finally:
        try:
            os.unlink(path)
        except OSError:
            pass
