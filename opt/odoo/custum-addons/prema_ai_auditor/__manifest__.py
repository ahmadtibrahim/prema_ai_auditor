{
    "name": "Prema AI Console",
    "version": "18.0.1.0.0",
    "depends": ["base", "web"],
    "data": [
        "security/ir.model.access.csv",
        "views/ai_console_views.xml",
    ],
    "assets": {
        "web.assets_backend": [
            "prema_ai_auditor/static/src/js/ai_console.js",
            "prema_ai_auditor/static/src/xml/ai_console_templates.xml",
        ],
    },
    "installable": True,
    "application": True,
}
