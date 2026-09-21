# FILE: /opt/odoo/custum-addons/prema_ai_auditor/__manifest__.py
{
    "name": "Prema AI Auditor",
    "version": "18.0.3.6.2",
    "summary": "AI-powered ERP assistant: GPT chat, bill OCR, CRM outreach, AI corrections",
    "depends": ["base", "web", "mail", "account", "crm"],
    "data": [
        "security/ir.model.access.csv",
        "security/record_rules.xml",
        "data/ai_config_data.xml",
        "views/ai_config_views.xml",
        "views/menu_views.xml",
        "views/attachment_views.xml",
        "views/correction_views.xml",
    ],
    "assets": {
        "web.assets_backend": [
            "prema_ai_auditor/static/src/css/main.css",
            "prema_ai_auditor/static/src/js/ai_console.js",
            "prema_ai_auditor/static/src/xml/ai_console.xml",
        ],
    },
    "external_dependencies": {
        "python": ["requests", "Pillow"],
    },
    "installable": True,
    "application": True,
    "license": "LGPL-3",
}
