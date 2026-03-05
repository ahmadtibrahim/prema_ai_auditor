# FILE: /opt/odoo/custum-addons/prema_ai_auditor/services/odoo_tools.py
"""
TASK 10: AI Tool Services
Safe, read-only tool methods that return structured JSON.
All methods receive an Odoo `env` object.
"""

import json
import logging
from datetime import date, timedelta

_logger = logging.getLogger(__name__)


# ═══════════════════════════════════════════════════════════════
# MODULE HEALTH
# ═══════════════════════════════════════════════════════════════

def tool_list_modules(env):
    """List installed Odoo modules with status."""
    modules = env["ir.module.module"].sudo().search_read(
        [("state", "=", "installed")],
        ["name", "shortdesc", "state", "installed_version"],
        limit=300,
    )
    return {
        "count": len(modules),
        "modules": [
            {
                "name": m["name"],
                "display_name": m["shortdesc"],
                "version": m["installed_version"],
                "state": m["state"],
            }
            for m in modules
        ],
    }


def tool_check_module_health(env, module_name):
    """Check a specific module for issues."""
    mod = env["ir.module.module"].sudo().search(
        [("name", "=", module_name)], limit=1,
    )
    if not mod:
        return {"error": f"Module '{module_name}' not found"}

    issues = []

    # Check state
    if mod.state != "installed":
        issues.append(f"Module is in state '{mod.state}', not 'installed'")

    # Check for pending upgrades
    if mod.state in ("to upgrade", "to install", "to remove"):
        issues.append(f"Module has pending action: {mod.state}")

    # Check views for this module
    broken_views = env["ir.ui.view"].sudo().search([
        ("model", "like", module_name.replace("_", ".")),
    ])
    view_count = len(broken_views)

    return {
        "module": module_name,
        "display_name": mod.shortdesc,
        "state": mod.state,
        "version": mod.installed_version,
        "views_count": view_count,
        "issues": issues,
        "healthy": len(issues) == 0,
    }


def tool_validate_views(env, module_name):
    """Validate XML views for a module."""
    views = env["ir.ui.view"].sudo().search([
        ("model", "like", module_name.replace("_", ".")),
    ])
    results = []
    for v in views[:50]:
        results.append({
            "view_id": v.id,
            "name": v.name,
            "model": v.model,
            "type": v.type,
            "active": v.active,
        })
    return {"module": module_name, "view_count": len(results), "views": results}


def tool_validate_models(env, module_name):
    """List models registered by a module."""
    models = env["ir.model"].sudo().search_read(
        [("model", "like", module_name.replace("_", "."))],
        ["model", "name", "state", "transient"],
        limit=50,
    )
    return {"module": module_name, "model_count": len(models), "models": models}


# ═══════════════════════════════════════════════════════════════
# CRON JOB MONITOR
# ═══════════════════════════════════════════════════════════════

def tool_check_cron_jobs(env):
    """Review scheduled actions and their status."""
    crons = env["ir.cron"].sudo().search_read(
        [],
        ["name", "active", "interval_number", "interval_type",
         "nextcall", "numbercall", "priority"],
        order="nextcall asc",
        limit=100,
    )
    active = [c for c in crons if c["active"]]
    inactive = [c for c in crons if not c["active"]]

    return {
        "total": len(crons),
        "active_count": len(active),
        "inactive_count": len(inactive),
        "crons": [
            {
                "name": c["name"],
                "active": c["active"],
                "interval": f"{c['interval_number']} {c['interval_type']}",
                "next_call": str(c["nextcall"]) if c["nextcall"] else None,
                "remaining_calls": c["numbercall"],
            }
            for c in crons
        ],
    }


# ═══════════════════════════════════════════════════════════════
# CRM
# ═══════════════════════════════════════════════════════════════

def tool_find_stale_leads(env, days=30):
    """Find CRM leads with no activity in N days."""
    cutoff = date.today() - timedelta(days=days)
    leads = env["crm.lead"].sudo().search_read(
        [
            ("type", "=", "lead"),
            ("active", "=", True),
            ("write_date", "<", str(cutoff)),
        ],
        ["name", "partner_name", "user_id", "stage_id",
         "expected_revenue", "write_date"],
        limit=50,
    )
    return {
        "stale_count": len(leads),
        "cutoff_days": days,
        "leads": [
            {
                "id": l["id"],
                "name": l["name"],
                "partner": l["partner_name"],
                "salesperson": l["user_id"][1] if l["user_id"] else None,
                "stage": l["stage_id"][1] if l["stage_id"] else None,
                "expected_revenue": l["expected_revenue"],
                "last_updated": str(l["write_date"]),
            }
            for l in leads
        ],
    }


# ═══════════════════════════════════════════════════════════════
# TASKS
# ═══════════════════════════════════════════════════════════════

def tool_show_overdue_tasks(env):
    """List project tasks past their deadline."""
    today = date.today()
    tasks = env["project.task"].sudo().search_read(
        [
            ("date_deadline", "<", str(today)),
            ("state", "not in", ["1_done", "1_canceled"]),
        ],
        ["name", "project_id", "user_ids", "date_deadline", "state", "stage_id"],
        limit=50,
    )
    return {
        "overdue_count": len(tasks),
        "tasks": [
            {
                "id": t["id"],
                "name": t["name"],
                "project": t["project_id"][1] if t["project_id"] else None,
                "assignees": t["user_ids"],
                "deadline": str(t["date_deadline"]),
                "stage": t["stage_id"][1] if t["stage_id"] else None,
            }
            for t in tasks
        ],
    }


# ═══════════════════════════════════════════════════════════════
# HELPDESK
# ═══════════════════════════════════════════════════════════════

def tool_find_old_tickets(env, days=14):
    """Find helpdesk tickets open for N+ days."""
    try:
        cutoff = date.today() - timedelta(days=days)
        tickets = env["helpdesk.ticket"].sudo().search_read(
            [
                ("create_date", "<", str(cutoff)),
                ("stage_id.is_close", "=", False),
            ],
            ["name", "partner_id", "user_id", "team_id",
             "create_date", "stage_id"],
            limit=50,
        )
        return {
            "old_ticket_count": len(tickets),
            "cutoff_days": days,
            "tickets": [
                {
                    "id": t["id"],
                    "name": t["name"],
                    "customer": t["partner_id"][1] if t["partner_id"] else None,
                    "assigned_to": t["user_id"][1] if t["user_id"] else None,
                    "team": t["team_id"][1] if t["team_id"] else None,
                    "created": str(t["create_date"]),
                    "stage": t["stage_id"][1] if t["stage_id"] else None,
                }
                for t in tickets
            ],
        }
    except KeyError:
        return {"error": "Helpdesk module not installed"}


# ═══════════════════════════════════════════════════════════════
# SALES
# ═══════════════════════════════════════════════════════════════

def tool_find_unbilled_orders(env):
    """Find confirmed sales orders that have not been invoiced."""
    orders = env["sale.order"].sudo().search_read(
        [
            ("state", "=", "sale"),
            ("invoice_status", "=", "to invoice"),
        ],
        ["name", "partner_id", "amount_total", "date_order", "user_id"],
        limit=50,
    )
    return {
        "unbilled_count": len(orders),
        "total_value": sum(o["amount_total"] for o in orders),
        "orders": [
            {
                "id": o["id"],
                "name": o["name"],
                "customer": o["partner_id"][1] if o["partner_id"] else None,
                "amount": o["amount_total"],
                "date": str(o["date_order"]),
                "salesperson": o["user_id"][1] if o["user_id"] else None,
            }
            for o in orders
        ],
    }


# ═══════════════════════════════════════════════════════════════
# EXPENSES
# ═══════════════════════════════════════════════════════════════

def tool_find_duplicate_expenses(env):
    """Find expenses with same employee, amount, and date."""
    try:
        expenses = env["hr.expense"].sudo().search_read(
            [("state", "in", ["draft", "reported", "approved"])],
            ["name", "employee_id", "total_amount", "date", "state"],
            limit=500,
        )
        seen = {}
        duplicates = []
        for exp in expenses:
            key = (
                exp["employee_id"][0] if exp["employee_id"] else 0,
                round(exp["total_amount"], 2),
                str(exp["date"]),
            )
            if key in seen:
                duplicates.append({
                    "expense_1": seen[key],
                    "expense_2": {
                        "id": exp["id"],
                        "name": exp["name"],
                        "employee": exp["employee_id"][1] if exp["employee_id"] else None,
                        "amount": exp["total_amount"],
                        "date": str(exp["date"]),
                    },
                })
            else:
                seen[key] = {
                    "id": exp["id"],
                    "name": exp["name"],
                    "employee": exp["employee_id"][1] if exp["employee_id"] else None,
                    "amount": exp["total_amount"],
                    "date": str(exp["date"]),
                }
        return {"duplicate_count": len(duplicates), "duplicates": duplicates}
    except KeyError:
        return {"error": "Expense module not installed"}


# ═══════════════════════════════════════════════════════════════
# EMAIL
# ═══════════════════════════════════════════════════════════════

def tool_generate_email_template(env, subject, body_text, model_name="res.partner"):
    """Generate an email template record (draft)."""
    return {
        "action": "create_email_template",
        "preview": {
            "subject": subject,
            "body_html": f"<p>{body_text}</p>",
            "model_id": model_name,
        },
        "requires_approval": True,
        "message": f"Email template '{subject}' ready for approval.",
    }


# ═══════════════════════════════════════════════════════════════
# DOCUMENTS
# ═══════════════════════════════════════════════════════════════

def tool_build_document_packet(env, folder_name, attachment_ids=None, domain=None):
    """Organize attachments into a named folder/tag."""
    if attachment_ids:
        attachments = env["ir.attachment"].sudo().browse(attachment_ids)
    elif domain:
        attachments = env["ir.attachment"].sudo().search(domain, limit=100)
    else:
        return {"error": "Provide attachment_ids or search domain"}

    return {
        "action": "build_document_packet",
        "preview": {
            "folder_name": folder_name,
            "attachment_count": len(attachments),
            "attachments": [
                {"id": a.id, "name": a.name, "mimetype": a.mimetype}
                for a in attachments[:20]
            ],
        },
        "requires_approval": True,
        "message": f"Document packet '{folder_name}' with {len(attachments)} files ready for approval.",
    }
