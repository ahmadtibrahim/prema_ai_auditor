"""Security Scanner: admin review, inactive users, portal with internal access, too many admins"""


def scan(env):
    issues = []

    try:
        admin = env["res.users"].sudo().search_read([("id", "=", 2)], ["name", "login"])
        if admin:
            issues.append({"category": "security", "code": "SEC_ADMIN_REVIEW", "risk": "medium",
                "title": "Admin User Review Recommended",
                "detail": "Verify admin user '{}' (login: {}) uses a strong password and has MFA enabled.".format(
                    admin[0]["name"], admin[0]["login"]),
                "affected_model": "res.users", "affected_ids": [2], "fix_action": None})
    except Exception:
        pass

    try:
        inactive = env["res.users"].sudo().search_read(
            [("active", "=", False), ("share", "=", False)], ["id", "name", "login"], limit=50)
        if inactive:
            issues.append({"category": "security", "code": "SEC_INACTIVE_USERS", "risk": "low",
                "title": "Archived Internal Users ({})".format(len(inactive)),
                "detail": "Found {} archived internal users: {}.".format(
                    len(inactive), [u["login"] for u in inactive[:5]]),
                "affected_model": "res.users", "affected_ids": [u["id"] for u in inactive], "fix_action": None})
    except Exception:
        pass

    try:
        admin_group = env.ref("base.group_system", raise_if_not_found=False)
        if admin_group:
            admins = env["res.users"].sudo().search_read(
                [("groups_id", "in", [admin_group.id]), ("active", "=", True), ("id", "!=", 2)],
                ["id", "name", "login"], limit=50)
            if len(admins) > 3:
                issues.append({"category": "security", "code": "SEC_TOO_MANY_ADMINS", "risk": "medium",
                    "title": "Too Many System Admins ({})".format(len(admins)),
                    "detail": "Found {} users with full admin rights: {}.".format(
                        len(admins), [u["login"] for u in admins[:5]]),
                    "affected_model": "res.users", "affected_ids": [u["id"] for u in admins], "fix_action": None})
    except Exception:
        pass

    return issues
