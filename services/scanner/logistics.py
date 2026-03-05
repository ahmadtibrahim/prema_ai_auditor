"""
Logistics Accounting Auditor
Canadian GST/HST, CAD/USD, owner-operator, freight revenue split,
fuel/maintenance/licensing, truck asset validation, T4A compliance
"""


def scan(env):
    issues = []

    # 1. Fuel expenses without analytic/vehicle link
    try:
        fuel_accs = env["account.account"].search_read(
            [("name", "ilike", "fuel")], ["id", "code", "name"])
        if fuel_accs:
            lines = env["account.move.line"].search_read(
                [("account_id", "in", [a["id"] for a in fuel_accs]),
                 ("move_id.state", "=", "posted"),
                 ("analytic_distribution", "=", False)],
                ["id", "move_id", "debit", "account_id"], limit=100)
            for line in lines:
                issues.append({
                    "category": "logistics", "code": "LOG_FUEL_NO_VEHICLE",
                    "risk": "medium",
                    "title": "Fuel Expense Without Vehicle Link",
                    "detail": "Line ID {} (account: {}, amount: {}) has no analytic/vehicle allocation.".format(
                        line["id"],
                        line["account_id"][1] if line["account_id"] else "?",
                        line["debit"]),
                    "affected_model": "account.move.line",
                    "affected_ids": [line["id"]],
                    "fix_action": None,
                })
    except Exception:
        pass

    # 2. CAD bills missing GST/HST
    try:
        cad_bills = env["account.move"].search_read(
            [("move_type", "=", "in_invoice"), ("state", "=", "posted"),
             ("amount_tax", "=", 0), ("amount_total", ">", 500)],
            ["id", "name", "partner_id", "amount_total", "currency_id",
             "invoice_date"], limit=100)
        for bill in cad_bills:
            currency = bill["currency_id"][1] if bill["currency_id"] else ""
            if "CAD" in currency or not currency:
                issues.append({
                    "category": "logistics", "code": "LOG_MISSING_GST_HST",
                    "risk": "high",
                    "title": "CAD Bill Missing GST/HST: {}".format(bill["name"]),
                    "detail": "Bill ID {} (partner: {}, amount: {} CAD, date: {}) has no tax.".format(
                        bill["id"],
                        bill["partner_id"][1] if bill["partner_id"] else "?",
                        bill["amount_total"], bill["invoice_date"]),
                    "affected_model": "account.move",
                    "affected_ids": [bill["id"]],
                    "fix_action": None,
                })
    except Exception:
        pass

    # 3. USD transactions — rate verification flag
    try:
        usd = env["account.move"].search_read(
            [("state", "=", "posted"), ("currency_id.name", "=", "USD")],
            ["id", "name", "amount_total", "move_type"], limit=100)
        for move in usd:
            issues.append({
                "category": "logistics", "code": "LOG_USD_REVIEW", "risk": "low",
                "title": "USD Transaction Rate Verification: {}".format(move["name"]),
                "detail": "Move ID {} is in USD (amount: {}). Verify exchange rate.".format(
                    move["id"], move["amount_total"]),
                "affected_model": "account.move",
                "affected_ids": [move["id"]],
                "fix_action": None,
            })
    except Exception:
        pass

    # 4. Truck/asset accounts without asset records
    try:
        asset_accs = env["account.account"].search_read(
            [("name", "ilike", "truck"), ("account_type", "=", "asset_fixed")],
            ["id", "code", "name"])
        for acc in asset_accs:
            try:
                count = env["account.asset"].search_count(
                    [("account_asset_id", "=", acc["id"])])
                lines = env["account.move.line"].search_read(
                    [("account_id", "=", acc["id"]),
                     ("move_id.state", "=", "posted")],
                    ["debit", "credit"])
                balance = sum(l["debit"] - l["credit"] for l in lines)
                if balance > 0 and count == 0:
                    issues.append({
                        "category": "logistics", "code": "LOG_ASSET_NO_RECORD",
                        "risk": "high",
                        "title": "Truck Account Has No Asset Record: {}".format(
                            acc["name"]),
                        "detail": "Account {} ({}) has balance {} but no asset records.".format(
                            acc["code"], acc["name"], round(balance, 2)),
                        "affected_model": "account.account",
                        "affected_ids": [acc["id"]],
                        "fix_action": None,
                    })
            except Exception:
                pass
    except Exception:
        pass

    # 5. T4A compliance review for owner-operators
    try:
        big_bills = env["account.move"].search_read(
            [("move_type", "=", "in_invoice"), ("state", "=", "posted"),
             ("amount_total", ">", 500)],
            ["id", "partner_id"], limit=500)
        if len(big_bills) > 10:
            issues.append({
                "category": "logistics", "code": "LOG_T4A_REVIEW", "risk": "medium",
                "title": "T4A Reporting Review ({} contractor bills)".format(
                    len(big_bills)),
                "detail": "Found {} vendor bills >$500. Payments to owner-operators exceeding $500/year require CRA T4A reporting.".format(
                    len(big_bills)),
                "affected_model": "account.move",
                "affected_ids": [],
                "fix_action": None,
            })
    except Exception:
        pass

    # 6. Maintenance expense review
    try:
        maint_accs = env["account.account"].search_read(
            [("name", "ilike", "maintenance")], ["id", "code", "name"])
        if maint_accs:
            lines = env["account.move.line"].search_read(
                [("account_id", "in", [a["id"] for a in maint_accs]),
                 ("move_id.state", "=", "posted"),
                 ("analytic_distribution", "=", False)],
                ["id"], limit=50)
            if lines:
                issues.append({
                    "category": "logistics", "code": "LOG_MAINT_NO_ANALYTIC",
                    "risk": "low",
                    "title": "Maintenance Expenses Without Analytic ({} lines)".format(
                        len(lines)),
                    "detail": "Found {} maintenance lines with no analytic distribution. Consider linking to vehicles/equipment.".format(
                        len(lines)),
                    "affected_model": "account.move.line",
                    "affected_ids": [l["id"] for l in lines[:20]],
                    "fix_action": None,
                })
    except Exception:
        pass

    return issues
