"""Bills Scanner: duplicates, missing refs, no tax, old drafts"""
from datetime import datetime, timedelta


def scan(env):
    issues = []

    try:
        grouped = env["account.move"].read_group(
            [("move_type", "=", "in_invoice"), ("state", "!=", "cancel"), ("ref", "!=", False)],
            ["ref", "partner_id", "id:count"], ["ref", "partner_id"], lazy=False)
        for row in grouped:
            if row.get("id_count", 0) > 1 and row.get("ref") and row.get("partner_id"):
                dupes = env["account.move"].search_read(
                    [("move_type", "=", "in_invoice"), ("ref", "=", row["ref"]),
                     ("partner_id", "=", row["partner_id"][0]), ("state", "!=", "cancel")],
                    ["id", "name", "amount_total", "state"])
                issues.append({"category": "bills", "code": "BILL_DUPLICATE", "risk": "high",
                    "title": "Duplicate Bill: Ref {} / {}".format(row["ref"], row["partner_id"][1]),
                    "detail": "{} bills with ref '{}' for '{}'. IDs: {}".format(
                        row["id_count"], row["ref"], row["partner_id"][1], [d["id"] for d in dupes]),
                    "affected_model": "account.move", "affected_ids": [d["id"] for d in dupes], "fix_action": None})
    except Exception:
        pass

    try:
        no_ref = env["account.move"].search_read(
            [("move_type", "=", "in_invoice"), ("state", "=", "posted"), ("ref", "=", False)],
            ["id", "name", "partner_id", "invoice_date", "amount_total"], limit=100)
        for bill in no_ref:
            issues.append({"category": "bills", "code": "BILL_MISSING_REF", "risk": "medium",
                "title": "Posted Bill Missing Ref: {}".format(bill["name"]),
                "detail": "Bill ID {} from '{}' has no vendor reference.".format(bill["id"], bill["partner_id"][1] if bill["partner_id"] else "?"),
                "affected_model": "account.move", "affected_ids": [bill["id"]], "fix_action": None})
    except Exception:
        pass

    try:
        no_tax = env["account.move"].search_read(
            [("move_type", "=", "in_invoice"), ("state", "=", "posted"), ("amount_tax", "=", 0), ("amount_total", ">", 100)],
            ["id", "name", "partner_id", "amount_total"], limit=100)
        for bill in no_tax:
            issues.append({"category": "bills", "code": "BILL_NO_TAX", "risk": "medium",
                "title": "Bill With No Tax: {}".format(bill["name"]),
                "detail": "Bill ID {} (amount: {}) has no tax applied.".format(bill["id"], bill["amount_total"]),
                "affected_model": "account.move", "affected_ids": [bill["id"]], "fix_action": None})
    except Exception:
        pass

    try:
        cutoff = (datetime.now() - timedelta(days=60)).strftime("%Y-%m-%d")
        old = env["account.move"].search_read(
            [("move_type", "=", "in_invoice"), ("state", "=", "draft"),
             ("invoice_date", "<", cutoff), ("invoice_date", "!=", False)],
            ["id", "name", "partner_id", "invoice_date", "amount_total"], limit=100)
        for bill in old:
            issues.append({"category": "bills", "code": "BILL_OLD_DRAFT", "risk": "medium",
                "title": "Old Draft Bill: {}".format(bill["name"] or "Unnamed"),
                "detail": "Bill ID {} dated {} in draft >60 days.".format(bill["id"], bill["invoice_date"]),
                "affected_model": "account.move", "affected_ids": [bill["id"]], "fix_action": None})
    except Exception:
        pass

    return issues
