"""AR/AP Aging Anomalies: overdue AR/AP, credit balance on AR"""
from datetime import datetime


def scan(env):
    issues = []
    today = datetime.now().date()

    # 1. Overdue receivables
    try:
        ar = env["account.move"].search_read(
            [("move_type", "=", "out_invoice"), ("state", "=", "posted"),
             ("payment_state", "in", ["not_paid", "partial"]),
             ("invoice_date_due", "<", str(today))],
            ["id", "name", "partner_id", "invoice_date_due",
             "amount_residual", "currency_id"],
            order="invoice_date_due asc", limit=100)
        for inv in ar:
            days = (today - datetime.strptime(
                str(inv["invoice_date_due"]), "%Y-%m-%d").date()).days
            risk = "high" if days > 90 else ("medium" if days > 30 else "low")
            issues.append({
                "category": "aging", "code": "AR_OVERDUE", "risk": risk,
                "title": "Overdue Receivable: {} ({} days)".format(inv["name"], days),
                "detail": "Invoice ID {} from '{}' due {}. Outstanding: {} {}. {} days overdue.".format(
                    inv["id"],
                    inv["partner_id"][1] if inv["partner_id"] else "?",
                    inv["invoice_date_due"], inv["amount_residual"],
                    inv["currency_id"][1] if inv["currency_id"] else "", days),
                "affected_model": "account.move",
                "affected_ids": [inv["id"]],
                "fix_action": None,
            })
    except Exception:
        pass

    # 2. Overdue payables >60 days
    try:
        ap = env["account.move"].search_read(
            [("move_type", "=", "in_invoice"), ("state", "=", "posted"),
             ("payment_state", "in", ["not_paid", "partial"]),
             ("invoice_date_due", "<", str(today))],
            ["id", "name", "partner_id", "invoice_date_due",
             "amount_residual", "currency_id"],
            order="invoice_date_due asc", limit=100)
        for bill in ap:
            days = (today - datetime.strptime(
                str(bill["invoice_date_due"]), "%Y-%m-%d").date()).days
            if days > 60:
                issues.append({
                    "category": "aging", "code": "AP_OVERDUE", "risk": "medium",
                    "title": "Overdue Payable: {} ({} days)".format(bill["name"], days),
                    "detail": "Bill ID {} to '{}' due {}. Outstanding: {} {}. {} days overdue.".format(
                        bill["id"],
                        bill["partner_id"][1] if bill["partner_id"] else "?",
                        bill["invoice_date_due"], bill["amount_residual"],
                        bill["currency_id"][1] if bill["currency_id"] else "", days),
                    "affected_model": "account.move",
                    "affected_ids": [bill["id"]],
                    "fix_action": None,
                })
    except Exception:
        pass

    # 3. Credit balances on AR accounts
    try:
        ar_accounts = env["account.account"].search(
            [("account_type", "=", "asset_receivable")])
        for acc in ar_accounts:
            lines = env["account.move.line"].search_read(
                [("account_id", "=", acc.id), ("move_id.state", "=", "posted")],
                ["debit", "credit"])
            balance = sum(l["debit"] - l["credit"] for l in lines)
            if balance < -100:
                issues.append({
                    "category": "aging", "code": "AR_CREDIT_BALANCE", "risk": "medium",
                    "title": "Credit Balance on AR: {} {}".format(acc.code, acc.name),
                    "detail": "Account {} has credit balance of {}. This may indicate over-payment or unapplied credits.".format(
                        acc.code, round(balance, 2)),
                    "affected_model": "account.account",
                    "affected_ids": [acc.id],
                    "fix_action": None,
                })
    except Exception:
        pass

    return issues
