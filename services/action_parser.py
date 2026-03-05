# FILE: /opt/odoo/custum-addons/prema_ai_auditor/services/action_parser.py
"""
TASK 12: Action Parser
Parses AI response text to detect actionable commands
and generates preview tasks for the executor.
"""

import json
import logging
import re

_logger = logging.getLogger(__name__)

# Action keywords → action_type mapping
ACTION_PATTERNS = {
    r"system[\s_]?audit": "system_audit",
    r"find[\s_]?stale[\s_]?leads": "find_stale_leads",
    r"show[\s_]?overdue[\s_]?tasks": "show_overdue_tasks",
    r"find[\s_]?old[\s_]?tickets": "find_old_tickets",
    r"find[\s_]?unbilled[\s_]?orders": "find_unbilled_orders",
    r"find[\s_]?duplicate[\s_]?expenses": "find_duplicate_expenses",
    r"generate[\s_]?email[\s_]?template": "generate_email_template",
    r"generate[\s_]?website[\s_]?content": "generate_website_content",
    r"build[\s_]?document[\s_]?packet": "build_document_packet",
    r"check[\s_]?duplicate[\s_]?bills": "check_duplicate_bills",
    r"check[\s_]?cron[\s_]?jobs": "check_cron_jobs",
    r"list[\s_]?modules": "list_modules",
    r"check[\s_]?module[\s_]?health": "check_module_health",
    r"financial[\s_]?summary": "financial_summary",
    r"crm[\s_]?pipeline": "crm_pipeline_analysis",
    r"revenue[\s_]?forecast": "revenue_forecast",
}

# Actions that are read-only (no approval needed)
READ_ONLY_ACTIONS = {
    "find_stale_leads",
    "show_overdue_tasks",
    "find_old_tickets",
    "find_unbilled_orders",
    "find_duplicate_expenses",
    "check_duplicate_bills",
    "check_cron_jobs",
    "list_modules",
    "check_module_health",
    "financial_summary",
    "crm_pipeline_analysis",
    "revenue_forecast",
    "system_audit",
}

# Actions that modify data (require approval)
APPROVAL_ACTIONS = {
    "generate_email_template",
    "generate_website_content",
    "build_document_packet",
}


def parse_user_message(message):
    """
    Parse a user message and return detected actions.
    Returns a list of action dicts.
    """
    if not message:
        return []

    lower = message.lower().strip()
    detected = []

    for pattern, action_type in ACTION_PATTERNS.items():
        if re.search(pattern, lower):
            detected.append({
                "action_type": action_type,
                "requires_approval": action_type in APPROVAL_ACTIONS,
                "source_text": message[:200],
                "params": _extract_params(lower, action_type),
            })

    return detected


def parse_ai_response(response_text):
    """
    Parse AI response text to find action suggestions embedded in the reply.
    Looks for JSON action blocks or known command patterns.
    """
    if not response_text:
        return []

    detected = []

    # Look for JSON action blocks: ```action {...} ```
    json_blocks = re.findall(r"```action\s*(\{.*?\})\s*```", response_text, re.DOTALL)
    for block in json_blocks:
        try:
            action = json.loads(block)
            if "action_type" in action:
                action["requires_approval"] = action.get(
                    "action_type", ""
                ) in APPROVAL_ACTIONS
                detected.append(action)
        except json.JSONDecodeError:
            pass

    # Also check for keyword patterns in the response
    lower = response_text.lower()
    for pattern, action_type in ACTION_PATTERNS.items():
        if re.search(pattern, lower) and action_type in APPROVAL_ACTIONS:
            # Only flag approval-needed actions from AI responses
            if not any(d["action_type"] == action_type for d in detected):
                detected.append({
                    "action_type": action_type,
                    "requires_approval": True,
                    "source_text": response_text[:200],
                    "params": _extract_params(lower, action_type),
                })

    return detected


def generate_preview_task(action):
    """
    Convert a parsed action into a preview task dict
    for the executor queue.
    """
    return {
        "action_type": action["action_type"],
        "requires_approval": action.get("requires_approval", True),
        "status": "pending_approval" if action.get("requires_approval") else "ready",
        "params": action.get("params", {}),
        "source_text": action.get("source_text", ""),
    }


def _extract_params(text, action_type):
    """Extract parameters from message text based on action type."""
    params = {}

    if action_type == "find_stale_leads":
        days_match = re.search(r"(\d+)\s*days?", text)
        if days_match:
            params["days"] = int(days_match.group(1))

    elif action_type == "find_old_tickets":
        days_match = re.search(r"(\d+)\s*days?", text)
        if days_match:
            params["days"] = int(days_match.group(1))

    elif action_type == "check_module_health":
        # Try to extract module name after "module" keyword
        mod_match = re.search(r"module\s+(\w+)", text)
        if mod_match:
            params["module_name"] = mod_match.group(1)

    elif action_type == "build_document_packet":
        # Try to find folder name in quotes
        folder_match = re.search(r'["\']([^"\']+)["\']', text)
        if folder_match:
            params["folder_name"] = folder_match.group(1)

    elif action_type == "generate_email_template":
        subject_match = re.search(r"subject[:\s]+[\"']([^\"']+)[\"']", text)
        if subject_match:
            params["subject"] = subject_match.group(1)

    return params
