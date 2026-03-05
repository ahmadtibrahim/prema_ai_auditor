"""System Scanner: missing params, module states, server snapshot"""
import platform


def scan(env):
    issues = []

    for key, msg in [("web.base.url", "Base URL not set — email links will break."),
                     ("mail.catchall.domain", "Mail catchall domain missing.")]:
        try:
            val = env["ir.config_parameter"].sudo().get_param(key)
            if not val:
                issues.append({"category": "system", "code": "SYS_MISSING_PARAM", "risk": "high",
                    "title": "Missing System Parameter: {}".format(key), "detail": msg,
                    "affected_model": "ir.config_parameter", "affected_ids": [], "fix_action": None})
        except Exception:
            pass

    try:
        pending = env["ir.module.module"].search_read(
            [("state", "in", ["to upgrade", "to install", "to remove"])], ["name", "state", "shortdesc"])
        for mod in pending:
            issues.append({"category": "system", "code": "SYS_MODULE_PENDING", "risk": "medium",
                "title": "Module Pending: {} ({})".format(mod["name"], mod["state"]),
                "detail": "Module '{}' is in state '{}'.".format(mod["shortdesc"], mod["state"]),
                "affected_model": "ir.module.module", "affected_ids": [], "fix_action": None})
    except Exception:
        pass

    try:
        import psutil
        mem = psutil.virtual_memory()
        disk = psutil.disk_usage("/")
        issues.append({"category": "system", "code": "SYS_SNAPSHOT", "risk": "low",
            "title": "Server Snapshot",
            "detail": "OS: {} | RAM: {}GB / {}GB ({}%) | Disk: {}GB / {}GB ({}%)".format(
                platform.release(),
                round(mem.used / 1e9, 1), round(mem.total / 1e9, 1), mem.percent,
                round(disk.used / 1e9, 1), round(disk.total / 1e9, 1), disk.percent),
            "affected_model": None, "affected_ids": [], "fix_action": None})
    except Exception as e:
        issues.append({"category": "system", "code": "SYS_SNAPSHOT", "risk": "low",
            "title": "Server Snapshot (partial)",
            "detail": "OS: {} | psutil not available: {}".format(platform.release(), str(e)),
            "affected_model": None, "affected_ids": [], "fix_action": None})

    return issues
