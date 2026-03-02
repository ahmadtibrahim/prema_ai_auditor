{
    "name": "Prema AI Console",
    "version": "18.0.1.0.0",
    "summary": "AI-powered Odoo DB assistant for accounting, CRM, and business management",
    "depends": ["base", "web", "mail", "account", "crm"],
    "data": [
        "security/ir.model.access.csv",
        "security/ai_session_rules.xml",
        "views/ai_console_views.xml",
    ],
    "assets": {
        "web.assets_backend": [
            "prema_ai_auditor/static/src/css/ai_console.css",
            "prema_ai_auditor/static/src/js/ai_console.js",
            "prema_ai_auditor/static/src/xml/ai_console.xml",
        ],
    },
    "installable": True,
    "application": True,
    "license": "LGPL-3",
}
