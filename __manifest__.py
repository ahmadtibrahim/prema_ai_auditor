# File: prema_ai_auditor/__manifest__.py

{
    'name': 'Prema AI Auditor',
    'version': '1.0.0',
    'category': 'Tools',
    'summary': 'AI CEO Assistant for CRM, Accounting and Operations',
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
        'views/ai_console_views.xml',
    ],
    'assets': {
        'web.assets_backend': [
            'prema_ai_auditor/static/src/js/ai_console.js',
            'prema_ai_auditor/static/src/xml/ai_console.xml',
            'prema_ai_auditor/static/src/css/ai_console.css',
        ],
    },
    'application': True,
    'installable': True,
    'auto_install': False,
}