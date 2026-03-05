"""Logistics Accounting Auditor: Canadian GST/HST, CAD/USD, freight, T4A"""


def scan(env):
    issues = []

    try:
        cad_bills = env["account.move"].search_read(
            [("move_type", "=", "in_invoice"), ("state", "=", "posted"),
             ("amount_tax", "=", 0), ("amount_total", ">", 500)],
            ["id", "name", "partner_id", "amount_total", "currency_id", "invoice_date"], limit=100)
        for bill in cad_bills:
            currency = bill["currency_id"][1] if bill["currency_id"] else ""
            if "CAD" in currency or not currency:
                issues.append({"category": "logistics", "code": "LOG_MISSING_GST_HST", "risk": "high",
                    "title": "CAD Bill Missing GST/HST: {}".format(bill["name"]),
                    "detail": "Bill ID {} (partner: {}, amount: {} CAD) has no tax. Verify GST/HST applicability.".format(
                        bill["id"], bill["partner_id"][1] if bill["partner_id"] else "?", bill["amount_total"]),
                    "affected_model": "account.move", "affected_ids": [bill["id"]], "fix_action": None})
    except Exception:
        pass

    try:
        big_bills = env["account.move"].search_read(
            [("move_type", "=", "in_invoice"), ("state", "=", "posted"), ("amount_total", ">", 500)],
            ["id", "partner_id"], limit=500)
        if len(big_bills) > 10:
            issues.append({"category": "logistics", "code": "LOG_T4A_REVIEW", "risk": "medium",
                "title": "T4A Reporting Review ({} contractor bills)".format(len(big_bills)),
                "detail": "Found {} vendor bills >$500. Payments to owner-operators exceeding $500/year require CRA T4A reporting.".format(len(big_bills)),
                "affected_model": "account.move", "affected_ids": [], "fix_action": None})
    except Exception:
        pass

    try:
        freight_accs = env["account.account"].search_read(
            [("name", "ilike", "freight"), ("account_type", "in", ["income", "income_other"])],
            ["id", "code", "name"])
        if freight_accs:
            issues.append({"category": "logistics", "code": "LOG_FREIGHT_SPLIT_CHECK", "risk": "low",
                "title": "Freight Revenue Split Review",
                "detail": "Found {} freight revenue accounts. Verify Canadian vs USA freight split for GST/HST zero-rating.".format(len(freight_accs)),
                "affected_model": "account.account", "affected_ids": [a["id"] for a in freight_accs], "fix_action": None})
    except Exception:
        pass

    return issues
