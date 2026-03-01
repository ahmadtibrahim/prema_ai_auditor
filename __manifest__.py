{
    "name": "Prema AI Console",
    "version": "18.0.1.0.0",
    "depends": ["base", "web", "mail"],
    "data": [
        "security/ir.model.access.csv",
        "security/ai_session_rules.xml",
        "views/ai_console_views.xml",
    ],
    "assets": {
        "web.assets_backend": [
            "prema_ai_auditor/static/src/js/ai_console.js",
            "prema_ai_auditor/static/src/xml/ai_console_templates.xml",
            "prema_ai_auditor/static/src/css/ai_console.css",
        ],
    },
    "installable": True,
    "application": True,
}
