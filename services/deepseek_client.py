"""
DeepSeek chat-completions client for the Prema AI console.

Self-contained on purpose: this module lives in prema_ai_auditor and must
NOT import from premafirm_ai_engine (the engine depends on the auditor, not
the other way around). Only uses `requests` + Odoo config parameters.

Endpoint / auth / model all come from ir.config_parameter at call time:
  - key:   'deepseek.api_key' -> fallback 'deepseek'
  - model: 'deepseek.model'   -> fallback 'deepseek-chat'

Retry behaviour: retryable statuses (429/5xx) and timeouts are retried with
a short backoff. `retries` defaults to 1 (2 attempts total) because a single
chat request must stay well under Odoo's limit_time_real (~120s); 3 retries
at 90s would blow past it and get the worker killed mid-request.
"""

import logging
import time

import requests
from odoo.exceptions import UserError

_logger = logging.getLogger(__name__)

DEEPSEEK_URL = "https://api.deepseek.com/v1/chat/completions"
DEFAULT_MODEL = "deepseek-chat"

RETRYABLE_STATUS = {429, 500, 502, 503, 504}


def get_api_key(env):
    p = env["ir.config_parameter"].sudo()
    return (p.get_param("deepseek.api_key") or p.get_param("deepseek") or "").strip()


def get_model(env):
    p = env["ir.config_parameter"].sudo()
    return (p.get_param("deepseek.model") or DEFAULT_MODEL).strip()


def deepseek_chat(env, messages, model=None, max_tokens=4096, temperature=0.3,
                  timeout=45, retries=1):
    """Call DeepSeek chat completions and return the response text.

    ``messages`` follows the OpenAI chat format:
      [{"role": "system"|"user"|"assistant", "content": "..."}, ...]

    Raises UserError on persistent API failure (after retries) so callers
    can surface a readable message instead of a raw traceback.
    """
    api_key = get_api_key(env)
    if not api_key:
        raise UserError("DeepSeek API key not configured (deepseek.api_key).")

    model = (model or get_model(env)) or DEFAULT_MODEL
    payload = {
        "model": model,
        "messages": messages,
        "max_tokens": max_tokens,
        "temperature": temperature,
    }
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json",
    }

    delay = 1.0
    last_error = None
    for attempt in range(retries + 1):
        try:
            resp = requests.post(DEEPSEEK_URL, headers=headers, json=payload,
                                 timeout=timeout)
            if resp.status_code not in RETRYABLE_STATUS:
                if not resp.ok:
                    _logger.error(
                        "DeepSeek API %s: %s", resp.status_code, (resp.text or "")[:500])
                resp.raise_for_status()
                data = resp.json()
                try:
                    return data["choices"][0]["message"]["content"].strip()
                except (KeyError, IndexError, TypeError):
                    raise UserError("DeepSeek API returned an unreadable response.")

            if attempt == retries:
                resp.raise_for_status()
            wait = min(float(resp.headers.get("Retry-After", delay)), 10.0)
            _logger.warning(
                "DeepSeek API %s (attempt %d/%d) — retrying in %.1fs",
                resp.status_code, attempt + 1, retries + 1, wait)
            time.sleep(wait)
            delay = min(delay * 2, 10.0)

        except requests.exceptions.Timeout as exc:
            last_error = exc
            if attempt == retries:
                break
            _logger.warning("DeepSeek API timeout (attempt %d/%d) — retrying in %.1fs",
                            attempt + 1, retries + 1, delay)
            time.sleep(delay)
            delay = min(delay * 2, 10.0)

        except requests.exceptions.RequestException as exc:
            last_error = exc
            if attempt == retries:
                break
            time.sleep(delay)
            delay = min(delay * 2, 10.0)

    raise UserError("DeepSeek API request failed after %d attempt(s): %s"
                    % (retries + 1, last_error or "unknown error"))
