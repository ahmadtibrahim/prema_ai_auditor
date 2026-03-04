"""Journal Scanner: imbalanced entries, old drafts, orphan lines, empty entries"""
from datetime import datetime, timedelta


def scan(env):
    issues = []

    # 1. Posted imbalanced entries
    try:
        moves = env["account.move"].search_read([("state", "=", "posted")], ["id", "name", "date"], limit=500)
        for move in moves:
            lines = env["account.move.line"].search_read([("move_id", "=", move["id"])], ["debit", "credit"])
            diff = round(abs(sum(l["debit"] for l in lines) - sum(l["credit"] for l in lines)), 2)
            if diff > 0.01:
                issues.append({"category": "journals", "code": "JNL_IMBALANCED", "risk": "critical",
                    "title": "Imbalanced Entry: {}".format(move["name"]),
                    "detail": "Entry ID {} is posted but has debit/credit difference of {}.".format(move["id"], diff),
                    "affected_model": "account.move", "affected_ids": [move["id"]], "fix_action": None})
    except Exception:
        pass

    # 2. Draft entries >30 days old
    try:
        cutoff = (datetime.now() - timedelta(days=30)).strftime("%Y-%m-%d")
        old = env["account.move"].search_read(
            [("state", "=", "draft"), ("date", "<", cutoff)],
            ["id", "name", "date", "move_type"], limit=100)
        for move in old:
            issues.append({"category": "journals", "code": "JNL_OLD_DRAFT", "risk": "medium",
                "title": "Old Draft Entry: {}".format(move["name"] or "Unnamed"),
                "detail": "Entry ID {} in draft since {} (>30 days). Type: {}.".format(move["id"], move["date"], move["move_type"]),
                "affected_model": "account.move", "affected_ids": [move["id"]], "fix_action": None})
    except Exception:
        pass

    # 3. Lines with no account
    try:
        orphans = env["account.move.line"].search_read([("account_id", "=", False)], ["id", "move_id"], limit=50)
        for line in orphans:
            issues.append({"category": "journals", "code": "JNL_ORPHAN_LINE", "risk": "high",
                "title": "Journal Line Without Account",
                "detail": "Line ID {} on move '{}' has no account.".format(line["id"], line["move_id"][1] if line["move_id"] else "?"),
                "affected_model": "account.move.line", "affected_ids": [line["id"]], "fix_action": None})
    except Exception:
        pass

    # 4. Empty journal entries
    try:
        empty = env["account.move"].search_read([("line_ids", "=", False), ("state", "=", "draft")], ["id", "name", "date"], limit=50)
        for move in empty:
            issues.append({"category": "journals", "code": "JNL_EMPTY_ENTRY", "risk": "medium",
                "title": "Empty Journal Entry: {}".format(move["name"] or "Unnamed"),
                "detail": "Entry ID {} has no lines. Date: {}.".format(move["id"], move["date"]),
                "affected_model": "account.move", "affected_ids": [move["id"]],
                "fix_action": {"type": "delete_record", "model": "account.move", "record_id": move["id"],
                               "description": "Delete empty draft entry ID {}".format(move["id"])}})
    except Exception:
        pass

    return issues
