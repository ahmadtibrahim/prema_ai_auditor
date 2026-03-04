{
    "name": "Prema AI Auditor",
    "version": "18.0.2.0.0",
    "summary": "AI-powered ERP auditor: full scan, logistics accounting, bill OCR, ML learning",
    "depends": ["base", "web", "mail", "account", "crm"],
    "data": [
        "security/ir.model.access.csv",
        "security/record_rules.xml",
        "views/menu_views.xml",
        "views/audit_views.xml",
        "views/fix_log_views.xml",
    ],
    "assets": {
        "web.assets_backend": [
            "prema_ai_auditor/static/src/css/main.css",
            "prema_ai_auditor/static/src/js/ai_console.js",
            "prema_ai_auditor/static/src/js/audit_dashboard.js",
            "prema_ai_auditor/static/src/xml/ai_console.xml",
            "prema_ai_auditor/static/src/xml/audit_dashboard.xml",
        ],
    },
    "external_dependencies": {
        "python": ["requests", "scikit-learn", "joblib", "Pillow"],
    },
    "installable": True,
    "application": True,
    "license": "LGPL-3",
}
