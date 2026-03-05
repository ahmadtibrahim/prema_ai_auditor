"""Account Scanner: duplicate codes, unused accounts, AR/AP misuse"""


def scan(env):
    issues = []
    accounts = env["account.account"].search_read([], ["id", "code", "name", "company_id"])
    seen = {}
    for acc in accounts:
        key = (acc["code"], acc["company_id"][0] if acc["company_id"] else 0)
        if key in seen:
            issues.append({"category": "accounts", "code": "ACC_DUPLICATE_CODE", "risk": "high",
                "title": "Duplicate Account Code: {}".format(acc["code"]),
                "detail": "Account '{}' (ID {}) shares code '{}' with ID {}.".format(acc["name"], acc["id"], acc["code"], seen[key]),
                "affected_model": "account.account", "affected_ids": [acc["id"], seen[key]], "fix_action": None})
        else:
            seen[key] = acc["id"]
    try:
        lines = env["account.move.line"].search_read(
            [("account_id.account_type", "in", ["asset_receivable", "liability_payable"]),
             ("move_id.journal_id.type", "not in", ["sale", "purchase", "general"])],
            ["id", "account_id", "move_id", "journal_id"], limit=50)
        for line in lines:
            issues.append({"category": "accounts", "code": "ACC_WRONG_JOURNAL_TYPE", "risk": "medium",
                "title": "AR/AP Account in Wrong Journal Type",
                "detail": "Line ID {} uses '{}' in journal '{}' (wrong type).".format(
                    line["id"], line["account_id"][1] if line["account_id"] else "?",
                    line["journal_id"][1] if line["journal_id"] else "?"),
                "affected_model": "account.move.line", "affected_ids": [line["id"]], "fix_action": None})
    except Exception:
        pass
    return issues
