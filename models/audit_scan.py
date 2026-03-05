# FILE: /opt/odoo/custum-addons/prema_ai_auditor/models/audit_scan.py

import json
import time
from datetime import datetime

from odoo import api, fields, models
from ..services.scanner import accounts, journals, bills, aging, security, system, logistics

RISK_ORDER = {"critical": 0, "high": 1, "medium": 2, "low": 3}


class PremaAuditScan(models.Model):
    _name = "prema.audit.scan"
    _description = "Prema Audit Scan"
    _order = "create_date desc"

    name = fields.Char(
        default=lambda self: "Scan {}".format(datetime.now().strftime("%Y-%m-%d %H:%M")),
    )
    user_id = fields.Many2one(
        "res.users", default=lambda self: self.env.user, readonly=True,
    )
    state = fields.Selection([
        ("running", "Running"),
        ("done", "Done"),
        ("error", "Error"),
    ], default="running")
    issue_ids = fields.One2many("prema.audit.issue", "scan_id")
    total_issues = fields.Integer(compute="_compute_counts", store=True)
    critical_count = fields.Integer(compute="_compute_counts", store=True)
    high_count = fields.Integer(compute="_compute_counts", store=True)
    medium_count = fields.Integer(compute="_compute_counts", store=True)
    low_count = fields.Integer(compute="_compute_counts", store=True)
    scan_categories = fields.Char()
    duration_seconds = fields.Float()
    error_message = fields.Text()

    @api.depends("issue_ids", "issue_ids.risk")
    def _compute_counts(self):
        for rec in self:
            issues = rec.issue_ids
            rec.total_issues = len(issues)
            rec.critical_count = len(issues.filtered(lambda i: i.risk == "critical"))
            rec.high_count = len(issues.filtered(lambda i: i.risk == "high"))
            rec.medium_count = len(issues.filtered(lambda i: i.risk == "medium"))
            rec.low_count = len(issues.filtered(lambda i: i.risk == "low"))

    @api.model
    def run_scan(self, categories=None):
        scan = self.create({})
        start = time.time()

        scanners = {
            "accounts": accounts,
            "journals": journals,
            "bills": bills,
            "aging": aging,
            "security": security,
            "system": system,
            "logistics": logistics,
        }

        selected = categories or list(scanners.keys())
        all_issues = []
        for cat in selected:
            scanner = scanners.get(cat)
            if not scanner:
                continue
            try:
                issues = scanner.scan(self.env)
                all_issues.extend(issues)
            except Exception as e:
                all_issues.append({
                    "category": cat,
                    "code": "SCAN_ERROR",
                    "risk": "high",
                    "title": "Scanner Error: {}".format(cat),
                    "detail": str(e),
                    "affected_model": None,
                    "affected_ids": [],
                    "fix_action": None,
                })

        all_issues.sort(key=lambda x: RISK_ORDER.get(x.get("risk", "low"), 3))

        for issue in all_issues:
            self.env["prema.audit.issue"].create({
                "scan_id": scan.id,
                "category": issue.get("category", ""),
                "code": issue.get("code", ""),
                "risk": issue.get("risk", "low"),
                "title": issue.get("title", ""),
                "detail": issue.get("detail", ""),
                "affected_model": issue.get("affected_model") or "",
                "affected_ids": json.dumps(issue.get("affected_ids", [])),
                "fix_action": json.dumps(issue["fix_action"]) if issue.get("fix_action") else False,
                "fix_state": "pending" if issue.get("fix_action") else "no_fix",
            })

        scan.write({
            "state": "done",
            "scan_categories": ", ".join(selected),
            "duration_seconds": round(time.time() - start, 2),
        })
        return scan.id

    @api.model
    def get_scan_results(self, scan_id):
        scan = self.browse(scan_id)
        scan.ensure_one()
        return {
            "scan_id": scan.id,
            "name": scan.name,
            "state": scan.state,
            "duration": scan.duration_seconds,
            "total": scan.total_issues,
            "critical": scan.critical_count,
            "high": scan.high_count,
            "medium": scan.medium_count,
            "low": scan.low_count,
            "issues": [{
                "id": i.id,
                "category": i.category,
                "code": i.code,
                "risk": i.risk,
                "title": i.title,
                "detail": i.detail,
                "affected_model": i.affected_model,
                "affected_ids": json.loads(i.affected_ids or "[]"),
                "fix_state": i.fix_state,
                "has_fix": bool(i.fix_action),
            } for i in scan.issue_ids],
        }
