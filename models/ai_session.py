import json
import logging
import requests

from odoo import api, fields, models

_logger = logging.getLogger(__name__)

OPENAI_API_KEY_PARAM = "openai.api_key"

SYSTEM_PROMPT = """You are an intelligent Odoo 18 ERP assistant and system debugger with full access to this company's database and Odoo environment.

You help with:
- Accounting: invoices, bills, payments, reconciliation, journal entries
- CRM: leads, opportunities, pipeline analysis, forecasting
- Inventory & stock management
- Sales & purchase orders
- HR & payroll
- Bug diagnosis & fixing: finding errors in records, misconfigured fields, broken workflows
- System introspection: installed modules, model fields, configuration parameters
- Data cleanup: duplicate records, orphaned entries, inconsistent data

Available tools:
- search_records: search any Odoo model
- get_model_fields: inspect fields of any model
- get_installed_modules: list all installed Odoo modules
- get_system_config: read system configuration parameters
- get_ir_config_param: read a specific ir.config.parameter
- set_ir_config_param: write a system parameter
- execute_domain_count: count records matching a domain
- check_duplicate_bills: find duplicate vendor bills
- financial_summary: revenue/expense/net overview
- crm_pipeline_analysis: pipeline by stage
- revenue_forecast: weighted CRM forecast
- create_record: create a record (requires confirmation)
- update_record: update a record (requires confirmation)
- delete_record: delete a record (requires confirmation)
- run_python_safe: run read-only Python expressions for debugging (no writes)

Behavior rules:
- ALWAYS ask for explicit user confirmation before creating, updating, or deleting records.
- For debugging questions, use get_model_fields and search_records to investigate before answering.
- Format financial figures with 2 decimal places.
- If unsure of a model name, use search_records on 'ir.model' with [['model','ilike','keyword']].
- Be concise, technical, and business-focused.
- If a tool returns an error, diagnose it and suggest a fix.
"""

TOOLS = [
    {
        "type": "function",
        "function": {
            "name": "search_records",
            "description": "Search and read records from any Odoo model.",
            "parameters": {
                "type": "object",
                "properties": {
                    "model": {"type": "string", "description": "e.g. 'account.move', 'res.partner'"},
                    "domain": {"type": "array", "description": "Odoo domain e.g. [['state','=','posted']]", "items": {}},
                    "fields": {"type": "array", "description": "Field names to return", "items": {"type": "string"}},
                    "limit": {"type": "integer", "description": "Max records, default 50"},
                    "order": {"type": "string", "description": "Sort order e.g. 'create_date desc'"},
                },
                "required": ["model"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "get_model_fields",
            "description": "Get all fields and their types/descriptions for a given Odoo model. Useful for debugging and understanding data structure.",
            "parameters": {
                "type": "object",
                "properties": {
                    "model": {"type": "string", "description": "Odoo model name e.g. 'account.move'"},
                    "filter_type": {"type": "string", "description": "Optional: filter by field type e.g. 'many2one', 'char', 'monetary'"},
                },
                "required": ["model"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "get_installed_modules",
            "description": "List all installed Odoo modules. Useful for checking what's available on the system.",
            "parameters": {
                "type": "object",
                "properties": {
                    "filter_name": {"type": "string", "description": "Optional: filter by module name keyword"},
                },
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "get_system_config",
            "description": "Read system configuration parameters (ir.config_parameter). Useful for checking API keys, feature flags, etc.",
            "parameters": {
                "type": "object",
                "properties": {
                    "search": {"type": "string", "description": "Optional keyword to filter parameter keys"},
                },
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "get_ir_config_param",
            "description": "Read a single system parameter by exact key.",
            "parameters": {
                "type": "object",
                "properties": {
                    "key": {"type": "string", "description": "The parameter key e.g. 'web.base.url'"},
                },
                "required": ["key"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "set_ir_config_param",
            "description": "Write a system configuration parameter. Requires confirmation.",
            "parameters": {
                "type": "object",
                "properties": {
                    "key": {"type": "string"},
                    "value": {"type": "string"},
                    "confirmed": {"type": "boolean"},
                },
                "required": ["key", "value"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "execute_domain_count",
            "description": "Count records in a model matching a domain. Fast way to check data without fetching all records.",
            "parameters": {
                "type": "object",
                "properties": {
                    "model": {"type": "string"},
                    "domain": {"type": "array", "items": {}},
                },
                "required": ["model"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "check_duplicate_bills",
            "description": "Scan all posted vendor bills and return duplicates sharing the same reference and partner.",
            "parameters": {"type": "object", "properties": {}},
        },
    },
    {
        "type": "function",
        "function": {
            "name": "financial_summary",
            "description": "Total revenue, expenses, and net profit from all posted moves.",
            "parameters": {"type": "object", "properties": {}},
        },
    },
    {
        "type": "function",
        "function": {
            "name": "crm_pipeline_analysis",
            "description": "Opportunities count and expected revenue per CRM stage.",
            "parameters": {"type": "object", "properties": {}},
        },
    },
    {
        "type": "function",
        "function": {
            "name": "revenue_forecast",
            "description": "Weighted revenue forecast from open opportunities.",
            "parameters": {"type": "object", "properties": {}},
        },
    },
    {
        "type": "function",
        "function": {
            "name": "create_record",
            "description": "Create a new Odoo record. Requires confirmed=true.",
            "parameters": {
                "type": "object",
                "properties": {
                    "model": {"type": "string"},
                    "values": {"type": "object"},
                    "confirmed": {"type": "boolean"},
                },
                "required": ["model", "values"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "update_record",
            "description": "Update an existing Odoo record. Requires confirmed=true.",
            "parameters": {
                "type": "object",
                "properties": {
                    "model": {"type": "string"},
                    "record_id": {"type": "integer"},
                    "values": {"type": "object"},
                    "confirmed": {"type": "boolean"},
                },
                "required": ["model", "record_id", "values"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "delete_record",
            "description": "Delete an Odoo record. Requires confirmed=true.",
            "parameters": {
                "type": "object",
                "properties": {
                    "model": {"type": "string"},
                    "record_id": {"type": "integer"},
                    "confirmed": {"type": "boolean"},
                },
                "required": ["model", "record_id"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "run_python_safe",
            "description": "Run a read-only Python expression in Odoo context for debugging. Can access self.env. No writes allowed.",
            "parameters": {
                "type": "object",
                "properties": {
                    "expression": {
                        "type": "string",
                        "description": "A Python expression to evaluate, e.g. \"self.env['account.move'].search_count([('state','=','draft')])\"",
                    },
                },
                "required": ["expression"],
            },
        },
    },
]


class PremaAISession(models.Model):
    _name = "prema.ai.session"
    _description = "Prema AI Session"
    _order = "create_date desc"

    name = fields.Char(default="New Chat")
    user_id = fields.Many2one("res.users", default=lambda self: self.env.user)
    message_ids = fields.One2many("prema.ai.message", "session_id")

    # -------------------------------------------------------------------------
    # Public API (called from JS)
    # -------------------------------------------------------------------------

    @api.model
    def list_sessions(self):
        sessions = self.search([("user_id", "=", self.env.user.id)], order="create_date desc")
        return sessions.read(["id", "name"])

    @api.model
    def rename_session(self, session_id, new_name):
        session = self.browse(session_id)
        session.ensure_one()
        session.name = new_name
        return True

    @api.model
    def delete_session(self, session_id):
        session = self.browse(session_id)
        session.ensure_one()
        session.unlink()
        return True

    @api.model
    def send_message(self, session_id, message):
        session = self.browse(session_id)
        session.ensure_one()

        if not message or not message.strip():
            return ""

        self.env["prema.ai.message"].create({
            "session_id": session.id,
            "role": "user",
            "content": message.strip(),
        })

        assistant_reply = session._call_openai()

        self.env["prema.ai.message"].create({
            "session_id": session.id,
            "role": "assistant",
            "content": assistant_reply,
        })

        return assistant_reply

    # -------------------------------------------------------------------------
    # Tools
    # -------------------------------------------------------------------------

    def _tool_registry(self):
        return {
            "search_records": self._tool_search_records,
            "get_model_fields": self._tool_get_model_fields,
            "get_installed_modules": self._tool_get_installed_modules,
            "get_system_config": self._tool_get_system_config,
            "get_ir_config_param": self._tool_get_ir_config_param,
            "set_ir_config_param": self._tool_set_ir_config_param,
            "execute_domain_count": self._tool_execute_domain_count,
            "check_duplicate_bills": self._tool_check_duplicate_bills,
            "financial_summary": self._tool_financial_summary,
            "crm_pipeline_analysis": self._tool_crm_pipeline_analysis,
            "revenue_forecast": self._tool_revenue_forecast,
            "create_record": self._tool_create_record,
            "update_record": self._tool_update_record,
            "delete_record": self._tool_delete_record,
            "run_python_safe": self._tool_run_python_safe,
        }

    def _tool_search_records(self, model, domain=None, fields=None, limit=50, order=None):
        try:
            kwargs = {"limit": int(limit) if limit else 50}
            if order:
                kwargs["order"] = order
            return self.env[model].search_read(domain or [], fields or [], **kwargs)
        except Exception as e:
            return {"error": str(e)}

    def _tool_get_model_fields(self, model, filter_type=None):
        try:
            fields_data = self.env[model].fields_get()
            result = {}
            for fname, finfo in fields_data.items():
                if filter_type and finfo.get("type") != filter_type:
                    continue
                result[fname] = {
                    "type": finfo.get("type"),
                    "string": finfo.get("string"),
                    "required": finfo.get("required", False),
                    "readonly": finfo.get("readonly", False),
                    "relation": finfo.get("relation"),
                }
            return result
        except Exception as e:
            return {"error": str(e)}

    def _tool_get_installed_modules(self, filter_name=None):
        try:
            domain = [("state", "=", "installed")]
            if filter_name:
                domain.append(("name", "ilike", filter_name))
            modules = self.env["ir.module.module"].search_read(
                domain,
                ["name", "shortdesc", "installed_version", "author"],
                order="name asc",
                limit=200,
            )
            return modules
        except Exception as e:
            return {"error": str(e)}

    def _tool_get_system_config(self, search=None):
        try:
            domain = []
            if search:
                domain.append(("key", "ilike", search))
            params = self.env["ir.config_parameter"].sudo().search_read(
                domain, ["key", "value"], limit=100, order="key asc"
            )
            return params
        except Exception as e:
            return {"error": str(e)}

    def _tool_get_ir_config_param(self, key):
        try:
            value = self.env["ir.config_parameter"].sudo().get_param(key)
            return {"key": key, "value": value}
        except Exception as e:
            return {"error": str(e)}

    def _tool_set_ir_config_param(self, key, value, confirmed=False):
        if not confirmed:
            return "⚠️ Confirmation required. Set system parameter '{}' = '{}'. Reply 'yes, confirm' to proceed.".format(key, value)
        try:
            self.env["ir.config_parameter"].sudo().set_param(key, value)
            return {"success": True, "key": key, "value": value}
        except Exception as e:
            return {"error": str(e)}

    def _tool_execute_domain_count(self, model, domain=None):
        try:
            count = self.env[model].search_count(domain or [])
            return {"model": model, "domain": domain, "count": count}
        except Exception as e:
            return {"error": str(e)}

    def _tool_check_duplicate_bills(self):
        try:
            grouped = self.env["account.move"].read_group(
                [("move_type", "=", "in_invoice"), ("state", "!=", "cancel")],
                ["ref", "partner_id", "id:count"],
                ["ref", "partner_id"],
                lazy=False,
            )
            duplicates = [
                {
                    "partner_id": row["partner_id"][0],
                    "partner_name": row["partner_id"][1],
                    "reference": row["ref"],
                    "count": row["id_count"],
                }
                for row in grouped
                if row.get("id_count", 0) > 1 and row.get("ref") and row.get("partner_id")
            ]
            return duplicates if duplicates else "✅ No duplicate bills found."
        except Exception as e:
            return {"error": str(e)}

    def _tool_financial_summary(self):
        try:
            moves = self.env["account.move"].search([
                ("state", "=", "posted"),
                ("move_type", "in", ["out_invoice", "out_refund", "in_invoice", "in_refund"]),
            ])
            revenue = sum(
                moves.filtered(lambda m: m.move_type in ("out_invoice", "out_refund"))
                .mapped("amount_total_signed")
            )
            expense = -sum(
                moves.filtered(lambda m: m.move_type in ("in_invoice", "in_refund"))
                .mapped("amount_total_signed")
            )
            return {
                "posted_moves": len(moves),
                "total_revenue": round(revenue, 2),
                "total_expense": round(expense, 2),
                "net_profit": round(revenue - expense, 2),
            }
        except Exception as e:
            return {"error": str(e)}

    def _tool_crm_pipeline_analysis(self):
        try:
            leads = self.env["crm.lead"].search([])
            breakdown = {}
            for lead in leads:
                stage = lead.stage_id.name or "Undefined"
                breakdown.setdefault(stage, {"count": 0, "expected_revenue": 0.0})
                breakdown[stage]["count"] += 1
                breakdown[stage]["expected_revenue"] += lead.expected_revenue or 0.0
            for s in breakdown:
                breakdown[s]["expected_revenue"] = round(breakdown[s]["expected_revenue"], 2)
            return breakdown if breakdown else "No CRM leads found."
        except Exception as e:
            return {"error": str(e)}

    def _tool_revenue_forecast(self):
        try:
            leads = self.env["crm.lead"].search([("type", "=", "opportunity")])
            weighted = sum(
                (lead.expected_revenue or 0.0) * ((lead.probability or 0.0) / 100.0)
                for lead in leads
            )
            return {"opportunity_count": len(leads), "weighted_forecast": round(weighted, 2)}
        except Exception as e:
            return {"error": str(e)}

    def _tool_create_record(self, model, values, confirmed=False):
        if not confirmed:
            return "⚠️ Confirmation required. Create '{}' with: {}. Reply 'yes, confirm'.".format(
                model, json.dumps(values, default=str)
            )
        try:
            record = self.env[model].create(values or {})
            return {"success": True, "id": record.id}
        except Exception as e:
            return {"error": str(e)}

    def _tool_update_record(self, model, record_id, values, confirmed=False):
        if not confirmed:
            return "⚠️ Confirmation required. Update record {} in '{}' with: {}. Reply 'yes, confirm'.".format(
                record_id, model, json.dumps(values, default=str)
            )
        try:
            self.env[model].browse(record_id).write(values or {})
            return {"success": True}
        except Exception as e:
            return {"error": str(e)}

    def _tool_delete_record(self, model, record_id, confirmed=False):
        if not confirmed:
            return "⚠️ Confirmation required. Delete record {} from '{}'. Reply 'yes, confirm'.".format(
                record_id, model
            )
        try:
            self.env[model].browse(record_id).unlink()
            return {"success": True}
        except Exception as e:
            return {"error": str(e)}

    def _tool_run_python_safe(self, expression):
        """Read-only Python eval for debugging. Blocks any write keywords."""
        blocked = ["write(", "create(", "unlink(", "execute(", "sudo(", "cr.execute", "os.", "subprocess", "open(", "eval(", "exec("]
        for b in blocked:
            if b in expression:
                return {"error": "Expression contains blocked keyword: '{}'. Only read-only expressions allowed.".format(b)}
        try:
            result = eval(expression, {"self": self, "env": self.env})  # noqa: S307
            # Serialize result safely
            if hasattr(result, "read"):
                return result.read()
            return json.loads(json.dumps(result, default=str))
        except Exception as e:
            return {"error": str(e)}

    # -------------------------------------------------------------------------
    # OpenAI call with tool loop
    # -------------------------------------------------------------------------

    def _call_openai(self):
        self.ensure_one()

        api_key = self.env["ir.config_parameter"].sudo().get_param(OPENAI_API_KEY_PARAM)
        if not api_key:
            return (
                "⚠️ OpenAI API key not configured.\n"
                "Go to: Settings → Technical → Parameters → System Parameters\n"
                "Create key: openai.api_key  |  Value: sk-xxxxxxx"
            )

        messages = [{"role": "system", "content": SYSTEM_PROMPT}]
        for msg in self.message_ids:
            messages.append({"role": msg.role, "content": msg.content})

        headers = {"Authorization": f"Bearer {api_key}", "Content-Type": "application/json"}
        tool_registry = self._tool_registry()
        MAX_ITERATIONS = 10

        for _i in range(MAX_ITERATIONS):
            try:
                response = requests.post(
                    "https://api.openai.com/v1/chat/completions",
                    headers=headers,
                    json={
                        "model": "gpt-4o-mini",
                        "messages": messages,
                        "tools": TOOLS,
                        "tool_choice": "auto",
                        "max_tokens": 2000,
                        "temperature": 0.2,
                    },
                    timeout=60,
                )
                response.raise_for_status()
                data = response.json()

            except requests.exceptions.Timeout:
                return "⚠️ Request timed out (60s). Please try again."
            except requests.exceptions.HTTPError:
                try:
                    err = response.json().get("error", {}).get("message", response.text)
                except Exception:
                    err = response.text
                return f"⚠️ OpenAI API error: {err}"
            except Exception as e:
                return f"⚠️ Unexpected error: {str(e)}"

            choice = data["choices"][0]
            assistant_msg = choice["message"]
            messages.append(assistant_msg)

            if choice.get("finish_reason") == "stop" or not assistant_msg.get("tool_calls"):
                return assistant_msg.get("content") or "✅ Done."

            for tool_call in assistant_msg.get("tool_calls", []):
                tool_name = tool_call["function"]["name"]
                try:
                    tool_args = json.loads(tool_call["function"]["arguments"])
                except json.JSONDecodeError:
                    tool_args = {}

                tool_fn = tool_registry.get(tool_name)
                if tool_fn:
                    try:
                        tool_result = tool_fn(**tool_args)
                    except Exception as e:
                        tool_result = {"error": f"Tool '{tool_name}' failed: {str(e)}"}
                else:
                    tool_result = {"error": f"Unknown tool: '{tool_name}'"}

                _logger.info("Prema AI tool '%s' result: %s", tool_name, str(tool_result)[:200])

                messages.append({
                    "role": "tool",
                    "tool_call_id": tool_call["id"],
                    "content": json.dumps(tool_result, default=str),
                })

        return "⚠️ Max iterations reached. Try a more specific question."
