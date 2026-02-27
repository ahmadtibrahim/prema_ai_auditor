{
    "name": "Prema AI Auditor",
    "version": "18.0.1.0",
    "depends": [
        "account",
        "account_accountant",
        "fleet",
        "crm",
        "sale",
        "purchase",
        "documents",
        "mail",
        "web",
    ],
    "data": [
        "security/security.xml",
        "security/ir.model.access.csv",
        "views/menu.xml",
        "views/audit_log_views.xml",
        "views/audit_dashboard_views.xml",
        "views/cleanup_views.xml",
        "data/default_rules.xml",
        "data/cron.xml",
    ],
    "assets": {
        "web.assets_backend": [
            "prema_ai_auditor/static/src/js/chat.js",
            "prema_ai_auditor/static/src/xml/chat_templates.xml",
        ]
    },
    "application": True,
    "installable": True,
    "license": "OEEL-1",
}
