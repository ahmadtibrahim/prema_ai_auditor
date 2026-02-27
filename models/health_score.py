from odoo import models


class HealthScore(models.AbstractModel):
    _name = "prema.health.score"
    _description = "Prema Health Score Engine"

    def compute_score(self):
        logs = self.env["prema.audit.log"].search([("status", "=", "open")])

        score = 100
        for log in logs:
            if log.severity == "critical":
                score -= 10
            elif log.severity == "high":
                score -= 5
            elif log.severity == "medium":
                score -= 2
            else:
                score -= 1

        return max(score, 0)
