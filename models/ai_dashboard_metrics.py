from odoo import models


class AIDashboardMetrics(models.AbstractModel):
    _name = "prema.ai.dashboard"
    _description = "Prema AI Dashboard Metrics"

    def severity_counts(self):
        logs = self.env["prema.audit.log"].search([("status", "=", "open")])
        counts = {
            "critical": 0,
            "high": 0,
            "medium": 0,
            "low": 0,
        }

        for log in logs:
            counts[log.severity] = counts.get(log.severity, 0) + 1

        return counts
