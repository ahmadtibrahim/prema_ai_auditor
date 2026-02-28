# STRUCTURAL AUDIT REPORT

## Missing models (action res_model not found)
- None

## Missing fields
| file | model | field | source |
|---|---|---|---|
| - | - | - | None |

## Missing actions
- None

## Invalid references
- None

## Wrong load order
- `__manifest__.py` data list is not in strict sequence: security -> data/actions -> views -> menus

## Security gaps
- None
- Models without explicit access rule:
  - `prema.ai.config.audit`
  - `prema.ai.document.processor`
  - `prema.ai.error.monitor`
  - `prema.ai.integrity.engine`
  - `prema.ai.mail.monitor`
  - `prema.ai.performance`
  - `prema.ai.predictive`
  - `prema.ai.realtime`
  - `prema.ai.self.heal`
  - `prema.ai.severity`
  - `prema.ai.write.gate`
  - `prema.anomaly.engine`
  - `prema.approval.engine`
  - `prema.audit.engine`
  - `prema.cra.engine`
  - `prema.fx.validator`
  - `prema.health.score`
  - `prema.integrity.scanner`
  - `prema.mapping.validator`
  - `prema.reconcile.advisor`
  - `prema.risk.matrix`
  - `prema.schema.browser`
  - `prema.tool.registry`

## Odoo 18 list view migration
- Any remaining `<tree>` architecture tags and `view_mode=tree` must be migrated to `<list>` and `view_mode=list`.

## Proposed fixes
1. Replace legacy tree declarations with list views in XML and act_window view_mode.
2. Reorder manifest data load to strict production-safe sequence.
3. Add missing access rights entries for local models where required.
