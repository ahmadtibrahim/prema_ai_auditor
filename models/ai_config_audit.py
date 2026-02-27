from odoo import models


class AIConfigAudit(models.AbstractModel):
    _name = "prema.ai.config.audit"
    _description = "Prema AI Pre-Deployment Configuration Audit"

    def run(self):
        issues = []
        params = self.env["ir.config_parameter"].sudo()

        if not params.get_param("web.base.url"):
            issues.append("Missing base URL")

        if not params.get_param("mail.catchall.domain"):
            issues.append("Mail catchall not configured")

        inactive_crons = self.env["ir.cron"].search([("active", "=", False)], limit=1)
        if inactive_crons:
            issues.append("Inactive scheduled actions detected")

        return issues
