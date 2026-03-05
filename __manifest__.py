{
    'name': 'Prema AI Auditor',
    'version': '18.0.5.0.0',
    'category': 'Tools',
    'summary': 'AI CEO Assistant for CRM, Accounting, Documents and Operations',
    'author': 'PremaFirm Inc.',
    'license': 'LGPL-3',
    'depends': [
        'base',
        'web',
        'mail',
        'crm',
        'account',
        'sale_management',
        'fleet',
        'hr_expense',
        'helpdesk',
        'calendar',
        'contacts',
        'documents',
    ],
    'data': [
        'security/ir.model.access.csv',
        'security/record_rules.xml',
        'views/session_views.xml',
        'views/task_queue_views.xml',
        'views/menu_views.xml',
    ],
    'assets': {
        'web.assets_backend': [
            # CSS — explicit order
            'prema_ai_auditor/static/src/css/ai_console.css',
            'prema_ai_auditor/static/src/css/main.css',
            # XML templates — must come BEFORE JS
            'prema_ai_auditor/static/src/xml/ai_console.xml',
            'prema_ai_auditor/static/src/xml/audit_dashboard.xml',
            # JS — explicit files, explicit order (NO wildcard)
            'prema_ai_auditor/static/src/js/ai_console.js',
            'prema_ai_auditor/static/src/js/audit_dashboard.js',
        ],
    },
    'application': True,
    'sequence': 1,
    'installable': True,
    'auto_install': False,
}
