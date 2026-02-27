                             conname                             |                          table_name                           |                                                                                                                                                                                                                                                       pg_get_constraintdef                                                                                                                                                                                                                                                       
-----------------------------------------------------------------+---------------------------------------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 cardinal_number_domain_check                                    | -                                                             | CHECK ((VALUE >= 0))
 yes_or_no_check                                                 | -                                                             | CHECK (((VALUE)::text = ANY ((ARRAY['YES'::character varying, 'NO'::character varying])::text[])))
 account_account_currency_id_fkey                                | account_account                                               | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 account_account_disallowed_expenses_category_id_fkey            | account_account                                               | FOREIGN KEY (disallowed_expenses_category_id) REFERENCES account_disallowed_expenses_category(id) ON DELETE SET NULL
 account_account_pkey                                            | account_account                                               | PRIMARY KEY (id)
 account_account_write_uid_fkey                                  | account_account                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_account_create_uid_fkey                                 | account_account                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_account_account_asset_rel_account_asset_id_fkey         | account_account_account_asset_rel                             | FOREIGN KEY (account_asset_id) REFERENCES account_asset(id) ON DELETE CASCADE
 account_account_account_asset_rel_account_account_id_fkey       | account_account_account_asset_rel                             | FOREIGN KEY (account_account_id) REFERENCES account_account(id) ON DELETE CASCADE
 account_account_account_asset_rel_pkey                          | account_account_account_asset_rel                             | PRIMARY KEY (account_account_id, account_asset_id)
 account_account_account_auto_reconcile__account_account_id_fkey | account_account_account_auto_reconcile_wizard_rel             | FOREIGN KEY (account_account_id) REFERENCES account_account(id) ON DELETE CASCADE
 account_account_account_auto_reconcile_wizard_rel_pkey          | account_account_account_auto_reconcile_wizard_rel             | PRIMARY KEY (account_auto_reconcile_wizard_id, account_account_id)
 account_account_account_auto__account_auto_reconcile_wizar_fkey | account_account_account_auto_reconcile_wizard_rel             | FOREIGN KEY (account_auto_reconcile_wizard_id) REFERENCES account_auto_reconcile_wizard(id) ON DELETE CASCADE
 account_account_account_import_summary__account_account_id_fkey | account_account_account_import_summary_rel                    | FOREIGN KEY (account_account_id) REFERENCES account_account(id) ON DELETE CASCADE
 account_account_account_import_summary_rel_pkey                 | account_account_account_import_summary_rel                    | PRIMARY KEY (account_import_summary_id, account_account_id)
 account_account_account_import_s_account_import_summary_id_fkey | account_account_account_import_summary_rel                    | FOREIGN KEY (account_import_summary_id) REFERENCES account_import_summary(id) ON DELETE CASCADE
 account_account_account_journal_rel_account_journal_id_fkey     | account_account_account_journal_rel                           | FOREIGN KEY (account_journal_id) REFERENCES account_journal(id) ON DELETE CASCADE
 account_account_account_journal_rel_pkey                        | account_account_account_journal_rel                           | PRIMARY KEY (account_account_id, account_journal_id)
 account_account_account_journal_rel_account_account_id_fkey     | account_account_account_journal_rel                           | FOREIGN KEY (account_account_id) REFERENCES account_account(id) ON DELETE CASCADE
 account_account_account_merge_wizard_rel_pkey                   | account_account_account_merge_wizard_rel                      | PRIMARY KEY (account_merge_wizard_id, account_account_id)
 account_account_account_merge_wiza_account_merge_wizard_id_fkey | account_account_account_merge_wizard_rel                      | FOREIGN KEY (account_merge_wizard_id) REFERENCES account_merge_wizard(id) ON DELETE CASCADE
 account_account_account_merge_wizard_re_account_account_id_fkey | account_account_account_merge_wizard_rel                      | FOREIGN KEY (account_account_id) REFERENCES account_account(id) ON DELETE CASCADE
 account_account_account_tag_account_account_tag_id_fkey         | account_account_account_tag                                   | FOREIGN KEY (account_account_tag_id) REFERENCES account_account_tag(id) ON DELETE RESTRICT
 account_account_account_tag_account_account_id_fkey             | account_account_account_tag                                   | FOREIGN KEY (account_account_id) REFERENCES account_account(id) ON DELETE CASCADE
 account_account_account_tag_pkey                                | account_account_account_tag                                   | PRIMARY KEY (account_account_id, account_account_tag_id)
 account_account_exclude_res_currency_provision_pkey             | account_account_exclude_res_currency_provision                | PRIMARY KEY (account_account_id, res_currency_id)
 account_account_exclude_res_currency_provi_res_currency_id_fkey | account_account_exclude_res_currency_provision                | FOREIGN KEY (res_currency_id) REFERENCES res_currency(id) ON DELETE CASCADE
 account_account_exclude_res_currency_pr_account_account_id_fkey | account_account_exclude_res_currency_provision                | FOREIGN KEY (account_account_id) REFERENCES account_account(id) ON DELETE CASCADE
 account_account_res_company_rel_account_account_id_fkey         | account_account_res_company_rel                               | FOREIGN KEY (account_account_id) REFERENCES account_account(id) ON DELETE CASCADE
 account_account_res_company_rel_res_company_id_fkey             | account_account_res_company_rel                               | FOREIGN KEY (res_company_id) REFERENCES res_company(id) ON DELETE CASCADE
 account_account_res_company_rel_pkey                            | account_account_res_company_rel                               | PRIMARY KEY (account_account_id, res_company_id)
 account_account_tag_pkey                                        | account_account_tag                                           | PRIMARY KEY (id)
 account_account_tag_write_uid_fkey                              | account_account_tag                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_account_tag_create_uid_fkey                             | account_account_tag                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_account_tag_country_id_fkey                             | account_account_tag                                           | FOREIGN KEY (country_id) REFERENCES res_country(id) ON DELETE SET NULL
 account_account_tag_name_uniq                                   | account_account_tag                                           | UNIQUE (name, applicability, country_id)
 account_account_tag_account_move_line_account_move_line_id_fkey | account_account_tag_account_move_line_rel                     | FOREIGN KEY (account_move_line_id) REFERENCES account_move_line(id) ON DELETE CASCADE
 account_account_tag_account_move_li_account_account_tag_id_fkey | account_account_tag_account_move_line_rel                     | FOREIGN KEY (account_account_tag_id) REFERENCES account_account_tag(id) ON DELETE RESTRICT
 account_account_tag_account_move_line_rel_pkey                  | account_account_tag_account_move_line_rel                     | PRIMARY KEY (account_move_line_id, account_account_tag_id)
 account_account_tag_account_tax_repartition_line_rel_pkey       | account_account_tag_account_tax_repartition_line_rel          | PRIMARY KEY (account_tax_repartition_line_id, account_account_tag_id)
 account_account_tag_account_t_account_tax_repartition_line_fkey | account_account_tag_account_tax_repartition_line_rel          | FOREIGN KEY (account_tax_repartition_line_id) REFERENCES account_tax_repartition_line(id) ON DELETE CASCADE
 account_account_tag_account_tax_rep_account_account_tag_id_fkey | account_account_tag_account_tax_repartition_line_rel          | FOREIGN KEY (account_account_tag_id) REFERENCES account_account_tag(id) ON DELETE RESTRICT
 account_account_tag_product_template_rel_pkey                   | account_account_tag_product_template_rel                      | PRIMARY KEY (product_template_id, account_account_tag_id)
 account_account_tag_product_templat_account_account_tag_id_fkey | account_account_tag_product_template_rel                      | FOREIGN KEY (account_account_tag_id) REFERENCES account_account_tag(id) ON DELETE CASCADE
 account_account_tag_product_template_r_product_template_id_fkey | account_account_tag_product_template_rel                      | FOREIGN KEY (product_template_id) REFERENCES product_template(id) ON DELETE CASCADE
 account_account_tax_default_rel_pkey                            | account_account_tax_default_rel                               | PRIMARY KEY (account_id, tax_id)
 account_account_tax_default_rel_account_id_fkey                 | account_account_tax_default_rel                               | FOREIGN KEY (account_id) REFERENCES account_account(id) ON DELETE CASCADE
 account_account_tax_default_rel_tax_id_fkey                     | account_account_tax_default_rel                               | FOREIGN KEY (tax_id) REFERENCES account_tax(id) ON DELETE CASCADE
 account_accrued_orders_wizard_journal_id_fkey                   | account_accrued_orders_wizard                                 | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE CASCADE
 account_accrued_orders_wizard_account_id_fkey                   | account_accrued_orders_wizard                                 | FOREIGN KEY (account_id) REFERENCES account_account(id) ON DELETE CASCADE
 account_accrued_orders_wizard_pkey                              | account_accrued_orders_wizard                                 | PRIMARY KEY (id)
 account_accrued_orders_wizard_currency_id_fkey                  | account_accrued_orders_wizard                                 | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 account_accrued_orders_wizard_company_id_fkey                   | account_accrued_orders_wizard                                 | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 account_accrued_orders_wizard_create_uid_fkey                   | account_accrued_orders_wizard                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_accrued_orders_wizard_write_uid_fkey                    | account_accrued_orders_wizard                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_analytic_account_create_uid_fkey                        | account_analytic_account                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_analytic_account_plan_id_fkey                           | account_analytic_account                                      | FOREIGN KEY (plan_id) REFERENCES account_analytic_plan(id) ON DELETE RESTRICT
 account_analytic_account_root_plan_id_fkey                      | account_analytic_account                                      | FOREIGN KEY (root_plan_id) REFERENCES account_analytic_plan(id) ON DELETE SET NULL
 account_analytic_account_company_id_fkey                        | account_analytic_account                                      | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 account_analytic_account_partner_id_fkey                        | account_analytic_account                                      | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 account_analytic_account_write_uid_fkey                         | account_analytic_account                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_analytic_account_pkey                                   | account_analytic_account                                      | PRIMARY KEY (id)
 account_analytic_account_account_transfer_model_line_rel_pkey   | account_analytic_account_account_transfer_model_line_rel      | PRIMARY KEY (account_transfer_model_line_id, account_analytic_account_id)
 account_analytic_account_acco_account_transfer_model_line__fkey | account_analytic_account_account_transfer_model_line_rel      | FOREIGN KEY (account_transfer_model_line_id) REFERENCES account_transfer_model_line(id) ON DELETE CASCADE
 account_analytic_account_accou_account_analytic_account_id_fkey | account_analytic_account_account_transfer_model_line_rel      | FOREIGN KEY (account_analytic_account_id) REFERENCES account_analytic_account(id) ON DELETE CASCADE
 account_analytic_account_mrp_bom_rel_pkey                       | account_analytic_account_mrp_bom_rel                          | PRIMARY KEY (account_analytic_account_id, mrp_bom_id)
 account_analytic_account_mrp_bom_rel_mrp_bom_id_fkey            | account_analytic_account_mrp_bom_rel                          | FOREIGN KEY (mrp_bom_id) REFERENCES mrp_bom(id) ON DELETE CASCADE
 account_analytic_account_mrp_b_account_analytic_account_id_fkey | account_analytic_account_mrp_bom_rel                          | FOREIGN KEY (account_analytic_account_id) REFERENCES account_analytic_account(id) ON DELETE CASCADE
 account_analytic_account_mrp_production__mrp_production_id_fkey | account_analytic_account_mrp_production_rel                   | FOREIGN KEY (mrp_production_id) REFERENCES mrp_production(id) ON DELETE CASCADE
 account_analytic_account_mrp_p_account_analytic_account_id_fkey | account_analytic_account_mrp_production_rel                   | FOREIGN KEY (account_analytic_account_id) REFERENCES account_analytic_account(id) ON DELETE CASCADE
 account_analytic_account_mrp_production_rel_pkey                | account_analytic_account_mrp_production_rel                   | PRIMARY KEY (account_analytic_account_id, mrp_production_id)
 account_analytic_account_mrp_w_account_analytic_account_id_fkey | account_analytic_account_mrp_workcenter_rel                   | FOREIGN KEY (account_analytic_account_id) REFERENCES account_analytic_account(id) ON DELETE CASCADE
 account_analytic_account_mrp_workcenter_rel_pkey                | account_analytic_account_mrp_workcenter_rel                   | PRIMARY KEY (account_analytic_account_id, mrp_workcenter_id)
 account_analytic_account_mrp_workcenter__mrp_workcenter_id_fkey | account_analytic_account_mrp_workcenter_rel                   | FOREIGN KEY (mrp_workcenter_id) REFERENCES mrp_workcenter(id) ON DELETE CASCADE
 account_analytic_applicability_company_id_fkey                  | account_analytic_applicability                                | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 account_analytic_applicability_product_categ_id_fkey            | account_analytic_applicability                                | FOREIGN KEY (product_categ_id) REFERENCES product_category(id) ON DELETE SET NULL
 account_analytic_applicability_pkey                             | account_analytic_applicability                                | PRIMARY KEY (id)
 account_analytic_applicability_analytic_plan_id_fkey            | account_analytic_applicability                                | FOREIGN KEY (analytic_plan_id) REFERENCES account_analytic_plan(id) ON DELETE SET NULL
 account_analytic_applicability_write_uid_fkey                   | account_analytic_applicability                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_analytic_applicability_create_uid_fkey                  | account_analytic_applicability                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_analytic_distribution_model_partner_id_fkey             | account_analytic_distribution_model                           | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 account_analytic_distribution_model_company_id_fkey             | account_analytic_distribution_model                           | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE CASCADE
 account_analytic_distribution_model_write_uid_fkey              | account_analytic_distribution_model                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_analytic_distribution_model_create_uid_fkey             | account_analytic_distribution_model                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_analytic_distribution_model_pkey                        | account_analytic_distribution_model                           | PRIMARY KEY (id)
 account_analytic_distribution_model_product_id_fkey             | account_analytic_distribution_model                           | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE CASCADE
 account_analytic_distribution_model_product_categ_id_fkey       | account_analytic_distribution_model                           | FOREIGN KEY (product_categ_id) REFERENCES product_category(id) ON DELETE CASCADE
 account_analytic_distribution_model_partner_category_id_fkey    | account_analytic_distribution_model                           | FOREIGN KEY (partner_category_id) REFERENCES res_partner_category(id) ON DELETE CASCADE
 account_analytic_line_general_account_id_fkey                   | account_analytic_line                                         | FOREIGN KEY (general_account_id) REFERENCES account_account(id) ON DELETE RESTRICT
 account_analytic_line_order_id_fkey                             | account_analytic_line                                         | FOREIGN KEY (order_id) REFERENCES sale_order(id) ON DELETE SET NULL
 account_analytic_line_so_line_fkey                              | account_analytic_line                                         | FOREIGN KEY (so_line) REFERENCES sale_order_line(id) ON DELETE SET NULL
 account_analytic_line_timesheet_invoice_id_fkey                 | account_analytic_line                                         | FOREIGN KEY (timesheet_invoice_id) REFERENCES account_move(id) ON DELETE SET NULL
 account_analytic_line_employee_id_fkey                          | account_analytic_line                                         | FOREIGN KEY (employee_id) REFERENCES hr_employee(id) ON DELETE SET NULL
 account_analytic_line_manager_id_fkey                           | account_analytic_line                                         | FOREIGN KEY (manager_id) REFERENCES hr_employee(id) ON DELETE SET NULL
 account_analytic_line_department_id_fkey                        | account_analytic_line                                         | FOREIGN KEY (department_id) REFERENCES hr_department(id) ON DELETE SET NULL
 account_analytic_line_project_id_fkey                           | account_analytic_line                                         | FOREIGN KEY (project_id) REFERENCES project_project(id) ON DELETE SET NULL
 account_analytic_line_parent_task_id_fkey                       | account_analytic_line                                         | FOREIGN KEY (parent_task_id) REFERENCES project_task(id) ON DELETE SET NULL
 account_analytic_line_task_id_fkey                              | account_analytic_line                                         | FOREIGN KEY (task_id) REFERENCES project_task(id) ON DELETE SET NULL
 account_analytic_line_write_uid_fkey                            | account_analytic_line                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_analytic_line_create_uid_fkey                           | account_analytic_line                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_analytic_line_currency_id_fkey                          | account_analytic_line                                         | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 account_analytic_line_company_id_fkey                           | account_analytic_line                                         | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 account_analytic_line_user_id_fkey                              | account_analytic_line                                         | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 account_analytic_line_partner_id_fkey                           | account_analytic_line                                         | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 account_analytic_line_product_uom_id_fkey                       | account_analytic_line                                         | FOREIGN KEY (product_uom_id) REFERENCES uom_uom(id) ON DELETE SET NULL
 account_analytic_line_account_id_fkey                           | account_analytic_line                                         | FOREIGN KEY (account_id) REFERENCES account_analytic_account(id) ON DELETE RESTRICT
 account_analytic_line_move_line_id_fkey                         | account_analytic_line                                         | FOREIGN KEY (move_line_id) REFERENCES account_move_line(id) ON DELETE CASCADE
 account_analytic_line_journal_id_fkey                           | account_analytic_line                                         | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 account_analytic_line_product_id_fkey                           | account_analytic_line                                         | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE SET NULL
 account_analytic_line_x_plan2_id_fkey                           | account_analytic_line                                         | FOREIGN KEY (x_plan2_id) REFERENCES account_analytic_account(id) ON DELETE RESTRICT
 account_analytic_line_pkey                                      | account_analytic_line                                         | PRIMARY KEY (id)
 account_analytic_line_x_plan4_id_fkey                           | account_analytic_line                                         | FOREIGN KEY (x_plan4_id) REFERENCES account_analytic_account(id) ON DELETE RESTRICT
 account_analytic_line_hr_timeshee_account_analytic_line_id_fkey | account_analytic_line_hr_timesheet_merge_wizard_rel           | FOREIGN KEY (account_analytic_line_id) REFERENCES account_analytic_line(id) ON DELETE CASCADE
 account_analytic_line_hr_time_hr_timesheet_merge_wizard_id_fkey | account_analytic_line_hr_timesheet_merge_wizard_rel           | FOREIGN KEY (hr_timesheet_merge_wizard_id) REFERENCES hr_timesheet_merge_wizard(id) ON DELETE CASCADE
 account_analytic_line_hr_timesheet_merge_wizard_rel_pkey        | account_analytic_line_hr_timesheet_merge_wizard_rel           | PRIMARY KEY (hr_timesheet_merge_wizard_id, account_analytic_line_id)
 account_analytic_line_mrp_workord_account_analytic_line_id_fkey | account_analytic_line_mrp_workorder_rel                       | FOREIGN KEY (account_analytic_line_id) REFERENCES account_analytic_line(id) ON DELETE CASCADE
 account_analytic_line_mrp_workorder_rel_mrp_workorder_id_fkey   | account_analytic_line_mrp_workorder_rel                       | FOREIGN KEY (mrp_workorder_id) REFERENCES mrp_workorder(id) ON DELETE CASCADE
 account_analytic_line_mrp_workorder_rel_pkey                    | account_analytic_line_mrp_workorder_rel                       | PRIMARY KEY (mrp_workorder_id, account_analytic_line_id)
 account_analytic_line_stock_move_rel_pkey                       | account_analytic_line_stock_move_rel                          | PRIMARY KEY (stock_move_id, account_analytic_line_id)
 account_analytic_line_stock_move__account_analytic_line_id_fkey | account_analytic_line_stock_move_rel                          | FOREIGN KEY (account_analytic_line_id) REFERENCES account_analytic_line(id) ON DELETE CASCADE
 account_analytic_line_stock_move_rel_stock_move_id_fkey         | account_analytic_line_stock_move_rel                          | FOREIGN KEY (stock_move_id) REFERENCES stock_move(id) ON DELETE CASCADE
 account_analytic_plan_create_uid_fkey                           | account_analytic_plan                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_analytic_plan_pkey                                      | account_analytic_plan                                         | PRIMARY KEY (id)
 account_analytic_plan_write_uid_fkey                            | account_analytic_plan                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_analytic_plan_parent_id_fkey                            | account_analytic_plan                                         | FOREIGN KEY (parent_id) REFERENCES account_analytic_plan(id) ON DELETE CASCADE
 account_analytic_plan_budget_split_wizard_rel_pkey              | account_analytic_plan_budget_split_wizard_rel                 | PRIMARY KEY (budget_split_wizard_id, account_analytic_plan_id)
 account_analytic_plan_budget_split__budget_split_wizard_id_fkey | account_analytic_plan_budget_split_wizard_rel                 | FOREIGN KEY (budget_split_wizard_id) REFERENCES budget_split_wizard(id) ON DELETE CASCADE
 account_analytic_plan_budget_spli_account_analytic_plan_id_fkey | account_analytic_plan_budget_split_wizard_rel                 | FOREIGN KEY (account_analytic_plan_id) REFERENCES account_analytic_plan(id) ON DELETE CASCADE
 account_asset_account_depreciation_id_fkey                      | account_asset                                                 | FOREIGN KEY (account_depreciation_id) REFERENCES account_account(id) ON DELETE SET NULL
 account_asset_vehicle_id_fkey                                   | account_asset                                                 | FOREIGN KEY (vehicle_id) REFERENCES fleet_vehicle(id) ON DELETE SET NULL
 account_asset_parent_id_fkey                                    | account_asset                                                 | FOREIGN KEY (parent_id) REFERENCES account_asset(id) ON DELETE SET NULL
 account_asset_company_id_fkey                                   | account_asset                                                 | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 account_asset_create_uid_fkey                                   | account_asset                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_asset_account_depreciation_expense_id_fkey              | account_asset                                                 | FOREIGN KEY (account_depreciation_expense_id) REFERENCES account_account(id) ON DELETE SET NULL
 account_asset_model_id_fkey                                     | account_asset                                                 | FOREIGN KEY (model_id) REFERENCES account_asset(id) ON DELETE SET NULL
 account_asset_journal_id_fkey                                   | account_asset                                                 | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 account_asset_currency_id_fkey                                  | account_asset                                                 | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 account_asset_pkey                                              | account_asset                                                 | PRIMARY KEY (id)
 account_asset_account_asset_id_fkey                             | account_asset                                                 | FOREIGN KEY (account_asset_id) REFERENCES account_account(id) ON DELETE SET NULL
 account_asset_asset_group_id_fkey                               | account_asset                                                 | FOREIGN KEY (asset_group_id) REFERENCES account_asset_group(id) ON DELETE SET NULL
 account_asset_write_uid_fkey                                    | account_asset                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_asset_group_write_uid_fkey                              | account_asset_group                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_asset_group_company_id_fkey                             | account_asset_group                                           | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 account_asset_group_pkey                                        | account_asset_group                                           | PRIMARY KEY (id)
 account_asset_group_create_uid_fkey                             | account_asset_group                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_auto_reconcile_wizard_company_id_fkey                   | account_auto_reconcile_wizard                                 | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE CASCADE
 account_auto_reconcile_wizard_write_uid_fkey                    | account_auto_reconcile_wizard                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_auto_reconcile_wizard_create_uid_fkey                   | account_auto_reconcile_wizard                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_auto_reconcile_wizard_pkey                              | account_auto_reconcile_wizard                                 | PRIMARY KEY (id)
 account_auto_reconcile_wizard_account_account_move_line_id_fkey | account_auto_reconcile_wizard_account_move_line_rel           | FOREIGN KEY (account_move_line_id) REFERENCES account_move_line(id) ON DELETE CASCADE
 account_auto_reconcile_wizard_account_auto_reconcile_wizar_fkey | account_auto_reconcile_wizard_account_move_line_rel           | FOREIGN KEY (account_auto_reconcile_wizard_id) REFERENCES account_auto_reconcile_wizard(id) ON DELETE CASCADE
 account_auto_reconcile_wizard_account_move_line_rel_pkey        | account_auto_reconcile_wizard_account_move_line_rel           | PRIMARY KEY (account_auto_reconcile_wizard_id, account_move_line_id)
 account_auto_reconcile_wizard_res_partner_r_res_partner_id_fkey | account_auto_reconcile_wizard_res_partner_rel                 | FOREIGN KEY (res_partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 account_auto_reconcile_wizard_res_partner_rel_pkey              | account_auto_reconcile_wizard_res_partner_rel                 | PRIMARY KEY (account_auto_reconcile_wizard_id, res_partner_id)
 account_auto_reconcile_wizar_account_auto_reconcile_wizar_fkey1 | account_auto_reconcile_wizard_res_partner_rel                 | FOREIGN KEY (account_auto_reconcile_wizard_id) REFERENCES account_auto_reconcile_wizard(id) ON DELETE CASCADE
 account_automatic_entry_wizard_pkey                             | account_automatic_entry_wizard                                | PRIMARY KEY (id)
 account_automatic_entry_wizard_write_uid_fkey                   | account_automatic_entry_wizard                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_automatic_entry_wizard_create_uid_fkey                  | account_automatic_entry_wizard                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_automatic_entry_wizard_destination_account_id_fkey      | account_automatic_entry_wizard                                | FOREIGN KEY (destination_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 account_automatic_entry_wizard_company_id_fkey                  | account_automatic_entry_wizard                                | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE CASCADE
 account_automatic_entry_wizard_account_move_line_rel_pkey       | account_automatic_entry_wizard_account_move_line_rel          | PRIMARY KEY (account_automatic_entry_wizard_id, account_move_line_id)
 account_automatic_entry_wizar_account_automatic_entry_wiza_fkey | account_automatic_entry_wizard_account_move_line_rel          | FOREIGN KEY (account_automatic_entry_wizard_id) REFERENCES account_automatic_entry_wizard(id) ON DELETE CASCADE
 account_automatic_entry_wizard_accoun_account_move_line_id_fkey | account_automatic_entry_wizard_account_move_line_rel          | FOREIGN KEY (account_move_line_id) REFERENCES account_move_line(id) ON DELETE CASCADE
 account_autopost_bills_wizard_write_uid_fkey                    | account_autopost_bills_wizard                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_autopost_bills_wizard_partner_id_fkey                   | account_autopost_bills_wizard                                 | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 account_autopost_bills_wizard_create_uid_fkey                   | account_autopost_bills_wizard                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_autopost_bills_wizard_pkey                              | account_autopost_bills_wizard                                 | PRIMARY KEY (id)
 account_bank_selection_selected_account_fkey                    | account_bank_selection                                        | FOREIGN KEY (selected_account) REFERENCES account_online_account(id) ON DELETE SET NULL
 account_bank_selection_create_uid_fkey                          | account_bank_selection                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_bank_selection_write_uid_fkey                           | account_bank_selection                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_bank_selection_account_online_link_id_fkey              | account_bank_selection                                        | FOREIGN KEY (account_online_link_id) REFERENCES account_online_link(id) ON DELETE SET NULL
 account_bank_selection_pkey                                     | account_bank_selection                                        | PRIMARY KEY (id)
 account_bank_statement_journal_id_fkey                          | account_bank_statement                                        | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 account_bank_statement_message_main_attachment_id_fkey          | account_bank_statement                                        | FOREIGN KEY (message_main_attachment_id) REFERENCES ir_attachment(id) ON DELETE SET NULL
 account_bank_statement_company_id_fkey                          | account_bank_statement                                        | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 account_bank_statement_create_uid_fkey                          | account_bank_statement                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_bank_statement_write_uid_fkey                           | account_bank_statement                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_bank_statement_pkey                                     | account_bank_statement                                        | PRIMARY KEY (id)
 account_bank_statement_ir_attachment_rel_pkey                   | account_bank_statement_ir_attachment_rel                      | PRIMARY KEY (account_bank_statement_id, ir_attachment_id)
 account_bank_statement_ir_attach_account_bank_statement_id_fkey | account_bank_statement_ir_attachment_rel                      | FOREIGN KEY (account_bank_statement_id) REFERENCES account_bank_statement(id) ON DELETE CASCADE
 account_bank_statement_ir_attachment_rel_ir_attachment_id_fkey  | account_bank_statement_ir_attachment_rel                      | FOREIGN KEY (ir_attachment_id) REFERENCES ir_attachment(id) ON DELETE CASCADE
 account_bank_statement_line_create_uid_fkey                     | account_bank_statement_line                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_bank_statement_line_unique_import_id                    | account_bank_statement_line                                   | UNIQUE (unique_import_id)
 account_bank_statement_line_journal_id_fkey                     | account_bank_statement_line                                   | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 account_bank_statement_line_company_id_fkey                     | account_bank_statement_line                                   | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 account_bank_statement_line_statement_id_fkey                   | account_bank_statement_line                                   | FOREIGN KEY (statement_id) REFERENCES account_bank_statement(id) ON DELETE SET NULL
 account_bank_statement_line_online_account_id_fkey              | account_bank_statement_line                                   | FOREIGN KEY (online_account_id) REFERENCES account_online_account(id) ON DELETE SET NULL
 account_bank_statement_line_online_link_id_fkey                 | account_bank_statement_line                                   | FOREIGN KEY (online_link_id) REFERENCES account_online_link(id) ON DELETE SET NULL
 account_bank_statement_line_partner_id_fkey                     | account_bank_statement_line                                   | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE RESTRICT
 account_bank_statement_line_currency_id_fkey                    | account_bank_statement_line                                   | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 account_bank_statement_line_foreign_currency_id_fkey            | account_bank_statement_line                                   | FOREIGN KEY (foreign_currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 account_bank_statement_line_write_uid_fkey                      | account_bank_statement_line                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_bank_statement_line_pkey                                | account_bank_statement_line                                   | PRIMARY KEY (id)
 account_bank_statement_line_move_id_fkey                        | account_bank_statement_line                                   | FOREIGN KEY (move_id) REFERENCES account_move(id) ON DELETE CASCADE
 account_bank_statement_line_transient_write_uid_fkey            | account_bank_statement_line_transient                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_bank_statement_line_transient_online_account_id_fkey    | account_bank_statement_line_transient                         | FOREIGN KEY (online_account_id) REFERENCES account_online_account(id) ON DELETE SET NULL
 account_bank_statement_line_transient_create_uid_fkey           | account_bank_statement_line_transient                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_bank_statement_line_transient_foreign_currency_id_fkey  | account_bank_statement_line_transient                         | FOREIGN KEY (foreign_currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 account_bank_statement_line_transient_company_id_fkey           | account_bank_statement_line_transient                         | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 account_bank_statement_line_transient_pkey                      | account_bank_statement_line_transient                         | PRIMARY KEY (id)
 account_bank_statement_line_transient_journal_id_fkey           | account_bank_statement_line_transient                         | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 account_cash_rounding_write_uid_fkey                            | account_cash_rounding                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_cash_rounding_pkey                                      | account_cash_rounding                                         | PRIMARY KEY (id)
 account_cash_rounding_create_uid_fkey                           | account_cash_rounding                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_change_lock_date_company_id_fkey                        | account_change_lock_date                                      | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE CASCADE
 account_change_lock_date_write_uid_fkey                         | account_change_lock_date                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_change_lock_date_create_uid_fkey                        | account_change_lock_date                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_change_lock_date_pkey                                   | account_change_lock_date                                      | PRIMARY KEY (id)
 account_disallowed_expenses_category_write_uid_fkey             | account_disallowed_expenses_category                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_disallowed_expenses_category_create_uid_fkey            | account_disallowed_expenses_category                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_disallowed_expenses_category_company_id_fkey            | account_disallowed_expenses_category                          | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 account_disallowed_expenses_category_unique_code                | account_disallowed_expenses_category                          | UNIQUE (code)
 account_disallowed_expenses_category_pkey                       | account_disallowed_expenses_category                          | PRIMARY KEY (id)
 account_disallowed_expenses_rate_pkey                           | account_disallowed_expenses_rate                              | PRIMARY KEY (id)
 account_disallowed_expenses_rate_company_id_fkey                | account_disallowed_expenses_rate                              | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 account_disallowed_expenses_rate_category_id_fkey               | account_disallowed_expenses_rate                              | FOREIGN KEY (category_id) REFERENCES account_disallowed_expenses_category(id) ON DELETE CASCADE
 account_disallowed_expenses_rate_create_uid_fkey                | account_disallowed_expenses_rate                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_disallowed_expenses_rate_write_uid_fkey                 | account_disallowed_expenses_rate                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_duplicate_transaction_wizard_write_uid_fkey             | account_duplicate_transaction_wizard                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_duplicate_transaction_wizard_pkey                       | account_duplicate_transaction_wizard                          | PRIMARY KEY (id)
 account_duplicate_transaction_wizard_journal_id_fkey            | account_duplicate_transaction_wizard                          | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 account_duplicate_transaction_wizard_create_uid_fkey            | account_duplicate_transaction_wizard                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_financial_year_op_create_uid_fkey                       | account_financial_year_op                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_financial_year_op_pkey                                  | account_financial_year_op                                     | PRIMARY KEY (id)
 account_financial_year_op_company_id_fkey                       | account_financial_year_op                                     | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE CASCADE
 account_financial_year_op_write_uid_fkey                        | account_financial_year_op                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_fiscal_position_pkey                                    | account_fiscal_position                                       | PRIMARY KEY (id)
 account_fiscal_position_company_id_fkey                         | account_fiscal_position                                       | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 account_fiscal_position_country_id_fkey                         | account_fiscal_position                                       | FOREIGN KEY (country_id) REFERENCES res_country(id) ON DELETE SET NULL
 account_fiscal_position_country_group_id_fkey                   | account_fiscal_position                                       | FOREIGN KEY (country_group_id) REFERENCES res_country_group(id) ON DELETE SET NULL
 account_fiscal_position_create_uid_fkey                         | account_fiscal_position                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_fiscal_position_write_uid_fkey                          | account_fiscal_position                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_fiscal_position_avatax_refund_account_id_fkey           | account_fiscal_position                                       | FOREIGN KEY (avatax_refund_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 account_fiscal_position_avatax_invoice_account_id_fkey          | account_fiscal_position                                       | FOREIGN KEY (avatax_invoice_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 account_fiscal_position_account_create_uid_fkey                 | account_fiscal_position_account                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_fiscal_position_account_position_id_fkey                | account_fiscal_position_account                               | FOREIGN KEY (position_id) REFERENCES account_fiscal_position(id) ON DELETE CASCADE
 account_fiscal_position_account_account_src_id_fkey             | account_fiscal_position_account                               | FOREIGN KEY (account_src_id) REFERENCES account_account(id) ON DELETE RESTRICT
 account_fiscal_position_account_company_id_fkey                 | account_fiscal_position_account                               | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 account_fiscal_position_account_account_dest_id_fkey            | account_fiscal_position_account                               | FOREIGN KEY (account_dest_id) REFERENCES account_account(id) ON DELETE RESTRICT
 account_fiscal_position_account_write_uid_fkey                  | account_fiscal_position_account                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_fiscal_position_account_pkey                            | account_fiscal_position_account                               | PRIMARY KEY (id)
 account_fiscal_position_account_account_src_dest_uniq           | account_fiscal_position_account                               | UNIQUE (position_id, account_src_id, account_dest_id)
 account_fiscal_position_res_country_state_rel_pkey              | account_fiscal_position_res_country_state_rel                 | PRIMARY KEY (account_fiscal_position_id, res_country_state_id)
 account_fiscal_position_res_country_s_res_country_state_id_fkey | account_fiscal_position_res_country_state_rel                 | FOREIGN KEY (res_country_state_id) REFERENCES res_country_state(id) ON DELETE CASCADE
 account_fiscal_position_res_cou_account_fiscal_position_id_fkey | account_fiscal_position_res_country_state_rel                 | FOREIGN KEY (account_fiscal_position_id) REFERENCES account_fiscal_position(id) ON DELETE CASCADE
 account_fiscal_position_tax_position_id_fkey                    | account_fiscal_position_tax                                   | FOREIGN KEY (position_id) REFERENCES account_fiscal_position(id) ON DELETE CASCADE
 account_fiscal_position_tax_write_uid_fkey                      | account_fiscal_position_tax                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_fiscal_position_tax_tax_src_dest_uniq                   | account_fiscal_position_tax                                   | UNIQUE (position_id, tax_src_id, tax_dest_id)
 account_fiscal_position_tax_create_uid_fkey                     | account_fiscal_position_tax                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_fiscal_position_tax_pkey                                | account_fiscal_position_tax                                   | PRIMARY KEY (id)
 account_fiscal_position_tax_tax_dest_id_fkey                    | account_fiscal_position_tax                                   | FOREIGN KEY (tax_dest_id) REFERENCES account_tax(id) ON DELETE SET NULL
 account_fiscal_position_tax_tax_src_id_fkey                     | account_fiscal_position_tax                                   | FOREIGN KEY (tax_src_id) REFERENCES account_tax(id) ON DELETE RESTRICT
 account_fiscal_position_tax_company_id_fkey                     | account_fiscal_position_tax                                   | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 account_fiscal_year_pkey                                        | account_fiscal_year                                           | PRIMARY KEY (id)
 account_fiscal_year_create_uid_fkey                             | account_fiscal_year                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_fiscal_year_company_id_fkey                             | account_fiscal_year                                           | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 account_fiscal_year_write_uid_fkey                              | account_fiscal_year                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_followup_followup_line_create_uid_fkey                  | account_followup_followup_line                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_followup_followup_line_activity_type_id_fkey            | account_followup_followup_line                                | FOREIGN KEY (activity_type_id) REFERENCES mail_activity_type(id) ON DELETE SET NULL
 account_followup_followup_line_sms_template_id_fkey             | account_followup_followup_line                                | FOREIGN KEY (sms_template_id) REFERENCES sms_template(id) ON DELETE SET NULL
 account_followup_followup_line_mail_template_id_fkey            | account_followup_followup_line                                | FOREIGN KEY (mail_template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 account_followup_followup_line_company_id_fkey                  | account_followup_followup_line                                | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 account_followup_followup_line_pkey                             | account_followup_followup_line                                | PRIMARY KEY (id)
 account_followup_followup_line_days_uniq                        | account_followup_followup_line                                | UNIQUE (company_id, delay)
 account_followup_followup_line_uniq_name                        | account_followup_followup_line                                | UNIQUE (company_id, name)
 account_followup_followup_line_write_uid_fkey                   | account_followup_followup_line                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_followup_followup_lin_account_followup_followup_li_fkey | account_followup_followup_line_res_users_rel                  | FOREIGN KEY (account_followup_followup_line_id) REFERENCES account_followup_followup_line(id) ON DELETE CASCADE
 account_followup_followup_line_res_users_rel_pkey               | account_followup_followup_line_res_users_rel                  | PRIMARY KEY (account_followup_followup_line_id, res_users_id)
 account_followup_followup_line_res_users_rel_res_users_id_fkey  | account_followup_followup_line_res_users_rel                  | FOREIGN KEY (res_users_id) REFERENCES res_users(id) ON DELETE CASCADE
 account_followup_manual_reminder_pkey                           | account_followup_manual_reminder                              | PRIMARY KEY (id)
 account_followup_manual_reminder_write_uid_fkey                 | account_followup_manual_reminder                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_followup_manual_reminder_create_uid_fkey                | account_followup_manual_reminder                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_followup_manual_reminder_sms_template_id_fkey           | account_followup_manual_reminder                              | FOREIGN KEY (sms_template_id) REFERENCES sms_template(id) ON DELETE SET NULL
 account_followup_manual_reminder_partner_id_fkey                | account_followup_manual_reminder                              | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 account_followup_manual_reminder_template_id_fkey               | account_followup_manual_reminder                              | FOREIGN KEY (template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 account_followup_manual_reminder_ir_attachment_rel_pkey         | account_followup_manual_reminder_ir_attachment_rel            | PRIMARY KEY (account_followup_manual_reminder_id, ir_attachment_id)
 account_followup_manual_reminder_ir_attac_ir_attachment_id_fkey | account_followup_manual_reminder_ir_attachment_rel            | FOREIGN KEY (ir_attachment_id) REFERENCES ir_attachment(id) ON DELETE CASCADE
 account_followup_manual_remin_account_followup_manual_remi_fkey | account_followup_manual_reminder_ir_attachment_rel            | FOREIGN KEY (account_followup_manual_reminder_id) REFERENCES account_followup_manual_reminder(id) ON DELETE CASCADE
 account_followup_missing_information_wizard_write_uid_fkey      | account_followup_missing_information_wizard                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_followup_missing_information_wizard_pkey                | account_followup_missing_information_wizard                   | PRIMARY KEY (id)
 account_followup_missing_information_wizard_create_uid_fkey     | account_followup_missing_information_wizard                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_full_reconcile_write_uid_fkey                           | account_full_reconcile                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_full_reconcile_pkey                                     | account_full_reconcile                                        | PRIMARY KEY (id)
 account_full_reconcile_exchange_move_id_fkey                    | account_full_reconcile                                        | FOREIGN KEY (exchange_move_id) REFERENCES account_move(id) ON DELETE SET NULL
 account_full_reconcile_create_uid_fkey                          | account_full_reconcile                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_group_create_uid_fkey                                   | account_group                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_group_check_length_prefix                               | account_group                                                 | CHECK ((char_length((COALESCE(code_prefix_start, ''::character varying))::text) = char_length((COALESCE(code_prefix_end, ''::character varying))::text)))
 account_group_pkey                                              | account_group                                                 | PRIMARY KEY (id)
 account_group_parent_id_fkey                                    | account_group                                                 | FOREIGN KEY (parent_id) REFERENCES account_group(id) ON DELETE CASCADE
 account_group_company_id_fkey                                   | account_group                                                 | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 account_group_write_uid_fkey                                    | account_group                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_import_summary_write_uid_fkey                           | account_import_summary                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_import_summary_create_uid_fkey                          | account_import_summary                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_import_summary_pkey                                     | account_import_summary                                        | PRIMARY KEY (id)
 account_import_summary_account_j_account_import_summary_id_fkey | account_import_summary_account_journal_rel                    | FOREIGN KEY (account_import_summary_id) REFERENCES account_import_summary(id) ON DELETE CASCADE
 account_import_summary_account_journal_rel_pkey                 | account_import_summary_account_journal_rel                    | PRIMARY KEY (account_import_summary_id, account_journal_id)
 account_import_summary_account_journal__account_journal_id_fkey | account_import_summary_account_journal_rel                    | FOREIGN KEY (account_journal_id) REFERENCES account_journal(id) ON DELETE CASCADE
 account_import_summary_account_move_rel_pkey                    | account_import_summary_account_move_rel                       | PRIMARY KEY (account_import_summary_id, account_move_id)
 account_import_summary_account_move_rel_account_move_id_fkey    | account_import_summary_account_move_rel                       | FOREIGN KEY (account_move_id) REFERENCES account_move(id) ON DELETE CASCADE
 account_import_summary_account_m_account_import_summary_id_fkey | account_import_summary_account_move_rel                       | FOREIGN KEY (account_import_summary_id) REFERENCES account_import_summary(id) ON DELETE CASCADE
 account_import_summary_account_tax_rel_account_tax_id_fkey      | account_import_summary_account_tax_rel                        | FOREIGN KEY (account_tax_id) REFERENCES account_tax(id) ON DELETE CASCADE
 account_import_summary_account_tax_rel_pkey                     | account_import_summary_account_tax_rel                        | PRIMARY KEY (account_import_summary_id, account_tax_id)
 account_import_summary_account_t_account_import_summary_id_fkey | account_import_summary_account_tax_rel                        | FOREIGN KEY (account_import_summary_id) REFERENCES account_import_summary(id) ON DELETE CASCADE
 account_import_summary_res_partn_account_import_summary_id_fkey | account_import_summary_res_partner_rel                        | FOREIGN KEY (account_import_summary_id) REFERENCES account_import_summary(id) ON DELETE CASCADE
 account_import_summary_res_partner_rel_res_partner_id_fkey      | account_import_summary_res_partner_rel                        | FOREIGN KEY (res_partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 account_import_summary_res_partner_rel_pkey                     | account_import_summary_res_partner_rel                        | PRIMARY KEY (account_import_summary_id, res_partner_id)
 account_incoterms_write_uid_fkey                                | account_incoterms                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_incoterms_pkey                                          | account_incoterms                                             | PRIMARY KEY (id)
 account_incoterms_create_uid_fkey                               | account_incoterms                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_invoice_extract_words_write_uid_fkey                    | account_invoice_extract_words                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_invoice_extract_words_pkey                              | account_invoice_extract_words                                 | PRIMARY KEY (id)
 account_invoice_extract_words_create_uid_fkey                   | account_invoice_extract_words                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_invoice_extract_words_invoice_id_fkey                   | account_invoice_extract_words                                 | FOREIGN KEY (invoice_id) REFERENCES account_move(id) ON DELETE CASCADE
 account_invoice_transaction_rel_pkey                            | account_invoice_transaction_rel                               | PRIMARY KEY (invoice_id, transaction_id)
 account_invoice_transaction_rel_invoice_id_fkey                 | account_invoice_transaction_rel                               | FOREIGN KEY (invoice_id) REFERENCES account_move(id) ON DELETE CASCADE
 account_invoice_transaction_rel_transaction_id_fkey             | account_invoice_transaction_rel                               | FOREIGN KEY (transaction_id) REFERENCES payment_transaction(id) ON DELETE CASCADE
 account_journal_account_online_link_id_fkey                     | account_journal                                               | FOREIGN KEY (account_online_link_id) REFERENCES account_online_link(id) ON DELETE SET NULL
 account_journal_pkey                                            | account_journal                                               | PRIMARY KEY (id)
 account_journal_write_uid_fkey                                  | account_journal                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_journal_create_uid_fkey                                 | account_journal                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_journal_bank_account_id_fkey                            | account_journal                                               | FOREIGN KEY (bank_account_id) REFERENCES res_partner_bank(id) ON DELETE RESTRICT
 account_journal_loss_account_id_fkey                            | account_journal                                               | FOREIGN KEY (loss_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 account_journal_currency_id_fkey                                | account_journal                                               | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 account_journal_suspense_account_id_fkey                        | account_journal                                               | FOREIGN KEY (suspense_account_id) REFERENCES account_account(id) ON DELETE RESTRICT
 account_journal_default_account_id_fkey                         | account_journal                                               | FOREIGN KEY (default_account_id) REFERENCES account_account(id) ON DELETE RESTRICT
 account_journal_alias_id_fkey                                   | account_journal                                               | FOREIGN KEY (alias_id) REFERENCES mail_alias(id) ON DELETE RESTRICT
 account_journal_code_company_uniq                               | account_journal                                               | UNIQUE (company_id, code)
 account_journal_account_online_account_id_fkey                  | account_journal                                               | FOREIGN KEY (account_online_account_id) REFERENCES account_online_account(id) ON DELETE SET NULL
 account_journal_profit_account_id_fkey                          | account_journal                                               | FOREIGN KEY (profit_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 account_journal_company_id_fkey                                 | account_journal                                               | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 account_journal_account_journal_g_account_journal_group_id_fkey | account_journal_account_journal_group_rel                     | FOREIGN KEY (account_journal_group_id) REFERENCES account_journal_group(id) ON DELETE CASCADE
 account_journal_account_journal_group_rel_pkey                  | account_journal_account_journal_group_rel                     | PRIMARY KEY (account_journal_group_id, account_journal_id)
 account_journal_account_journal_group_r_account_journal_id_fkey | account_journal_account_journal_group_rel                     | FOREIGN KEY (account_journal_id) REFERENCES account_journal(id) ON DELETE CASCADE
 account_journal_account_reconcile_model_rel_pkey                | account_journal_account_reconcile_model_rel                   | PRIMARY KEY (account_reconcile_model_id, account_journal_id)
 account_journal_account_reconci_account_reconcile_model_id_fkey | account_journal_account_reconcile_model_rel                   | FOREIGN KEY (account_reconcile_model_id) REFERENCES account_reconcile_model(id) ON DELETE CASCADE
 account_journal_account_reconcile_model_account_journal_id_fkey | account_journal_account_reconcile_model_rel                   | FOREIGN KEY (account_journal_id) REFERENCES account_journal(id) ON DELETE CASCADE
 account_journal_group_uniq_name                                 | account_journal_group                                         | UNIQUE (company_id, name)
 account_journal_group_write_uid_fkey                            | account_journal_group                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_journal_group_create_uid_fkey                           | account_journal_group                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_journal_group_company_id_fkey                           | account_journal_group                                         | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 account_journal_group_pkey                                      | account_journal_group                                         | PRIMARY KEY (id)
 account_loan_pkey                                               | account_loan                                                  | PRIMARY KEY (id)
 account_loan_journal_id_fkey                                    | account_loan                                                  | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 account_loan_expense_account_id_fkey                            | account_loan                                                  | FOREIGN KEY (expense_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 account_loan_asset_group_id_fkey                                | account_loan                                                  | FOREIGN KEY (asset_group_id) REFERENCES account_asset_group(id) ON DELETE SET NULL
 account_loan_short_term_account_id_fkey                         | account_loan                                                  | FOREIGN KEY (short_term_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 account_loan_create_uid_fkey                                    | account_loan                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_loan_write_uid_fkey                                     | account_loan                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_loan_company_id_fkey                                    | account_loan                                                  | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 account_loan_long_term_account_id_fkey                          | account_loan                                                  | FOREIGN KEY (long_term_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 account_loan_close_wizard_loan_id_fkey                          | account_loan_close_wizard                                     | FOREIGN KEY (loan_id) REFERENCES account_loan(id) ON DELETE CASCADE
 account_loan_close_wizard_pkey                                  | account_loan_close_wizard                                     | PRIMARY KEY (id)
 account_loan_close_wizard_write_uid_fkey                        | account_loan_close_wizard                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_loan_close_wizard_create_uid_fkey                       | account_loan_close_wizard                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_loan_compute_wizard_create_uid_fkey                     | account_loan_compute_wizard                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_loan_compute_wizard_write_uid_fkey                      | account_loan_compute_wizard                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_loan_compute_wizard_loan_id_fkey                        | account_loan_compute_wizard                                   | FOREIGN KEY (loan_id) REFERENCES account_loan(id) ON DELETE CASCADE
 account_loan_compute_wizard_pkey                                | account_loan_compute_wizard                                   | PRIMARY KEY (id)
 account_loan_line_create_uid_fkey                               | account_loan_line                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_loan_line_loan_id_fkey                                  | account_loan_line                                             | FOREIGN KEY (loan_id) REFERENCES account_loan(id) ON DELETE CASCADE
 account_loan_line_pkey                                          | account_loan_line                                             | PRIMARY KEY (id)
 account_loan_line_write_uid_fkey                                | account_loan_line                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_lock_exception_company_id_fkey                          | account_lock_exception                                        | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 account_lock_exception_pkey                                     | account_lock_exception                                        | PRIMARY KEY (id)
 account_lock_exception_user_id_fkey                             | account_lock_exception                                        | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 account_lock_exception_create_uid_fkey                          | account_lock_exception                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_lock_exception_write_uid_fkey                           | account_lock_exception                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_merge_wizard_write_uid_fkey                             | account_merge_wizard                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_merge_wizard_pkey                                       | account_merge_wizard                                          | PRIMARY KEY (id)
 account_merge_wizard_create_uid_fkey                            | account_merge_wizard                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_merge_wizard_line_write_uid_fkey                        | account_merge_wizard_line                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_merge_wizard_line_create_uid_fkey                       | account_merge_wizard_line                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_merge_wizard_line_pkey                                  | account_merge_wizard_line                                     | PRIMARY KEY (id)
 account_merge_wizard_line_wizard_id_fkey                        | account_merge_wizard_line                                     | FOREIGN KEY (wizard_id) REFERENCES account_merge_wizard(id) ON DELETE CASCADE
 account_merge_wizard_line_account_id_fkey                       | account_merge_wizard_line                                     | FOREIGN KEY (account_id) REFERENCES account_account(id) ON DELETE CASCADE
 account_missing_transaction_wizard_write_uid_fkey               | account_missing_transaction_wizard                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_missing_transaction_wizard_pkey                         | account_missing_transaction_wizard                            | PRIMARY KEY (id)
 account_missing_transaction_wizard_create_uid_fkey              | account_missing_transaction_wizard                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_missing_transaction_wizard_journal_id_fkey              | account_missing_transaction_wizard                            | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 account_model_rel_pkey                                          | account_model_rel                                             | PRIMARY KEY (account_transfer_model_id, account_account_id)
 account_model_rel_account_transfer_model_id_fkey                | account_model_rel                                             | FOREIGN KEY (account_transfer_model_id) REFERENCES account_transfer_model(id) ON DELETE CASCADE
 account_model_rel_account_account_id_fkey                       | account_model_rel                                             | FOREIGN KEY (account_account_id) REFERENCES account_account(id) ON DELETE CASCADE
 account_move_auto_post_origin_id_fkey                           | account_move                                                  | FOREIGN KEY (auto_post_origin_id) REFERENCES account_move(id) ON DELETE SET NULL
 account_move_write_uid_fkey                                     | account_move                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_move_create_uid_fkey                                    | account_move                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_move_invoice_cash_rounding_id_fkey                      | account_move                                                  | FOREIGN KEY (invoice_cash_rounding_id) REFERENCES account_cash_rounding(id) ON DELETE SET NULL
 account_move_invoice_incoterm_id_fkey                           | account_move                                                  | FOREIGN KEY (invoice_incoterm_id) REFERENCES account_incoterms(id) ON DELETE SET NULL
 account_move_invoice_user_id_fkey                               | account_move                                                  | FOREIGN KEY (invoice_user_id) REFERENCES res_users(id) ON DELETE SET NULL
 account_move_reversed_entry_id_fkey                             | account_move                                                  | FOREIGN KEY (reversed_entry_id) REFERENCES account_move(id) ON DELETE SET NULL
 account_move_currency_id_fkey                                   | account_move                                                  | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE RESTRICT
 account_move_preferred_payment_method_line_id_fkey              | account_move                                                  | FOREIGN KEY (preferred_payment_method_line_id) REFERENCES account_payment_method_line(id) ON DELETE SET NULL
 account_move_fiscal_position_id_fkey                            | account_move                                                  | FOREIGN KEY (fiscal_position_id) REFERENCES account_fiscal_position(id) ON DELETE RESTRICT
 account_move_partner_bank_id_fkey                               | account_move                                                  | FOREIGN KEY (partner_bank_id) REFERENCES res_partner_bank(id) ON DELETE RESTRICT
 account_move_partner_shipping_id_fkey                           | account_move                                                  | FOREIGN KEY (partner_shipping_id) REFERENCES res_partner(id) ON DELETE SET NULL
 account_move_commercial_partner_id_fkey                         | account_move                                                  | FOREIGN KEY (commercial_partner_id) REFERENCES res_partner(id) ON DELETE RESTRICT
 account_move_partner_id_fkey                                    | account_move                                                  | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE RESTRICT
 account_move_invoice_payment_term_id_fkey                       | account_move                                                  | FOREIGN KEY (invoice_payment_term_id) REFERENCES account_payment_term(id) ON DELETE SET NULL
 account_move_tax_cash_basis_origin_move_id_fkey                 | account_move                                                  | FOREIGN KEY (tax_cash_basis_origin_move_id) REFERENCES account_move(id) ON DELETE SET NULL
 account_move_tax_cash_basis_rec_id_fkey                         | account_move                                                  | FOREIGN KEY (tax_cash_basis_rec_id) REFERENCES account_partial_reconcile(id) ON DELETE SET NULL
 account_move_statement_line_id_fkey                             | account_move                                                  | FOREIGN KEY (statement_line_id) REFERENCES account_bank_statement_line(id) ON DELETE SET NULL
 account_move_tax_closing_report_id_fkey                         | account_move                                                  | FOREIGN KEY (tax_closing_report_id) REFERENCES account_report(id) ON DELETE SET NULL
 account_move_origin_payment_id_fkey                             | account_move                                                  | FOREIGN KEY (origin_payment_id) REFERENCES account_payment(id) ON DELETE SET NULL
 account_move_extract_attachment_id_fkey                         | account_move                                                  | FOREIGN KEY (extract_attachment_id) REFERENCES ir_attachment(id) ON DELETE SET NULL
 account_move_company_id_fkey                                    | account_move                                                  | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 account_move_journal_id_fkey                                    | account_move                                                  | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE RESTRICT
 account_move_message_main_attachment_id_fkey                    | account_move                                                  | FOREIGN KEY (message_main_attachment_id) REFERENCES ir_attachment(id) ON DELETE SET NULL
 account_move_generating_loan_line_id_fkey                       | account_move                                                  | FOREIGN KEY (generating_loan_line_id) REFERENCES account_loan_line(id) ON DELETE CASCADE
 account_move_transfer_model_id_fkey                             | account_move                                                  | FOREIGN KEY (transfer_model_id) REFERENCES account_transfer_model(id) ON DELETE SET NULL
 account_move_stock_move_id_fkey                                 | account_move                                                  | FOREIGN KEY (stock_move_id) REFERENCES stock_move(id) ON DELETE SET NULL
 account_move_campaign_id_fkey                                   | account_move                                                  | FOREIGN KEY (campaign_id) REFERENCES utm_campaign(id) ON DELETE SET NULL
 account_move_source_id_fkey                                     | account_move                                                  | FOREIGN KEY (source_id) REFERENCES utm_source(id) ON DELETE SET NULL
 account_move_medium_id_fkey                                     | account_move                                                  | FOREIGN KEY (medium_id) REFERENCES utm_medium(id) ON DELETE SET NULL
 account_move_team_id_fkey                                       | account_move                                                  | FOREIGN KEY (team_id) REFERENCES crm_team(id) ON DELETE SET NULL
 account_move_signing_user_fkey                                  | account_move                                                  | FOREIGN KEY (signing_user) REFERENCES res_users(id) ON DELETE SET NULL
 account_move_pkey                                               | account_move                                                  | PRIMARY KEY (id)
 account_move_suspense_statement_line_id_fkey                    | account_move                                                  | FOREIGN KEY (suspense_statement_line_id) REFERENCES account_bank_statement_line(id) ON DELETE SET NULL
 account_move_expense_sheet_id_fkey                              | account_move                                                  | FOREIGN KEY (expense_sheet_id) REFERENCES hr_expense_sheet(id) ON DELETE SET NULL
 account_move_asset_id_fkey                                      | account_move                                                  | FOREIGN KEY (asset_id) REFERENCES account_asset(id) ON DELETE CASCADE
 account_move__account_payment_payment_id_fkey                   | account_move__account_payment                                 | FOREIGN KEY (payment_id) REFERENCES account_payment(id) ON DELETE CASCADE
 account_move__account_payment_invoice_id_fkey                   | account_move__account_payment                                 | FOREIGN KEY (invoice_id) REFERENCES account_move(id) ON DELETE CASCADE
 account_move__account_payment_pkey                              | account_move__account_payment                                 | PRIMARY KEY (invoice_id, payment_id)
 account_move_account_move_send_batch_wizar_account_move_id_fkey | account_move_account_move_send_batch_wizard_rel               | FOREIGN KEY (account_move_id) REFERENCES account_move(id) ON DELETE CASCADE
 account_move_account_move_sen_account_move_send_batch_wiza_fkey | account_move_account_move_send_batch_wizard_rel               | FOREIGN KEY (account_move_send_batch_wizard_id) REFERENCES account_move_send_batch_wizard(id) ON DELETE CASCADE
 account_move_account_move_send_batch_wizard_rel_pkey            | account_move_account_move_send_batch_wizard_rel               | PRIMARY KEY (account_move_send_batch_wizard_id, account_move_id)
 account_move_account_resequen_account_resequence_wizard_id_fkey | account_move_account_resequence_wizard_rel                    | FOREIGN KEY (account_resequence_wizard_id) REFERENCES account_resequence_wizard(id) ON DELETE CASCADE
 account_move_account_resequence_wizard_rel_account_move_id_fkey | account_move_account_resequence_wizard_rel                    | FOREIGN KEY (account_move_id) REFERENCES account_move(id) ON DELETE CASCADE
 account_move_account_resequence_wizard_rel_pkey                 | account_move_account_resequence_wizard_rel                    | PRIMARY KEY (account_resequence_wizard_id, account_move_id)
 account_move_asset_modify_rel_pkey                              | account_move_asset_modify_rel                                 | PRIMARY KEY (asset_modify_id, account_move_id)
 account_move_asset_modify_rel_account_move_id_fkey              | account_move_asset_modify_rel                                 | FOREIGN KEY (account_move_id) REFERENCES account_move(id) ON DELETE CASCADE
 account_move_asset_modify_rel_asset_modify_id_fkey              | account_move_asset_modify_rel                                 | FOREIGN KEY (asset_modify_id) REFERENCES asset_modify(id) ON DELETE CASCADE
 account_move_deferred_rel_deferred_move_id_fkey                 | account_move_deferred_rel                                     | FOREIGN KEY (deferred_move_id) REFERENCES account_move(id) ON DELETE CASCADE
 account_move_deferred_rel_original_move_id_fkey                 | account_move_deferred_rel                                     | FOREIGN KEY (original_move_id) REFERENCES account_move(id) ON DELETE CASCADE
 account_move_deferred_rel_pkey                                  | account_move_deferred_rel                                     | PRIMARY KEY (original_move_id, deferred_move_id)
 account_move_line_check_non_accountable_fields_null             | account_move_line                                             | CHECK ((((display_type)::text <> ALL ((ARRAY['line_section'::character varying, 'line_note'::character varying])::text[])) OR ((amount_currency = (0)::numeric) AND (debit = (0)::numeric) AND (credit = (0)::numeric) AND (account_id IS NULL))))
 account_move_line_purchase_line_id_fkey                         | account_move_line                                             | FOREIGN KEY (purchase_line_id) REFERENCES purchase_order_line(id) ON DELETE SET NULL
 account_move_line_write_uid_fkey                                | account_move_line                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_move_line_cogs_origin_id_fkey                           | account_move_line                                             | FOREIGN KEY (cogs_origin_id) REFERENCES account_move_line(id) ON DELETE SET NULL
 account_move_line_check_accountable_required_fields             | account_move_line                                             | CHECK ((((display_type)::text = ANY ((ARRAY['line_section'::character varying, 'line_note'::character varying])::text[])) OR (account_id IS NOT NULL)))
 account_move_line_check_amount_currency_balance_sign            | account_move_line                                             | CHECK ((((display_type)::text = ANY ((ARRAY['line_section'::character varying, 'line_note'::character varying])::text[])) OR (((balance <= (0)::numeric) AND (amount_currency <= (0)::numeric)) OR ((balance >= (0)::numeric) AND (amount_currency >= (0)::numeric)))))
 account_move_line_create_uid_fkey                               | account_move_line                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_move_line_check_credit_debit                            | account_move_line                                             | CHECK ((((display_type)::text = ANY ((ARRAY['line_section'::character varying, 'line_note'::character varying])::text[])) OR ((credit * debit) = (0)::numeric)))
 account_move_line_product_uom_id_fkey                           | account_move_line                                             | FOREIGN KEY (product_uom_id) REFERENCES uom_uom(id) ON DELETE RESTRICT
 account_move_line_product_id_fkey                               | account_move_line                                             | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE RESTRICT
 account_move_line_pkey                                          | account_move_line                                             | PRIMARY KEY (id)
 account_move_line_full_reconcile_id_fkey                        | account_move_line                                             | FOREIGN KEY (full_reconcile_id) REFERENCES account_full_reconcile(id) ON DELETE SET NULL
 account_move_line_tax_repartition_line_id_fkey                  | account_move_line                                             | FOREIGN KEY (tax_repartition_line_id) REFERENCES account_tax_repartition_line(id) ON DELETE RESTRICT
 account_move_line_tax_group_id_fkey                             | account_move_line                                             | FOREIGN KEY (tax_group_id) REFERENCES account_tax_group(id) ON DELETE SET NULL
 account_move_line_tax_line_id_fkey                              | account_move_line                                             | FOREIGN KEY (tax_line_id) REFERENCES account_tax(id) ON DELETE RESTRICT
 account_move_line_group_tax_id_fkey                             | account_move_line                                             | FOREIGN KEY (group_tax_id) REFERENCES account_tax(id) ON DELETE SET NULL
 account_move_line_statement_id_fkey                             | account_move_line                                             | FOREIGN KEY (statement_id) REFERENCES account_bank_statement(id) ON DELETE SET NULL
 account_move_line_statement_line_id_fkey                        | account_move_line                                             | FOREIGN KEY (statement_line_id) REFERENCES account_bank_statement_line(id) ON DELETE SET NULL
 account_move_line_payment_id_fkey                               | account_move_line                                             | FOREIGN KEY (payment_id) REFERENCES account_payment(id) ON DELETE SET NULL
 account_move_line_expense_id_fkey                               | account_move_line                                             | FOREIGN KEY (expense_id) REFERENCES hr_expense(id) ON DELETE SET NULL
 account_move_line_reconcile_model_id_fkey                       | account_move_line                                             | FOREIGN KEY (reconcile_model_id) REFERENCES account_reconcile_model(id) ON DELETE SET NULL
 account_move_line_vehicle_id_fkey                               | account_move_line                                             | FOREIGN KEY (vehicle_id) REFERENCES fleet_vehicle(id) ON DELETE SET NULL
 account_move_line_partner_id_fkey                               | account_move_line                                             | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE RESTRICT
 account_move_line_followup_line_id_fkey                         | account_move_line                                             | FOREIGN KEY (followup_line_id) REFERENCES account_followup_followup_line(id) ON DELETE SET NULL
 account_move_line_currency_id_fkey                              | account_move_line                                             | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE RESTRICT
 account_move_line_account_id_fkey                               | account_move_line                                             | FOREIGN KEY (account_id) REFERENCES account_account(id) ON DELETE CASCADE
 account_move_line_company_currency_id_fkey                      | account_move_line                                             | FOREIGN KEY (company_currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 account_move_line_company_id_fkey                               | account_move_line                                             | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 account_move_line_journal_id_fkey                               | account_move_line                                             | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 account_move_line_move_id_fkey                                  | account_move_line                                             | FOREIGN KEY (move_id) REFERENCES account_move(id) ON DELETE CASCADE
 account_move_line_account_reconcile_wizard_rel_pkey             | account_move_line_account_reconcile_wizard_rel                | PRIMARY KEY (account_reconcile_wizard_id, account_move_line_id)
 account_move_line_account_reconcile_w_account_move_line_id_fkey | account_move_line_account_reconcile_wizard_rel                | FOREIGN KEY (account_move_line_id) REFERENCES account_move_line(id) ON DELETE CASCADE
 account_move_line_account_reco_account_reconcile_wizard_id_fkey | account_move_line_account_reconcile_wizard_rel                | FOREIGN KEY (account_reconcile_wizard_id) REFERENCES account_reconcile_wizard(id) ON DELETE CASCADE
 account_move_line_account_tax_rel_account_tax_id_fkey           | account_move_line_account_tax_rel                             | FOREIGN KEY (account_tax_id) REFERENCES account_tax(id) ON DELETE CASCADE
 account_move_line_account_tax_rel_pkey                          | account_move_line_account_tax_rel                             | PRIMARY KEY (account_move_line_id, account_tax_id)
 account_move_line_account_tax_rel_account_move_line_id_fkey     | account_move_line_account_tax_rel                             | FOREIGN KEY (account_move_line_id) REFERENCES account_move_line(id) ON DELETE CASCADE
 account_move_line_asset_modify_rel_account_move_line_id_fkey    | account_move_line_asset_modify_rel                            | FOREIGN KEY (account_move_line_id) REFERENCES account_move_line(id) ON DELETE CASCADE
 account_move_line_asset_modify_rel_pkey                         | account_move_line_asset_modify_rel                            | PRIMARY KEY (asset_modify_id, account_move_line_id)
 account_move_line_asset_modify_rel_asset_modify_id_fkey         | account_move_line_asset_modify_rel                            | FOREIGN KEY (asset_modify_id) REFERENCES asset_modify(id) ON DELETE CASCADE
 account_move_mrp_production_rel_mrp_production_id_fkey          | account_move_mrp_production_rel                               | FOREIGN KEY (mrp_production_id) REFERENCES mrp_production(id) ON DELETE CASCADE
 account_move_mrp_production_rel_account_move_id_fkey            | account_move_mrp_production_rel                               | FOREIGN KEY (account_move_id) REFERENCES account_move(id) ON DELETE CASCADE
 account_move_mrp_production_rel_pkey                            | account_move_mrp_production_rel                               | PRIMARY KEY (account_move_id, mrp_production_id)
 account_move_purchase_order_rel_pkey                            | account_move_purchase_order_rel                               | PRIMARY KEY (purchase_order_id, account_move_id)
 account_move_purchase_order_rel_purchase_order_id_fkey          | account_move_purchase_order_rel                               | FOREIGN KEY (purchase_order_id) REFERENCES purchase_order(id) ON DELETE CASCADE
 account_move_purchase_order_rel_account_move_id_fkey            | account_move_purchase_order_rel                               | FOREIGN KEY (account_move_id) REFERENCES account_move(id) ON DELETE CASCADE
 account_move_reversal_journal_id_fkey                           | account_move_reversal                                         | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE CASCADE
 account_move_reversal_company_id_fkey                           | account_move_reversal                                         | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE CASCADE
 account_move_reversal_write_uid_fkey                            | account_move_reversal                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_move_reversal_create_uid_fkey                           | account_move_reversal                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_move_reversal_pkey                                      | account_move_reversal                                         | PRIMARY KEY (id)
 account_move_reversal_move_reversal_id_fkey                     | account_move_reversal_move                                    | FOREIGN KEY (reversal_id) REFERENCES account_move_reversal(id) ON DELETE CASCADE
 account_move_reversal_move_move_id_fkey                         | account_move_reversal_move                                    | FOREIGN KEY (move_id) REFERENCES account_move(id) ON DELETE CASCADE
 account_move_reversal_move_pkey                                 | account_move_reversal_move                                    | PRIMARY KEY (reversal_id, move_id)
 account_move_reversal_new_move_reversal_id_fkey                 | account_move_reversal_new_move                                | FOREIGN KEY (reversal_id) REFERENCES account_move_reversal(id) ON DELETE CASCADE
 account_move_reversal_new_move_new_move_id_fkey                 | account_move_reversal_new_move                                | FOREIGN KEY (new_move_id) REFERENCES account_move(id) ON DELETE CASCADE
 account_move_reversal_new_move_pkey                             | account_move_reversal_new_move                                | PRIMARY KEY (reversal_id, new_move_id)
 account_move_send_batch_wizard_create_uid_fkey                  | account_move_send_batch_wizard                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_move_send_batch_wizard_write_uid_fkey                   | account_move_send_batch_wizard                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_move_send_batch_wizard_pkey                             | account_move_send_batch_wizard                                | PRIMARY KEY (id)
 account_move_send_wizard_pkey                                   | account_move_send_wizard                                      | PRIMARY KEY (id)
 account_move_send_wizard_move_id_fkey                           | account_move_send_wizard                                      | FOREIGN KEY (move_id) REFERENCES account_move(id) ON DELETE CASCADE
 account_move_send_wizard_write_uid_fkey                         | account_move_send_wizard                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_move_send_wizard_pdf_report_id_fkey                     | account_move_send_wizard                                      | FOREIGN KEY (pdf_report_id) REFERENCES ir_act_report_xml(id) ON DELETE SET NULL
 account_move_send_wizard_mail_template_id_fkey                  | account_move_send_wizard                                      | FOREIGN KEY (mail_template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 account_move_send_wizard_create_uid_fkey                        | account_move_send_wizard                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_move_send_wizard_res_p_account_move_send_wizard_id_fkey | account_move_send_wizard_res_partner_rel                      | FOREIGN KEY (account_move_send_wizard_id) REFERENCES account_move_send_wizard(id) ON DELETE CASCADE
 account_move_send_wizard_res_partner_rel_res_partner_id_fkey    | account_move_send_wizard_res_partner_rel                      | FOREIGN KEY (res_partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 account_move_send_wizard_res_partner_rel_pkey                   | account_move_send_wizard_res_partner_rel                      | PRIMARY KEY (account_move_send_wizard_id, res_partner_id)
 account_move_validate_account_move_rel_pkey                     | account_move_validate_account_move_rel                        | PRIMARY KEY (validate_account_move_id, account_move_id)
 account_move_validate_account_mov_validate_account_move_id_fkey | account_move_validate_account_move_rel                        | FOREIGN KEY (validate_account_move_id) REFERENCES validate_account_move(id) ON DELETE CASCADE
 account_move_validate_account_move_rel_account_move_id_fkey     | account_move_validate_account_move_rel                        | FOREIGN KEY (account_move_id) REFERENCES account_move(id) ON DELETE CASCADE
 account_multicurrency_revaluation_wizard_create_uid_fkey        | account_multicurrency_revaluation_wizard                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_multicurrency_revaluation_wizard_write_uid_fkey         | account_multicurrency_revaluation_wizard                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_multicurrency_revaluation_wizard_company_id_fkey        | account_multicurrency_revaluation_wizard                      | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 account_multicurrency_revaluation_wizard_pkey                   | account_multicurrency_revaluation_wizard                      | PRIMARY KEY (id)
 account_online_account_pkey                                     | account_online_account                                        | PRIMARY KEY (id)
 account_online_account_currency_id_fkey                         | account_online_account                                        | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 account_online_account_create_uid_fkey                          | account_online_account                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_online_account_account_online_link_id_fkey              | account_online_account                                        | FOREIGN KEY (account_online_link_id) REFERENCES account_online_link(id) ON DELETE CASCADE
 account_online_account_write_uid_fkey                           | account_online_account                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_online_link_write_uid_fkey                              | account_online_link                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_online_link_pkey                                        | account_online_link                                           | PRIMARY KEY (id)
 account_online_link_company_id_fkey                             | account_online_link                                           | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 account_online_link_create_uid_fkey                             | account_online_link                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_partial_reconcile_write_uid_fkey                        | account_partial_reconcile                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_partial_reconcile_create_uid_fkey                       | account_partial_reconcile                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_partial_reconcile_pkey                                  | account_partial_reconcile                                     | PRIMARY KEY (id)
 account_partial_reconcile_debit_move_id_fkey                    | account_partial_reconcile                                     | FOREIGN KEY (debit_move_id) REFERENCES account_move_line(id) ON DELETE RESTRICT
 account_partial_reconcile_credit_move_id_fkey                   | account_partial_reconcile                                     | FOREIGN KEY (credit_move_id) REFERENCES account_move_line(id) ON DELETE RESTRICT
 account_partial_reconcile_full_reconcile_id_fkey                | account_partial_reconcile                                     | FOREIGN KEY (full_reconcile_id) REFERENCES account_full_reconcile(id) ON DELETE SET NULL
 account_partial_reconcile_exchange_move_id_fkey                 | account_partial_reconcile                                     | FOREIGN KEY (exchange_move_id) REFERENCES account_move(id) ON DELETE SET NULL
 account_partial_reconcile_debit_currency_id_fkey                | account_partial_reconcile                                     | FOREIGN KEY (debit_currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 account_partial_reconcile_credit_currency_id_fkey               | account_partial_reconcile                                     | FOREIGN KEY (credit_currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 account_partial_reconcile_company_id_fkey                       | account_partial_reconcile                                     | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 account_payment_create_uid_fkey                                 | account_payment                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_payment_write_uid_fkey                                  | account_payment                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_payment_destination_account_id_fkey                     | account_payment                                               | FOREIGN KEY (destination_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 account_payment_outstanding_account_id_fkey                     | account_payment                                               | FOREIGN KEY (outstanding_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 account_payment_partner_id_fkey                                 | account_payment                                               | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE RESTRICT
 account_payment_currency_id_fkey                                | account_payment                                               | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 account_payment_payment_method_id_fkey                          | account_payment                                               | FOREIGN KEY (payment_method_id) REFERENCES account_payment_method(id) ON DELETE SET NULL
 account_payment_payment_method_line_id_fkey                     | account_payment                                               | FOREIGN KEY (payment_method_line_id) REFERENCES account_payment_method_line(id) ON DELETE SET NULL
 account_payment_paired_internal_transfer_payment_id_fkey        | account_payment                                               | FOREIGN KEY (paired_internal_transfer_payment_id) REFERENCES account_payment(id) ON DELETE SET NULL
 account_payment_partner_bank_id_fkey                            | account_payment                                               | FOREIGN KEY (partner_bank_id) REFERENCES res_partner_bank(id) ON DELETE RESTRICT
 account_payment_company_id_fkey                                 | account_payment                                               | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 account_payment_pkey                                            | account_payment                                               | PRIMARY KEY (id)
 account_payment_check_amount_not_negative                       | account_payment                                               | CHECK ((amount >= 0.0))
 account_payment_journal_id_fkey                                 | account_payment                                               | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE RESTRICT
 account_payment_move_id_fkey                                    | account_payment                                               | FOREIGN KEY (move_id) REFERENCES account_move(id) ON DELETE SET NULL
 account_payment_message_main_attachment_id_fkey                 | account_payment                                               | FOREIGN KEY (message_main_attachment_id) REFERENCES ir_attachment(id) ON DELETE SET NULL
 account_payment_source_payment_id_fkey                          | account_payment                                               | FOREIGN KEY (source_payment_id) REFERENCES account_payment(id) ON DELETE SET NULL
 account_payment_payment_token_id_fkey                           | account_payment                                               | FOREIGN KEY (payment_token_id) REFERENCES payment_token(id) ON DELETE SET NULL
 account_payment_payment_transaction_id_fkey                     | account_payment                                               | FOREIGN KEY (payment_transaction_id) REFERENCES payment_transaction(id) ON DELETE SET NULL
 account_payment_account_bank__account_bank_statement_line__fkey | account_payment_account_bank_statement_line_rel               | FOREIGN KEY (account_bank_statement_line_id) REFERENCES account_bank_statement_line(id) ON DELETE CASCADE
 account_payment_account_bank_statement_line_rel_pkey            | account_payment_account_bank_statement_line_rel               | PRIMARY KEY (account_bank_statement_line_id, account_payment_id)
 account_payment_account_bank_statement__account_payment_id_fkey | account_payment_account_bank_statement_line_rel               | FOREIGN KEY (account_payment_id) REFERENCES account_payment(id) ON DELETE CASCADE
 account_payment_method_create_uid_fkey                          | account_payment_method                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_payment_method_pkey                                     | account_payment_method                                        | PRIMARY KEY (id)
 account_payment_method_name_code_unique                         | account_payment_method                                        | UNIQUE (code, payment_type)
 account_payment_method_write_uid_fkey                           | account_payment_method                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_payment_method_line_payment_account_id_fkey             | account_payment_method_line                                   | FOREIGN KEY (payment_account_id) REFERENCES account_account(id) ON DELETE RESTRICT
 account_payment_method_line_payment_method_id_fkey              | account_payment_method_line                                   | FOREIGN KEY (payment_method_id) REFERENCES account_payment_method(id) ON DELETE RESTRICT
 account_payment_method_line_payment_provider_id_fkey            | account_payment_method_line                                   | FOREIGN KEY (payment_provider_id) REFERENCES payment_provider(id) ON DELETE SET NULL
 account_payment_method_line_write_uid_fkey                      | account_payment_method_line                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_payment_method_line_create_uid_fkey                     | account_payment_method_line                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_payment_method_line_pkey                                | account_payment_method_line                                   | PRIMARY KEY (id)
 account_payment_method_line_journal_id_fkey                     | account_payment_method_line                                   | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 account_payment_method_line_res_company_rel_res_company_id_fkey | account_payment_method_line_res_company_rel                   | FOREIGN KEY (res_company_id) REFERENCES res_company(id) ON DELETE CASCADE
 account_payment_method_line_res_company_rel_pkey                | account_payment_method_line_res_company_rel                   | PRIMARY KEY (res_company_id, account_payment_method_line_id)
 account_payment_method_line_r_account_payment_method_line__fkey | account_payment_method_line_res_company_rel                   | FOREIGN KEY (account_payment_method_line_id) REFERENCES account_payment_method_line(id) ON DELETE CASCADE
 account_payment_register_write_uid_fkey                         | account_payment_register                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_payment_register_currency_id_fkey                       | account_payment_register                                      | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 account_payment_register_journal_id_fkey                        | account_payment_register                                      | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 account_payment_register_partner_bank_id_fkey                   | account_payment_register                                      | FOREIGN KEY (partner_bank_id) REFERENCES res_partner_bank(id) ON DELETE SET NULL
 account_payment_register_custom_user_currency_id_fkey           | account_payment_register                                      | FOREIGN KEY (custom_user_currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 account_payment_register_create_uid_fkey                        | account_payment_register                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_payment_register_writeoff_account_id_fkey               | account_payment_register                                      | FOREIGN KEY (writeoff_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 account_payment_register_payment_method_line_id_fkey            | account_payment_register                                      | FOREIGN KEY (payment_method_line_id) REFERENCES account_payment_method_line(id) ON DELETE SET NULL
 account_payment_register_payment_token_id_fkey                  | account_payment_register                                      | FOREIGN KEY (payment_token_id) REFERENCES payment_token(id) ON DELETE SET NULL
 account_payment_register_pkey                                   | account_payment_register                                      | PRIMARY KEY (id)
 account_payment_register_partner_id_fkey                        | account_payment_register                                      | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE RESTRICT
 account_payment_register_source_currency_id_fkey                | account_payment_register                                      | FOREIGN KEY (source_currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 account_payment_register_company_id_fkey                        | account_payment_register                                      | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 account_payment_register_move_line_rel_line_id_fkey             | account_payment_register_move_line_rel                        | FOREIGN KEY (line_id) REFERENCES account_move_line(id) ON DELETE CASCADE
 account_payment_register_move_line_rel_pkey                     | account_payment_register_move_line_rel                        | PRIMARY KEY (wizard_id, line_id)
 account_payment_register_move_line_rel_wizard_id_fkey           | account_payment_register_move_line_rel                        | FOREIGN KEY (wizard_id) REFERENCES account_payment_register(id) ON DELETE CASCADE
 account_payment_term_create_uid_fkey                            | account_payment_term                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_payment_term_pkey                                       | account_payment_term                                          | PRIMARY KEY (id)
 account_payment_term_company_id_fkey                            | account_payment_term                                          | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 account_payment_term_write_uid_fkey                             | account_payment_term                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_payment_term_line_create_uid_fkey                       | account_payment_term_line                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_payment_term_line_pkey                                  | account_payment_term_line                                     | PRIMARY KEY (id)
 account_payment_term_line_payment_id_fkey                       | account_payment_term_line                                     | FOREIGN KEY (payment_id) REFERENCES account_payment_term(id) ON DELETE CASCADE
 account_payment_term_line_write_uid_fkey                        | account_payment_term_line                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_reconcile_model_write_uid_fkey                          | account_reconcile_model                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_reconcile_model_company_id_fkey                         | account_reconcile_model                                       | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 account_reconcile_model_name_unique                             | account_reconcile_model                                       | UNIQUE (name, company_id)
 account_reconcile_model_pkey                                    | account_reconcile_model                                       | PRIMARY KEY (id)
 account_reconcile_model_create_uid_fkey                         | account_reconcile_model                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_reconcile_model_line_write_uid_fkey                     | account_reconcile_model_line                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_reconcile_model_line_company_id_fkey                    | account_reconcile_model_line                                  | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 account_reconcile_model_line_pkey                               | account_reconcile_model_line                                  | PRIMARY KEY (id)
 account_reconcile_model_line_model_id_fkey                      | account_reconcile_model_line                                  | FOREIGN KEY (model_id) REFERENCES account_reconcile_model(id) ON DELETE CASCADE
 account_reconcile_model_line_account_id_fkey                    | account_reconcile_model_line                                  | FOREIGN KEY (account_id) REFERENCES account_account(id) ON DELETE CASCADE
 account_reconcile_model_line_journal_id_fkey                    | account_reconcile_model_line                                  | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE CASCADE
 account_reconcile_model_line_create_uid_fkey                    | account_reconcile_model_line                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_reconcile_model_line__account_reconcile_model_line_fkey | account_reconcile_model_line_account_tax_rel                  | FOREIGN KEY (account_reconcile_model_line_id) REFERENCES account_reconcile_model_line(id) ON DELETE CASCADE
 account_reconcile_model_line_account_tax_rel_pkey               | account_reconcile_model_line_account_tax_rel                  | PRIMARY KEY (account_reconcile_model_line_id, account_tax_id)
 account_reconcile_model_line_account_tax_re_account_tax_id_fkey | account_reconcile_model_line_account_tax_rel                  | FOREIGN KEY (account_tax_id) REFERENCES account_tax(id) ON DELETE RESTRICT
 account_reconcile_model_partner_mapping_create_uid_fkey         | account_reconcile_model_partner_mapping                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_reconcile_model_partner_mapping_write_uid_fkey          | account_reconcile_model_partner_mapping                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_reconcile_model_partner_mapping_partner_id_fkey         | account_reconcile_model_partner_mapping                       | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 account_reconcile_model_partner_mapping_pkey                    | account_reconcile_model_partner_mapping                       | PRIMARY KEY (id)
 account_reconcile_model_partner_mapping_model_id_fkey           | account_reconcile_model_partner_mapping                       | FOREIGN KEY (model_id) REFERENCES account_reconcile_model(id) ON DELETE CASCADE
 account_reconcile_model_res_pa_account_reconcile_model_id_fkey1 | account_reconcile_model_res_partner_category_rel              | FOREIGN KEY (account_reconcile_model_id) REFERENCES account_reconcile_model(id) ON DELETE CASCADE
 account_reconcile_model_res_partner_category_rel_pkey           | account_reconcile_model_res_partner_category_rel              | PRIMARY KEY (account_reconcile_model_id, res_partner_category_id)
 account_reconcile_model_res_partne_res_partner_category_id_fkey | account_reconcile_model_res_partner_category_rel              | FOREIGN KEY (res_partner_category_id) REFERENCES res_partner_category(id) ON DELETE CASCADE
 account_reconcile_model_res_partner_rel_pkey                    | account_reconcile_model_res_partner_rel                       | PRIMARY KEY (account_reconcile_model_id, res_partner_id)
 account_reconcile_model_res_par_account_reconcile_model_id_fkey | account_reconcile_model_res_partner_rel                       | FOREIGN KEY (account_reconcile_model_id) REFERENCES account_reconcile_model(id) ON DELETE CASCADE
 account_reconcile_model_res_partner_rel_res_partner_id_fkey     | account_reconcile_model_res_partner_rel                       | FOREIGN KEY (res_partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 account_reconcile_wizard_create_uid_fkey                        | account_reconcile_wizard                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_reconcile_wizard_tax_id_fkey                            | account_reconcile_wizard                                      | FOREIGN KEY (tax_id) REFERENCES account_tax(id) ON DELETE SET NULL
 account_reconcile_wizard_to_partner_id_fkey                     | account_reconcile_wizard                                      | FOREIGN KEY (to_partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 account_reconcile_wizard_account_id_fkey                        | account_reconcile_wizard                                      | FOREIGN KEY (account_id) REFERENCES account_account(id) ON DELETE SET NULL
 account_reconcile_wizard_journal_id_fkey                        | account_reconcile_wizard                                      | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE CASCADE
 account_reconcile_wizard_pkey                                   | account_reconcile_wizard                                      | PRIMARY KEY (id)
 account_reconcile_wizard_write_uid_fkey                         | account_reconcile_wizard                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_write_uid_fkey                                   | account_report                                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_root_report_id_fkey                              | account_report                                                | FOREIGN KEY (root_report_id) REFERENCES account_report(id) ON DELETE SET NULL
 account_report_pkey                                             | account_report                                                | PRIMARY KEY (id)
 account_report_create_uid_fkey                                  | account_report                                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_country_id_fkey                                  | account_report                                                | FOREIGN KEY (country_id) REFERENCES res_country(id) ON DELETE SET NULL
 account_report_custom_handler_model_id_fkey                     | account_report                                                | FOREIGN KEY (custom_handler_model_id) REFERENCES ir_model(id) ON DELETE SET NULL
 account_report_account_report_horizontal_group_rel_pkey         | account_report_account_report_horizontal_group_rel            | PRIMARY KEY (account_report_id, account_report_horizontal_group_id)
 account_report_account_report_horizontal_account_report_id_fkey | account_report_account_report_horizontal_group_rel            | FOREIGN KEY (account_report_id) REFERENCES account_report(id) ON DELETE CASCADE
 account_report_account_report_account_report_horizontal_gr_fkey | account_report_account_report_horizontal_group_rel            | FOREIGN KEY (account_report_horizontal_group_id) REFERENCES account_report_horizontal_group(id) ON DELETE CASCADE
 account_report_annotation_report_id_fkey                        | account_report_annotation                                     | FOREIGN KEY (report_id) REFERENCES account_report(id) ON DELETE SET NULL
 account_report_annotation_write_uid_fkey                        | account_report_annotation                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_annotation_create_uid_fkey                       | account_report_annotation                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_annotation_fiscal_position_id_fkey               | account_report_annotation                                     | FOREIGN KEY (fiscal_position_id) REFERENCES account_fiscal_position(id) ON DELETE SET NULL
 account_report_annotation_pkey                                  | account_report_annotation                                     | PRIMARY KEY (id)
 account_report_budget_pkey                                      | account_report_budget                                         | PRIMARY KEY (id)
 account_report_budget_create_uid_fkey                           | account_report_budget                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_budget_company_id_fkey                           | account_report_budget                                         | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 account_report_budget_write_uid_fkey                            | account_report_budget                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_budget_item_budget_id_fkey                       | account_report_budget_item                                    | FOREIGN KEY (budget_id) REFERENCES account_report_budget(id) ON DELETE CASCADE
 account_report_budget_item_create_uid_fkey                      | account_report_budget_item                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_budget_item_account_id_fkey                      | account_report_budget_item                                    | FOREIGN KEY (account_id) REFERENCES account_account(id) ON DELETE RESTRICT
 account_report_budget_item_write_uid_fkey                       | account_report_budget_item                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_budget_item_pkey                                 | account_report_budget_item                                    | PRIMARY KEY (id)
 account_report_column_pkey                                      | account_report_column                                         | PRIMARY KEY (id)
 account_report_column_report_id_fkey                            | account_report_column                                         | FOREIGN KEY (report_id) REFERENCES account_report(id) ON DELETE SET NULL
 account_report_column_custom_audit_action_id_fkey               | account_report_column                                         | FOREIGN KEY (custom_audit_action_id) REFERENCES ir_act_window(id) ON DELETE SET NULL
 account_report_column_create_uid_fkey                           | account_report_column                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_column_write_uid_fkey                            | account_report_column                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_expression_report_line_id_fkey                   | account_report_expression                                     | FOREIGN KEY (report_line_id) REFERENCES account_report_line(id) ON DELETE CASCADE
 account_report_expression_create_uid_fkey                       | account_report_expression                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_expression_write_uid_fkey                        | account_report_expression                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_expression_domain_engine_subformula_required     | account_report_expression                                     | CHECK ((((engine)::text <> 'domain'::text) OR (subformula IS NOT NULL)))
 account_report_expression_line_label_uniq                       | account_report_expression                                     | UNIQUE (report_line_id, label)
 account_report_expression_pkey                                  | account_report_expression                                     | PRIMARY KEY (id)
 account_report_external_value_pkey                              | account_report_external_value                                 | PRIMARY KEY (id)
 account_report_external_value_target_report_expression_id_fkey  | account_report_external_value                                 | FOREIGN KEY (target_report_expression_id) REFERENCES account_report_expression(id) ON DELETE CASCADE
 account_report_external_value_company_id_fkey                   | account_report_external_value                                 | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 account_report_external_value_foreign_vat_fiscal_position__fkey | account_report_external_value                                 | FOREIGN KEY (foreign_vat_fiscal_position_id) REFERENCES account_fiscal_position(id) ON DELETE SET NULL
 account_report_external_value_carryover_origin_report_line_fkey | account_report_external_value                                 | FOREIGN KEY (carryover_origin_report_line_id) REFERENCES account_report_line(id) ON DELETE SET NULL
 account_report_external_value_create_uid_fkey                   | account_report_external_value                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_external_value_write_uid_fkey                    | account_report_external_value                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_file_download_error_wizard_create_uid_fkey       | account_report_file_download_error_wizard                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_file_download_error_wizard_pkey                  | account_report_file_download_error_wizard                     | PRIMARY KEY (id)
 account_report_file_download_error_wizard_write_uid_fkey        | account_report_file_download_error_wizard                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_horizontal_group_pkey                            | account_report_horizontal_group                               | PRIMARY KEY (id)
 account_report_horizontal_group_write_uid_fkey                  | account_report_horizontal_group                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_horizontal_group_create_uid_fkey                 | account_report_horizontal_group                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_horizontal_group_name_uniq                       | account_report_horizontal_group                               | UNIQUE (name)
 account_report_horizontal_group_rule_create_uid_fkey            | account_report_horizontal_group_rule                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_horizontal_group_rule_horizontal_group_id_fkey   | account_report_horizontal_group_rule                          | FOREIGN KEY (horizontal_group_id) REFERENCES account_report_horizontal_group(id) ON DELETE RESTRICT
 account_report_horizontal_group_rule_pkey                       | account_report_horizontal_group_rule                          | PRIMARY KEY (id)
 account_report_horizontal_group_rule_write_uid_fkey             | account_report_horizontal_group_rule                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_line_create_uid_fkey                             | account_report_line                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_line_pkey                                        | account_report_line                                           | PRIMARY KEY (id)
 account_report_line_code_uniq                                   | account_report_line                                           | UNIQUE (report_id, code)
 account_report_line_write_uid_fkey                              | account_report_line                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_line_parent_id_fkey                              | account_report_line                                           | FOREIGN KEY (parent_id) REFERENCES account_report_line(id) ON DELETE SET NULL
 account_report_line_report_id_fkey                              | account_report_line                                           | FOREIGN KEY (report_id) REFERENCES account_report(id) ON DELETE CASCADE
 account_report_section_rel_sub_report_id_fkey                   | account_report_section_rel                                    | FOREIGN KEY (sub_report_id) REFERENCES account_report(id) ON DELETE CASCADE
 account_report_section_rel_pkey                                 | account_report_section_rel                                    | PRIMARY KEY (main_report_id, sub_report_id)
 account_report_section_rel_main_report_id_fkey                  | account_report_section_rel                                    | FOREIGN KEY (main_report_id) REFERENCES account_report(id) ON DELETE CASCADE
 account_report_send_write_uid_fkey                              | account_report_send                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_send_pkey                                        | account_report_send                                           | PRIMARY KEY (id)
 account_report_send_account_report_id_fkey                      | account_report_send                                           | FOREIGN KEY (account_report_id) REFERENCES account_report(id) ON DELETE SET NULL
 account_report_send_mail_template_id_fkey                       | account_report_send                                           | FOREIGN KEY (mail_template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 account_report_send_create_uid_fkey                             | account_report_send                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_report_send_res_partner_rel_account_report_send_id_fkey | account_report_send_res_partner_rel                           | FOREIGN KEY (account_report_send_id) REFERENCES account_report_send(id) ON DELETE CASCADE
 account_report_send_res_partner_rel_pkey                        | account_report_send_res_partner_rel                           | PRIMARY KEY (account_report_send_id, res_partner_id)
 account_report_send_res_partner_rel_res_partner_id_fkey         | account_report_send_res_partner_rel                           | FOREIGN KEY (res_partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 account_reports_export_wizard_folder_id_fkey                    | account_reports_export_wizard                                 | FOREIGN KEY (folder_id) REFERENCES documents_document(id) ON DELETE CASCADE
 account_reports_export_wizard_report_id_fkey                    | account_reports_export_wizard                                 | FOREIGN KEY (report_id) REFERENCES account_report(id) ON DELETE CASCADE
 account_reports_export_wizard_write_uid_fkey                    | account_reports_export_wizard                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_reports_export_wizard_create_uid_fkey                   | account_reports_export_wizard                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_reports_export_wizard_pkey                              | account_reports_export_wizard                                 | PRIMARY KEY (id)
 account_reports_export_wizard_format_write_uid_fkey             | account_reports_export_wizard_format                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_reports_export_wizard_format_export_wizard_id_fkey      | account_reports_export_wizard_format                          | FOREIGN KEY (export_wizard_id) REFERENCES account_reports_export_wizard(id) ON DELETE CASCADE
 account_reports_export_wizard_format_create_uid_fkey            | account_reports_export_wizard_format                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_reports_export_wizard_format_pkey                       | account_reports_export_wizard_format                          | PRIMARY KEY (id)
 account_resequence_wizard_create_uid_fkey                       | account_resequence_wizard                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_resequence_wizard_pkey                                  | account_resequence_wizard                                     | PRIMARY KEY (id)
 account_resequence_wizard_write_uid_fkey                        | account_resequence_wizard                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_secure_entries_wizard_company_id_fkey                   | account_secure_entries_wizard                                 | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE CASCADE
 account_secure_entries_wizard_create_uid_fkey                   | account_secure_entries_wizard                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_secure_entries_wizard_write_uid_fkey                    | account_secure_entries_wizard                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_secure_entries_wizard_pkey                              | account_secure_entries_wizard                                 | PRIMARY KEY (id)
 account_setup_bank_manual_config_res_partner_bank_id_fkey       | account_setup_bank_manual_config                              | FOREIGN KEY (res_partner_bank_id) REFERENCES res_partner_bank(id) ON DELETE CASCADE
 account_setup_bank_manual_config_write_uid_fkey                 | account_setup_bank_manual_config                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_setup_bank_manual_config_create_uid_fkey                | account_setup_bank_manual_config                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_setup_bank_manual_config_pkey                           | account_setup_bank_manual_config                              | PRIMARY KEY (id)
 account_tax_company_id_fkey                                     | account_tax                                                   | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 account_tax_pkey                                                | account_tax                                                   | PRIMARY KEY (id)
 account_tax_tax_group_id_fkey                                   | account_tax                                                   | FOREIGN KEY (tax_group_id) REFERENCES account_tax_group(id) ON DELETE RESTRICT
 account_tax_cash_basis_transition_account_id_fkey               | account_tax                                                   | FOREIGN KEY (cash_basis_transition_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 account_tax_country_id_fkey                                     | account_tax                                                   | FOREIGN KEY (country_id) REFERENCES res_country(id) ON DELETE RESTRICT
 account_tax_create_uid_fkey                                     | account_tax                                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_tax_write_uid_fkey                                      | account_tax                                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_tax_filiation_rel_parent_tax_fkey                       | account_tax_filiation_rel                                     | FOREIGN KEY (parent_tax) REFERENCES account_tax(id) ON DELETE CASCADE
 account_tax_filiation_rel_pkey                                  | account_tax_filiation_rel                                     | PRIMARY KEY (parent_tax, child_tax)
 account_tax_filiation_rel_child_tax_fkey                        | account_tax_filiation_rel                                     | FOREIGN KEY (child_tax) REFERENCES account_tax(id) ON DELETE CASCADE
 account_tax_group_create_uid_fkey                               | account_tax_group                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_tax_group_country_id_fkey                               | account_tax_group                                             | FOREIGN KEY (country_id) REFERENCES res_country(id) ON DELETE SET NULL
 account_tax_group_advance_tax_payment_account_id_fkey           | account_tax_group                                             | FOREIGN KEY (advance_tax_payment_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 account_tax_group_tax_receivable_account_id_fkey                | account_tax_group                                             | FOREIGN KEY (tax_receivable_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 account_tax_group_tax_payable_account_id_fkey                   | account_tax_group                                             | FOREIGN KEY (tax_payable_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 account_tax_group_company_id_fkey                               | account_tax_group                                             | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 account_tax_group_write_uid_fkey                                | account_tax_group                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_tax_group_pkey                                          | account_tax_group                                             | PRIMARY KEY (id)
 account_tax_hr_expense_split_rel_pkey                           | account_tax_hr_expense_split_rel                              | PRIMARY KEY (hr_expense_split_id, account_tax_id)
 account_tax_hr_expense_split_rel_account_tax_id_fkey            | account_tax_hr_expense_split_rel                              | FOREIGN KEY (account_tax_id) REFERENCES account_tax(id) ON DELETE CASCADE
 account_tax_hr_expense_split_rel_hr_expense_split_id_fkey       | account_tax_hr_expense_split_rel                              | FOREIGN KEY (hr_expense_split_id) REFERENCES hr_expense_split(id) ON DELETE CASCADE
 account_tax_purchase_order_line_rel_pkey                        | account_tax_purchase_order_line_rel                           | PRIMARY KEY (purchase_order_line_id, account_tax_id)
 account_tax_purchase_order_line_rel_purchase_order_line_id_fkey | account_tax_purchase_order_line_rel                           | FOREIGN KEY (purchase_order_line_id) REFERENCES purchase_order_line(id) ON DELETE CASCADE
 account_tax_purchase_order_line_rel_account_tax_id_fkey         | account_tax_purchase_order_line_rel                           | FOREIGN KEY (account_tax_id) REFERENCES account_tax(id) ON DELETE CASCADE
 account_tax_repartition_line_write_uid_fkey                     | account_tax_repartition_line                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_tax_repartition_line_company_id_fkey                    | account_tax_repartition_line                                  | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 account_tax_repartition_line_create_uid_fkey                    | account_tax_repartition_line                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_tax_repartition_line_tax_id_fkey                        | account_tax_repartition_line                                  | FOREIGN KEY (tax_id) REFERENCES account_tax(id) ON DELETE CASCADE
 account_tax_repartition_line_pkey                               | account_tax_repartition_line                                  | PRIMARY KEY (id)
 account_tax_repartition_line_account_id_fkey                    | account_tax_repartition_line                                  | FOREIGN KEY (account_id) REFERENCES account_account(id) ON DELETE SET NULL
 account_tax_sale_order_discount_rel_account_tax_id_fkey         | account_tax_sale_order_discount_rel                           | FOREIGN KEY (account_tax_id) REFERENCES account_tax(id) ON DELETE CASCADE
 account_tax_sale_order_discount_rel_pkey                        | account_tax_sale_order_discount_rel                           | PRIMARY KEY (sale_order_discount_id, account_tax_id)
 account_tax_sale_order_discount_rel_sale_order_discount_id_fkey | account_tax_sale_order_discount_rel                           | FOREIGN KEY (sale_order_discount_id) REFERENCES sale_order_discount(id) ON DELETE CASCADE
 account_tax_sale_order_line_rel_sale_order_line_id_fkey         | account_tax_sale_order_line_rel                               | FOREIGN KEY (sale_order_line_id) REFERENCES sale_order_line(id) ON DELETE CASCADE
 account_tax_sale_order_line_rel_pkey                            | account_tax_sale_order_line_rel                               | PRIMARY KEY (sale_order_line_id, account_tax_id)
 account_tax_sale_order_line_rel_account_tax_id_fkey             | account_tax_sale_order_line_rel                               | FOREIGN KEY (account_tax_id) REFERENCES account_tax(id) ON DELETE CASCADE
 account_tax_unit_write_uid_fkey                                 | account_tax_unit                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_tax_unit_create_uid_fkey                                | account_tax_unit                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_tax_unit_main_company_id_fkey                           | account_tax_unit                                              | FOREIGN KEY (main_company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 account_tax_unit_country_id_fkey                                | account_tax_unit                                              | FOREIGN KEY (country_id) REFERENCES res_country(id) ON DELETE RESTRICT
 account_tax_unit_pkey                                           | account_tax_unit                                              | PRIMARY KEY (id)
 account_tax_unit_res_company_rel_account_tax_unit_id_fkey       | account_tax_unit_res_company_rel                              | FOREIGN KEY (account_tax_unit_id) REFERENCES account_tax_unit(id) ON DELETE CASCADE
 account_tax_unit_res_company_rel_res_company_id_fkey            | account_tax_unit_res_company_rel                              | FOREIGN KEY (res_company_id) REFERENCES res_company(id) ON DELETE CASCADE
 account_tax_unit_res_company_rel_pkey                           | account_tax_unit_res_company_rel                              | PRIMARY KEY (res_company_id, account_tax_unit_id)
 account_transfer_model_write_uid_fkey                           | account_transfer_model                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_transfer_model_pkey                                     | account_transfer_model                                        | PRIMARY KEY (id)
 account_transfer_model_journal_id_fkey                          | account_transfer_model                                        | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE RESTRICT
 account_transfer_model_create_uid_fkey                          | account_transfer_model                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_transfer_model_line_unique_account_by_transfer_model    | account_transfer_model_line                                   | UNIQUE (transfer_model_id, account_id)
 account_transfer_model_line_pkey                                | account_transfer_model_line                                   | PRIMARY KEY (id)
 account_transfer_model_line_transfer_model_id_fkey              | account_transfer_model_line                                   | FOREIGN KEY (transfer_model_id) REFERENCES account_transfer_model(id) ON DELETE CASCADE
 account_transfer_model_line_account_id_fkey                     | account_transfer_model_line                                   | FOREIGN KEY (account_id) REFERENCES account_account(id) ON DELETE RESTRICT
 account_transfer_model_line_create_uid_fkey                     | account_transfer_model_line                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_transfer_model_line_write_uid_fkey                      | account_transfer_model_line                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 account_transfer_model_line_res_partner_rel_pkey                | account_transfer_model_line_res_partner_rel                   | PRIMARY KEY (account_transfer_model_line_id, res_partner_id)
 account_transfer_model_line_res_partner_rel_res_partner_id_fkey | account_transfer_model_line_res_partner_rel                   | FOREIGN KEY (res_partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 account_transfer_model_line_r_account_transfer_model_line__fkey | account_transfer_model_line_res_partner_rel                   | FOREIGN KEY (account_transfer_model_line_id) REFERENCES account_transfer_model_line(id) ON DELETE CASCADE
 activity_attachment_rel_attachment_id_fkey                      | activity_attachment_rel                                       | FOREIGN KEY (attachment_id) REFERENCES ir_attachment(id) ON DELETE CASCADE
 activity_attachment_rel_activity_id_fkey                        | activity_attachment_rel                                       | FOREIGN KEY (activity_id) REFERENCES mail_activity(id) ON DELETE CASCADE
 activity_attachment_rel_pkey                                    | activity_attachment_rel                                       | PRIMARY KEY (activity_id, attachment_id)
 applicant_get_refuse_reason_template_id_fkey                    | applicant_get_refuse_reason                                   | FOREIGN KEY (template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 applicant_get_refuse_reason_refuse_reason_id_fkey               | applicant_get_refuse_reason                                   | FOREIGN KEY (refuse_reason_id) REFERENCES hr_applicant_refuse_reason(id) ON DELETE CASCADE
 applicant_get_refuse_reason_pkey                                | applicant_get_refuse_reason                                   | PRIMARY KEY (id)
 applicant_get_refuse_reason_write_uid_fkey                      | applicant_get_refuse_reason                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 applicant_get_refuse_reason_create_uid_fkey                     | applicant_get_refuse_reason                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 applicant_get_refuse_reason_h_applicant_get_refuse_reason__fkey | applicant_get_refuse_reason_hr_applicant_rel                  | FOREIGN KEY (applicant_get_refuse_reason_id) REFERENCES applicant_get_refuse_reason(id) ON DELETE CASCADE
 applicant_get_refuse_reason_hr_applicant_r_hr_applicant_id_fkey | applicant_get_refuse_reason_hr_applicant_rel                  | FOREIGN KEY (hr_applicant_id) REFERENCES hr_applicant(id) ON DELETE CASCADE
 applicant_get_refuse_reason_hr_applicant_rel_pkey               | applicant_get_refuse_reason_hr_applicant_rel                  | PRIMARY KEY (applicant_get_refuse_reason_id, hr_applicant_id)
 applicant_send_mail_template_id_fkey                            | applicant_send_mail                                           | FOREIGN KEY (template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 applicant_send_mail_pkey                                        | applicant_send_mail                                           | PRIMARY KEY (id)
 applicant_send_mail_author_id_fkey                              | applicant_send_mail                                           | FOREIGN KEY (author_id) REFERENCES res_partner(id) ON DELETE CASCADE
 applicant_send_mail_create_uid_fkey                             | applicant_send_mail                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 applicant_send_mail_write_uid_fkey                              | applicant_send_mail                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 applicant_send_mail_hr_applicant_rel_pkey                       | applicant_send_mail_hr_applicant_rel                          | PRIMARY KEY (applicant_send_mail_id, hr_applicant_id)
 applicant_send_mail_hr_applicant_rel_hr_applicant_id_fkey       | applicant_send_mail_hr_applicant_rel                          | FOREIGN KEY (hr_applicant_id) REFERENCES hr_applicant(id) ON DELETE CASCADE
 applicant_send_mail_hr_applicant_re_applicant_send_mail_id_fkey | applicant_send_mail_hr_applicant_rel                          | FOREIGN KEY (applicant_send_mail_id) REFERENCES applicant_send_mail(id) ON DELETE CASCADE
 applicant_send_mail_ir_attachment_r_applicant_send_mail_id_fkey | applicant_send_mail_ir_attachment_rel                         | FOREIGN KEY (applicant_send_mail_id) REFERENCES applicant_send_mail(id) ON DELETE CASCADE
 applicant_send_mail_ir_attachment_rel_pkey                      | applicant_send_mail_ir_attachment_rel                         | PRIMARY KEY (applicant_send_mail_id, ir_attachment_id)
 applicant_send_mail_ir_attachment_rel_ir_attachment_id_fkey     | applicant_send_mail_ir_attachment_rel                         | FOREIGN KEY (ir_attachment_id) REFERENCES ir_attachment(id) ON DELETE CASCADE
 approval_rule_users_to_notify_rel_res_users_id_fkey             | approval_rule_users_to_notify_rel                             | FOREIGN KEY (res_users_id) REFERENCES res_users(id) ON DELETE CASCADE
 approval_rule_users_to_notify_rel_studio_approval_rule_id_fkey  | approval_rule_users_to_notify_rel                             | FOREIGN KEY (studio_approval_rule_id) REFERENCES studio_approval_rule(id) ON DELETE CASCADE
 approval_rule_users_to_notify_rel_pkey                          | approval_rule_users_to_notify_rel                             | PRIMARY KEY (studio_approval_rule_id, res_users_id)
 asset_modify_account_asset_id_fkey                              | asset_modify                                                  | FOREIGN KEY (account_asset_id) REFERENCES account_account(id) ON DELETE SET NULL
 asset_modify_write_uid_fkey                                     | asset_modify                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 asset_modify_create_uid_fkey                                    | asset_modify                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 asset_modify_account_depreciation_expense_id_fkey               | asset_modify                                                  | FOREIGN KEY (account_depreciation_expense_id) REFERENCES account_account(id) ON DELETE SET NULL
 asset_modify_account_depreciation_id_fkey                       | asset_modify                                                  | FOREIGN KEY (account_depreciation_id) REFERENCES account_account(id) ON DELETE SET NULL
 asset_modify_pkey                                               | asset_modify                                                  | PRIMARY KEY (id)
 asset_modify_account_asset_counterpart_id_fkey                  | asset_modify                                                  | FOREIGN KEY (account_asset_counterpart_id) REFERENCES account_account(id) ON DELETE SET NULL
 asset_modify_asset_id_fkey                                      | asset_modify                                                  | FOREIGN KEY (asset_id) REFERENCES account_asset(id) ON DELETE CASCADE
 asset_move_line_rel_pkey                                        | asset_move_line_rel                                           | PRIMARY KEY (asset_id, line_id)
 asset_move_line_rel_asset_id_fkey                               | asset_move_line_rel                                           | FOREIGN KEY (asset_id) REFERENCES account_asset(id) ON DELETE CASCADE
 asset_move_line_rel_line_id_fkey                                | asset_move_line_rel                                           | FOREIGN KEY (line_id) REFERENCES account_move_line(id) ON DELETE CASCADE
 auth_totp_device_index_check                                    | auth_totp_device                                              | CHECK ((char_length((index)::text) = 8))
 auth_totp_device_user_id_fkey                                   | auth_totp_device                                              | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 auth_totp_device_pkey                                           | auth_totp_device                                              | PRIMARY KEY (id)
 auth_totp_wizard_write_uid_fkey                                 | auth_totp_wizard                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 auth_totp_wizard_pkey                                           | auth_totp_wizard                                              | PRIMARY KEY (id)
 auth_totp_wizard_user_id_fkey                                   | auth_totp_wizard                                              | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 auth_totp_wizard_create_uid_fkey                                | auth_totp_wizard                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 avatax_connection_test_result_pkey                              | avatax_connection_test_result                                 | PRIMARY KEY (id)
 avatax_connection_test_result_create_uid_fkey                   | avatax_connection_test_result                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 avatax_connection_test_result_write_uid_fkey                    | avatax_connection_test_result                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 avatax_exemption_write_uid_fkey                                 | avatax_exemption                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 avatax_exemption_company_id_fkey                                | avatax_exemption                                              | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 avatax_exemption_create_uid_fkey                                | avatax_exemption                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 avatax_exemption_pkey                                           | avatax_exemption                                              | PRIMARY KEY (id)
 avatax_exemption_res_country_rel_pkey                           | avatax_exemption_res_country_rel                              | PRIMARY KEY (avatax_exemption_id, res_country_id)
 avatax_exemption_res_country_rel_res_country_id_fkey            | avatax_exemption_res_country_rel                              | FOREIGN KEY (res_country_id) REFERENCES res_country(id) ON DELETE CASCADE
 avatax_exemption_res_country_rel_avatax_exemption_id_fkey       | avatax_exemption_res_country_rel                              | FOREIGN KEY (avatax_exemption_id) REFERENCES avatax_exemption(id) ON DELETE CASCADE
 avatax_validate_address_write_uid_fkey                          | avatax_validate_address                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 avatax_validate_address_create_uid_fkey                         | avatax_validate_address                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 avatax_validate_address_partner_id_fkey                         | avatax_validate_address                                       | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 avatax_validate_address_pkey                                    | avatax_validate_address                                       | PRIMARY KEY (id)
 barcode_nomenclature_write_uid_fkey                             | barcode_nomenclature                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 barcode_nomenclature_pkey                                       | barcode_nomenclature                                          | PRIMARY KEY (id)
 barcode_nomenclature_create_uid_fkey                            | barcode_nomenclature                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 barcode_rule_barcode_nomenclature_id_fkey                       | barcode_rule                                                  | FOREIGN KEY (barcode_nomenclature_id) REFERENCES barcode_nomenclature(id) ON DELETE SET NULL
 barcode_rule_write_uid_fkey                                     | barcode_rule                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 barcode_rule_associated_uom_id_fkey                             | barcode_rule                                                  | FOREIGN KEY (associated_uom_id) REFERENCES uom_uom(id) ON DELETE SET NULL
 barcode_rule_create_uid_fkey                                    | barcode_rule                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 barcode_rule_pkey                                               | barcode_rule                                                  | PRIMARY KEY (id)
 base_automation_write_uid_fkey                                  | base_automation                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_automation_trg_date_resource_field_id_fkey                 | base_automation                                               | FOREIGN KEY (trg_date_resource_field_id) REFERENCES ir_model_fields(id) ON DELETE SET NULL
 base_automation_create_uid_fkey                                 | base_automation                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_automation_pkey                                            | base_automation                                               | PRIMARY KEY (id)
 base_automation_trg_date_calendar_id_fkey                       | base_automation                                               | FOREIGN KEY (trg_date_calendar_id) REFERENCES resource_calendar(id) ON DELETE SET NULL
 base_automation_model_id_fkey                                   | base_automation                                               | FOREIGN KEY (model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 base_automation_trg_selection_field_id_fkey                     | base_automation                                               | FOREIGN KEY (trg_selection_field_id) REFERENCES ir_model_fields_selection(id) ON DELETE SET NULL
 base_automation_trg_date_id_fkey                                | base_automation                                               | FOREIGN KEY (trg_date_id) REFERENCES ir_model_fields(id) ON DELETE SET NULL
 base_automation_ir_model_fields_rel_pkey                        | base_automation_ir_model_fields_rel                           | PRIMARY KEY (base_automation_id, ir_model_fields_id)
 base_automation_ir_model_fields_rel_base_automation_id_fkey     | base_automation_ir_model_fields_rel                           | FOREIGN KEY (base_automation_id) REFERENCES base_automation(id) ON DELETE CASCADE
 base_automation_ir_model_fields_rel_ir_model_fields_id_fkey     | base_automation_ir_model_fields_rel                           | FOREIGN KEY (ir_model_fields_id) REFERENCES ir_model_fields(id) ON DELETE CASCADE
 base_automation_onchange_fields_rel_ir_model_fields_id_fkey     | base_automation_onchange_fields_rel                           | FOREIGN KEY (ir_model_fields_id) REFERENCES ir_model_fields(id) ON DELETE CASCADE
 base_automation_onchange_fields_rel_base_automation_id_fkey     | base_automation_onchange_fields_rel                           | FOREIGN KEY (base_automation_id) REFERENCES base_automation(id) ON DELETE CASCADE
 base_automation_onchange_fields_rel_pkey                        | base_automation_onchange_fields_rel                           | PRIMARY KEY (base_automation_id, ir_model_fields_id)
 base_document_layout_report_layout_id_fkey                      | base_document_layout                                          | FOREIGN KEY (report_layout_id) REFERENCES report_layout(id) ON DELETE SET NULL
 base_document_layout_write_uid_fkey                             | base_document_layout                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_document_layout_create_uid_fkey                            | base_document_layout                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_document_layout_company_id_fkey                            | base_document_layout                                          | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE CASCADE
 base_document_layout_pkey                                       | base_document_layout                                          | PRIMARY KEY (id)
 base_enable_profiling_wizard_create_uid_fkey                    | base_enable_profiling_wizard                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_enable_profiling_wizard_write_uid_fkey                     | base_enable_profiling_wizard                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_enable_profiling_wizard_pkey                               | base_enable_profiling_wizard                                  | PRIMARY KEY (id)
 base_import_import_pkey                                         | base_import_import                                            | PRIMARY KEY (id)
 base_import_import_write_uid_fkey                               | base_import_import                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_import_import_create_uid_fkey                              | base_import_import                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_import_mapping_write_uid_fkey                              | base_import_mapping                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_import_mapping_create_uid_fkey                             | base_import_mapping                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_import_mapping_pkey                                        | base_import_mapping                                           | PRIMARY KEY (id)
 base_import_module_pkey                                         | base_import_module                                            | PRIMARY KEY (id)
 base_import_module_create_uid_fkey                              | base_import_module                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_import_module_write_uid_fkey                               | base_import_module                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_language_export_create_uid_fkey                            | base_language_export                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_language_export_write_uid_fkey                             | base_language_export                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_language_export_pkey                                       | base_language_export                                          | PRIMARY KEY (id)
 base_language_export_model_id_fkey                              | base_language_export                                          | FOREIGN KEY (model_id) REFERENCES ir_model(id) ON DELETE SET NULL
 base_language_import_pkey                                       | base_language_import                                          | PRIMARY KEY (id)
 base_language_import_write_uid_fkey                             | base_language_import                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_language_import_create_uid_fkey                            | base_language_import                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_language_install_pkey                                      | base_language_install                                         | PRIMARY KEY (id)
 base_language_install_write_uid_fkey                            | base_language_install                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_language_install_create_uid_fkey                           | base_language_install                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_language_install_website_rel_pkey                          | base_language_install_website_rel                             | PRIMARY KEY (base_language_install_id, website_id)
 base_language_install_website_rel_base_language_install_id_fkey | base_language_install_website_rel                             | FOREIGN KEY (base_language_install_id) REFERENCES base_language_install(id) ON DELETE CASCADE
 base_language_install_website_rel_website_id_fkey               | base_language_install_website_rel                             | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE CASCADE
 base_module_install_request_create_uid_fkey                     | base_module_install_request                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_module_install_request_user_id_fkey                        | base_module_install_request                                   | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 base_module_install_request_module_id_fkey                      | base_module_install_request                                   | FOREIGN KEY (module_id) REFERENCES ir_module_module(id) ON DELETE CASCADE
 base_module_install_request_write_uid_fkey                      | base_module_install_request                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_module_install_request_pkey                                | base_module_install_request                                   | PRIMARY KEY (id)
 base_module_install_review_pkey                                 | base_module_install_review                                    | PRIMARY KEY (id)
 base_module_install_review_write_uid_fkey                       | base_module_install_review                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_module_install_review_create_uid_fkey                      | base_module_install_review                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_module_install_review_module_id_fkey                       | base_module_install_review                                    | FOREIGN KEY (module_id) REFERENCES ir_module_module(id) ON DELETE CASCADE
 base_module_uninstall_create_uid_fkey                           | base_module_uninstall                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_module_uninstall_write_uid_fkey                            | base_module_uninstall                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_module_uninstall_pkey                                      | base_module_uninstall                                         | PRIMARY KEY (id)
 base_module_uninstall_module_id_fkey                            | base_module_uninstall                                         | FOREIGN KEY (module_id) REFERENCES ir_module_module(id) ON DELETE CASCADE
 base_module_update_pkey                                         | base_module_update                                            | PRIMARY KEY (id)
 base_module_update_create_uid_fkey                              | base_module_update                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_module_update_write_uid_fkey                               | base_module_update                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_module_upgrade_write_uid_fkey                              | base_module_upgrade                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_module_upgrade_pkey                                        | base_module_upgrade                                           | PRIMARY KEY (id)
 base_module_upgrade_create_uid_fkey                             | base_module_upgrade                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_partner_merge_automatic_wizard_dst_partner_id_fkey         | base_partner_merge_automatic_wizard                           | FOREIGN KEY (dst_partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 base_partner_merge_automatic_wizard_pkey                        | base_partner_merge_automatic_wizard                           | PRIMARY KEY (id)
 base_partner_merge_automatic_wizard_create_uid_fkey             | base_partner_merge_automatic_wizard                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_partner_merge_automatic_wizard_write_uid_fkey              | base_partner_merge_automatic_wizard                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_partner_merge_automatic_wizard_current_line_id_fkey        | base_partner_merge_automatic_wizard                           | FOREIGN KEY (current_line_id) REFERENCES base_partner_merge_line(id) ON DELETE SET NULL
 base_partner_merge_automatic__base_partner_merge_automatic_fkey | base_partner_merge_automatic_wizard_res_partner_rel           | FOREIGN KEY (base_partner_merge_automatic_wizard_id) REFERENCES base_partner_merge_automatic_wizard(id) ON DELETE CASCADE
 base_partner_merge_automatic_wizard_res_par_res_partner_id_fkey | base_partner_merge_automatic_wizard_res_partner_rel           | FOREIGN KEY (res_partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 base_partner_merge_automatic_wizard_res_partner_rel_pkey        | base_partner_merge_automatic_wizard_res_partner_rel           | PRIMARY KEY (base_partner_merge_automatic_wizard_id, res_partner_id)
 base_partner_merge_line_pkey                                    | base_partner_merge_line                                       | PRIMARY KEY (id)
 base_partner_merge_line_create_uid_fkey                         | base_partner_merge_line                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 base_partner_merge_line_wizard_id_fkey                          | base_partner_merge_line                                       | FOREIGN KEY (wizard_id) REFERENCES base_partner_merge_automatic_wizard(id) ON DELETE SET NULL
 base_partner_merge_line_write_uid_fkey                          | base_partner_merge_line                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 bill_to_po_wizard_pkey                                          | bill_to_po_wizard                                             | PRIMARY KEY (id)
 bill_to_po_wizard_write_uid_fkey                                | bill_to_po_wizard                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 bill_to_po_wizard_purchase_order_id_fkey                        | bill_to_po_wizard                                             | FOREIGN KEY (purchase_order_id) REFERENCES purchase_order(id) ON DELETE SET NULL
 bill_to_po_wizard_partner_id_fkey                               | bill_to_po_wizard                                             | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 bill_to_po_wizard_create_uid_fkey                               | bill_to_po_wizard                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 budget_analytic_parent_id_fkey                                  | budget_analytic                                               | FOREIGN KEY (parent_id) REFERENCES budget_analytic(id) ON DELETE CASCADE
 budget_analytic_user_id_fkey                                    | budget_analytic                                               | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 budget_analytic_company_id_fkey                                 | budget_analytic                                               | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 budget_analytic_create_uid_fkey                                 | budget_analytic                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 budget_analytic_write_uid_fkey                                  | budget_analytic                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 budget_analytic_pkey                                            | budget_analytic                                               | PRIMARY KEY (id)
 budget_line_budget_analytic_id_fkey                             | budget_line                                                   | FOREIGN KEY (budget_analytic_id) REFERENCES budget_analytic(id) ON DELETE CASCADE
 budget_line_create_uid_fkey                                     | budget_line                                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 budget_line_account_id_fkey                                     | budget_line                                                   | FOREIGN KEY (account_id) REFERENCES account_analytic_account(id) ON DELETE RESTRICT
 budget_line_write_uid_fkey                                      | budget_line                                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 budget_line_x_plan4_id_fkey                                     | budget_line                                                   | FOREIGN KEY (x_plan4_id) REFERENCES account_analytic_account(id) ON DELETE RESTRICT
 budget_line_company_id_fkey                                     | budget_line                                                   | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 budget_line_pkey                                                | budget_line                                                   | PRIMARY KEY (id)
 budget_line_x_plan2_id_fkey                                     | budget_line                                                   | FOREIGN KEY (x_plan2_id) REFERENCES account_analytic_account(id) ON DELETE RESTRICT
 budget_split_wizard_pkey                                        | budget_split_wizard                                           | PRIMARY KEY (id)
 budget_split_wizard_create_uid_fkey                             | budget_split_wizard                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 budget_split_wizard_write_uid_fkey                              | budget_split_wizard                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 bus_bus_write_uid_fkey                                          | bus_bus                                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 bus_bus_create_uid_fkey                                         | bus_bus                                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 bus_bus_pkey                                                    | bus_bus                                                       | PRIMARY KEY (id)
 bus_presence_user_id_fkey                                       | bus_presence                                                  | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 bus_presence_partner_or_guest_exists                            | bus_presence                                                  | CHECK ((((user_id IS NOT NULL) AND (guest_id IS NULL)) OR ((user_id IS NULL) AND (guest_id IS NOT NULL))))
 bus_presence_guest_id_fkey                                      | bus_presence                                                  | FOREIGN KEY (guest_id) REFERENCES mail_guest(id) ON DELETE CASCADE
 bus_presence_pkey                                               | bus_presence                                                  | PRIMARY KEY (id)
 calendar_alarm_write_uid_fkey                                   | calendar_alarm                                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 calendar_alarm_create_uid_fkey                                  | calendar_alarm                                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 calendar_alarm_sms_template_id_fkey                             | calendar_alarm                                                | FOREIGN KEY (sms_template_id) REFERENCES sms_template(id) ON DELETE SET NULL
 calendar_alarm_pkey                                             | calendar_alarm                                                | PRIMARY KEY (id)
 calendar_alarm_mail_template_id_fkey                            | calendar_alarm                                                | FOREIGN KEY (mail_template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 calendar_alarm_calendar_event_rel_calendar_alarm_id_fkey        | calendar_alarm_calendar_event_rel                             | FOREIGN KEY (calendar_alarm_id) REFERENCES calendar_alarm(id) ON DELETE RESTRICT
 calendar_alarm_calendar_event_rel_pkey                          | calendar_alarm_calendar_event_rel                             | PRIMARY KEY (calendar_event_id, calendar_alarm_id)
 calendar_alarm_calendar_event_rel_calendar_event_id_fkey        | calendar_alarm_calendar_event_rel                             | FOREIGN KEY (calendar_event_id) REFERENCES calendar_event(id) ON DELETE CASCADE
 calendar_attendee_event_id_fkey                                 | calendar_attendee                                             | FOREIGN KEY (event_id) REFERENCES calendar_event(id) ON DELETE CASCADE
 calendar_attendee_pkey                                          | calendar_attendee                                             | PRIMARY KEY (id)
 calendar_attendee_write_uid_fkey                                | calendar_attendee                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 calendar_attendee_partner_id_fkey                               | calendar_attendee                                             | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 calendar_attendee_create_uid_fkey                               | calendar_attendee                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 calendar_event_pkey                                             | calendar_event                                                | PRIMARY KEY (id)
 calendar_event_recurrence_id_fkey                               | calendar_event                                                | FOREIGN KEY (recurrence_id) REFERENCES calendar_recurrence(id) ON DELETE SET NULL
 calendar_event_create_uid_fkey                                  | calendar_event                                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 calendar_event_user_id_fkey                                     | calendar_event                                                | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 calendar_event_candidate_id_fkey                                | calendar_event                                                | FOREIGN KEY (candidate_id) REFERENCES hr_candidate(id) ON DELETE SET NULL
 calendar_event_videocall_channel_id_fkey                        | calendar_event                                                | FOREIGN KEY (videocall_channel_id) REFERENCES discuss_channel(id) ON DELETE SET NULL
 calendar_event_res_model_id_fkey                                | calendar_event                                                | FOREIGN KEY (res_model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 calendar_event_write_uid_fkey                                   | calendar_event                                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 calendar_event_opportunity_id_fkey                              | calendar_event                                                | FOREIGN KEY (opportunity_id) REFERENCES crm_lead(id) ON DELETE SET NULL
 calendar_event_applicant_id_fkey                                | calendar_event                                                | FOREIGN KEY (applicant_id) REFERENCES hr_applicant(id) ON DELETE SET NULL
 calendar_event_res_partner_rel_pkey                             | calendar_event_res_partner_rel                                | PRIMARY KEY (res_partner_id, calendar_event_id)
 calendar_event_res_partner_rel_calendar_event_id_fkey           | calendar_event_res_partner_rel                                | FOREIGN KEY (calendar_event_id) REFERENCES calendar_event(id) ON DELETE CASCADE
 calendar_event_res_partner_rel_res_partner_id_fkey              | calendar_event_res_partner_rel                                | FOREIGN KEY (res_partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 calendar_event_type_create_uid_fkey                             | calendar_event_type                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 calendar_event_type_name_uniq                                   | calendar_event_type                                           | UNIQUE (name)
 calendar_event_type_pkey                                        | calendar_event_type                                           | PRIMARY KEY (id)
 calendar_event_type_write_uid_fkey                              | calendar_event_type                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 calendar_filters_user_id_partner_id_unique                      | calendar_filters                                              | UNIQUE (user_id, partner_id)
 calendar_filters_user_id_fkey                                   | calendar_filters                                              | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 calendar_filters_partner_id_fkey                                | calendar_filters                                              | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE RESTRICT
 calendar_filters_create_uid_fkey                                | calendar_filters                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 calendar_filters_write_uid_fkey                                 | calendar_filters                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 calendar_filters_pkey                                           | calendar_filters                                              | PRIMARY KEY (id)
 calendar_popover_delete_wizard_create_uid_fkey                  | calendar_popover_delete_wizard                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 calendar_popover_delete_wizard_pkey                             | calendar_popover_delete_wizard                                | PRIMARY KEY (id)
 calendar_popover_delete_wizard_write_uid_fkey                   | calendar_popover_delete_wizard                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 calendar_popover_delete_wizard_record_fkey                      | calendar_popover_delete_wizard                                | FOREIGN KEY (record) REFERENCES calendar_event(id) ON DELETE SET NULL
 calendar_provider_config_write_uid_fkey                         | calendar_provider_config                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 calendar_provider_config_create_uid_fkey                        | calendar_provider_config                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 calendar_provider_config_pkey                                   | calendar_provider_config                                      | PRIMARY KEY (id)
 calendar_recurrence_trigger_id_fkey                             | calendar_recurrence                                           | FOREIGN KEY (trigger_id) REFERENCES ir_cron_trigger(id) ON DELETE SET NULL
 calendar_recurrence_base_event_id_fkey                          | calendar_recurrence                                           | FOREIGN KEY (base_event_id) REFERENCES calendar_event(id) ON DELETE SET NULL
 calendar_recurrence_write_uid_fkey                              | calendar_recurrence                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 calendar_recurrence_month_day                                   | calendar_recurrence                                           | CHECK ((((rrule_type)::text <> 'monthly'::text) OR ((month_by)::text <> 'day'::text) OR ((day >= 1) AND (day <= 31)) OR (((weekday)::text = ANY ((ARRAY['MON'::character varying, 'TUE'::character varying, 'WED'::character varying, 'THU'::character varying, 'FRI'::character varying, 'SAT'::character varying, 'SUN'::character varying])::text[])) AND ((byday)::text = ANY ((ARRAY['1'::character varying, '2'::character varying, '3'::character varying, '4'::character varying, '-1'::character varying])::text[])))))
 calendar_recurrence_create_uid_fkey                             | calendar_recurrence                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 calendar_recurrence_pkey                                        | calendar_recurrence                                           | PRIMARY KEY (id)
 candidate_send_mail_pkey                                        | candidate_send_mail                                           | PRIMARY KEY (id)
 candidate_send_mail_create_uid_fkey                             | candidate_send_mail                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 candidate_send_mail_write_uid_fkey                              | candidate_send_mail                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 candidate_send_mail_template_id_fkey                            | candidate_send_mail                                           | FOREIGN KEY (template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 candidate_send_mail_author_id_fkey                              | candidate_send_mail                                           | FOREIGN KEY (author_id) REFERENCES res_partner(id) ON DELETE CASCADE
 candidate_send_mail_hr_candidate_rel_hr_candidate_id_fkey       | candidate_send_mail_hr_candidate_rel                          | FOREIGN KEY (hr_candidate_id) REFERENCES hr_candidate(id) ON DELETE CASCADE
 candidate_send_mail_hr_candidate_re_candidate_send_mail_id_fkey | candidate_send_mail_hr_candidate_rel                          | FOREIGN KEY (candidate_send_mail_id) REFERENCES candidate_send_mail(id) ON DELETE CASCADE
 candidate_send_mail_hr_candidate_rel_pkey                       | candidate_send_mail_hr_candidate_rel                          | PRIMARY KEY (candidate_send_mail_id, hr_candidate_id)
 candidate_send_mail_ir_attachment_rel_ir_attachment_id_fkey     | candidate_send_mail_ir_attachment_rel                         | FOREIGN KEY (ir_attachment_id) REFERENCES ir_attachment(id) ON DELETE CASCADE
 candidate_send_mail_ir_attachment_rel_pkey                      | candidate_send_mail_ir_attachment_rel                         | PRIMARY KEY (candidate_send_mail_id, ir_attachment_id)
 candidate_send_mail_ir_attachment_r_candidate_send_mail_id_fkey | candidate_send_mail_ir_attachment_rel                         | FOREIGN KEY (candidate_send_mail_id) REFERENCES candidate_send_mail(id) ON DELETE CASCADE
 change_password_own_write_uid_fkey                              | change_password_own                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 change_password_own_create_uid_fkey                             | change_password_own                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 change_password_own_pkey                                        | change_password_own                                           | PRIMARY KEY (id)
 change_password_user_user_id_fkey                               | change_password_user                                          | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 change_password_user_wizard_id_fkey                             | change_password_user                                          | FOREIGN KEY (wizard_id) REFERENCES change_password_wizard(id) ON DELETE CASCADE
 change_password_user_pkey                                       | change_password_user                                          | PRIMARY KEY (id)
 change_password_user_create_uid_fkey                            | change_password_user                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 change_password_user_write_uid_fkey                             | change_password_user                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 change_password_wizard_write_uid_fkey                           | change_password_wizard                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 change_password_wizard_pkey                                     | change_password_wizard                                        | PRIMARY KEY (id)
 change_password_wizard_create_uid_fkey                          | change_password_wizard                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 change_production_qty_pkey                                      | change_production_qty                                         | PRIMARY KEY (id)
 change_production_qty_mo_id_fkey                                | change_production_qty                                         | FOREIGN KEY (mo_id) REFERENCES mrp_production(id) ON DELETE CASCADE
 change_production_qty_write_uid_fkey                            | change_production_qty                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 change_production_qty_create_uid_fkey                           | change_production_qty                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 confirm_stock_sms_pkey                                          | confirm_stock_sms                                             | PRIMARY KEY (id)
 confirm_stock_sms_write_uid_fkey                                | confirm_stock_sms                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 confirm_stock_sms_create_uid_fkey                               | confirm_stock_sms                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_convert_lead_mass_lead_re_crm_lead2opportunity_partner_fkey | crm_convert_lead_mass_lead_rel                                | FOREIGN KEY (crm_lead2opportunity_partner_mass_id) REFERENCES crm_lead2opportunity_partner_mass(id) ON DELETE CASCADE
 crm_convert_lead_mass_lead_rel_pkey                             | crm_convert_lead_mass_lead_rel                                | PRIMARY KEY (crm_lead2opportunity_partner_mass_id, crm_lead_id)
 crm_convert_lead_mass_lead_rel_crm_lead_id_fkey                 | crm_convert_lead_mass_lead_rel                                | FOREIGN KEY (crm_lead_id) REFERENCES crm_lead(id) ON DELETE CASCADE
 crm_iap_lead_helpers_pkey                                       | crm_iap_lead_helpers                                          | PRIMARY KEY (id)
 crm_iap_lead_helpers_write_uid_fkey                             | crm_iap_lead_helpers                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_iap_lead_helpers_create_uid_fkey                            | crm_iap_lead_helpers                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_iap_lead_industry_write_uid_fkey                            | crm_iap_lead_industry                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_iap_lead_industry_pkey                                      | crm_iap_lead_industry                                         | PRIMARY KEY (id)
 crm_iap_lead_industry_name_uniq                                 | crm_iap_lead_industry                                         | UNIQUE (name)
 crm_iap_lead_industry_create_uid_fkey                           | crm_iap_lead_industry                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_iap_lead_industry_crm_iap_lead_mining_request_rel_pkey      | crm_iap_lead_industry_crm_iap_lead_mining_request_rel         | PRIMARY KEY (crm_iap_lead_mining_request_id, crm_iap_lead_industry_id)
 crm_iap_lead_industry_crm_iap_lea_crm_iap_lead_industry_id_fkey | crm_iap_lead_industry_crm_iap_lead_mining_request_rel         | FOREIGN KEY (crm_iap_lead_industry_id) REFERENCES crm_iap_lead_industry(id) ON DELETE CASCADE
 crm_iap_lead_industry_crm_iap_crm_iap_lead_mining_request__fkey | crm_iap_lead_industry_crm_iap_lead_mining_request_rel         | FOREIGN KEY (crm_iap_lead_mining_request_id) REFERENCES crm_iap_lead_mining_request(id) ON DELETE CASCADE
 crm_iap_lead_industry_crm_reveal_rule_rel_pkey                  | crm_iap_lead_industry_crm_reveal_rule_rel                     | PRIMARY KEY (crm_reveal_rule_id, crm_iap_lead_industry_id)
 crm_iap_lead_industry_crm_reveal_rule_r_crm_reveal_rule_id_fkey | crm_iap_lead_industry_crm_reveal_rule_rel                     | FOREIGN KEY (crm_reveal_rule_id) REFERENCES crm_reveal_rule(id) ON DELETE CASCADE
 crm_iap_lead_industry_crm_reveal__crm_iap_lead_industry_id_fkey | crm_iap_lead_industry_crm_reveal_rule_rel                     | FOREIGN KEY (crm_iap_lead_industry_id) REFERENCES crm_iap_lead_industry(id) ON DELETE CASCADE
 crm_iap_lead_mining_request_team_id_fkey                        | crm_iap_lead_mining_request                                   | FOREIGN KEY (team_id) REFERENCES crm_team(id) ON DELETE SET NULL
 crm_iap_lead_mining_request_preferred_role_id_fkey              | crm_iap_lead_mining_request                                   | FOREIGN KEY (preferred_role_id) REFERENCES crm_iap_lead_role(id) ON DELETE SET NULL
 crm_iap_lead_mining_request_seniority_id_fkey                   | crm_iap_lead_mining_request                                   | FOREIGN KEY (seniority_id) REFERENCES crm_iap_lead_seniority(id) ON DELETE SET NULL
 crm_iap_lead_mining_request_create_uid_fkey                     | crm_iap_lead_mining_request                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_iap_lead_mining_request_pkey                                | crm_iap_lead_mining_request                                   | PRIMARY KEY (id)
 crm_iap_lead_mining_request_write_uid_fkey                      | crm_iap_lead_mining_request                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_iap_lead_mining_request_user_id_fkey                        | crm_iap_lead_mining_request                                   | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 crm_iap_lead_mining_request__crm_iap_lead_mining_request__fkey2 | crm_iap_lead_mining_request_crm_iap_lead_role_rel             | FOREIGN KEY (crm_iap_lead_mining_request_id) REFERENCES crm_iap_lead_mining_request(id) ON DELETE CASCADE
 crm_iap_lead_mining_request_crm_iap_lead_role_rel_pkey          | crm_iap_lead_mining_request_crm_iap_lead_role_rel             | PRIMARY KEY (crm_iap_lead_mining_request_id, crm_iap_lead_role_id)
 crm_iap_lead_mining_request_crm_iap_l_crm_iap_lead_role_id_fkey | crm_iap_lead_mining_request_crm_iap_lead_role_rel             | FOREIGN KEY (crm_iap_lead_role_id) REFERENCES crm_iap_lead_role(id) ON DELETE CASCADE
 crm_iap_lead_mining_request_c_crm_iap_lead_mining_request__fkey | crm_iap_lead_mining_request_crm_tag_rel                       | FOREIGN KEY (crm_iap_lead_mining_request_id) REFERENCES crm_iap_lead_mining_request(id) ON DELETE CASCADE
 crm_iap_lead_mining_request_crm_tag_rel_crm_tag_id_fkey         | crm_iap_lead_mining_request_crm_tag_rel                       | FOREIGN KEY (crm_tag_id) REFERENCES crm_tag(id) ON DELETE CASCADE
 crm_iap_lead_mining_request_crm_tag_rel_pkey                    | crm_iap_lead_mining_request_crm_tag_rel                       | PRIMARY KEY (crm_iap_lead_mining_request_id, crm_tag_id)
 crm_iap_lead_mining_request_res_country_rel_pkey                | crm_iap_lead_mining_request_res_country_rel                   | PRIMARY KEY (crm_iap_lead_mining_request_id, res_country_id)
 crm_iap_lead_mining_request_r_crm_iap_lead_mining_request__fkey | crm_iap_lead_mining_request_res_country_rel                   | FOREIGN KEY (crm_iap_lead_mining_request_id) REFERENCES crm_iap_lead_mining_request(id) ON DELETE CASCADE
 crm_iap_lead_mining_request_res_country_rel_res_country_id_fkey | crm_iap_lead_mining_request_res_country_rel                   | FOREIGN KEY (res_country_id) REFERENCES res_country(id) ON DELETE CASCADE
 crm_iap_lead_mining_request_res_count_res_country_state_id_fkey | crm_iap_lead_mining_request_res_country_state_rel             | FOREIGN KEY (res_country_state_id) REFERENCES res_country_state(id) ON DELETE CASCADE
 crm_iap_lead_mining_request__crm_iap_lead_mining_request__fkey1 | crm_iap_lead_mining_request_res_country_state_rel             | FOREIGN KEY (crm_iap_lead_mining_request_id) REFERENCES crm_iap_lead_mining_request(id) ON DELETE CASCADE
 crm_iap_lead_mining_request_res_country_state_rel_pkey          | crm_iap_lead_mining_request_res_country_state_rel             | PRIMARY KEY (crm_iap_lead_mining_request_id, res_country_state_id)
 crm_iap_lead_role_create_uid_fkey                               | crm_iap_lead_role                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_iap_lead_role_write_uid_fkey                                | crm_iap_lead_role                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_iap_lead_role_name_uniq                                     | crm_iap_lead_role                                             | UNIQUE (name)
 crm_iap_lead_role_pkey                                          | crm_iap_lead_role                                             | PRIMARY KEY (id)
 crm_iap_lead_role_crm_reveal_rule_rel_pkey                      | crm_iap_lead_role_crm_reveal_rule_rel                         | PRIMARY KEY (crm_reveal_rule_id, crm_iap_lead_role_id)
 crm_iap_lead_role_crm_reveal_rule_rel_crm_iap_lead_role_id_fkey | crm_iap_lead_role_crm_reveal_rule_rel                         | FOREIGN KEY (crm_iap_lead_role_id) REFERENCES crm_iap_lead_role(id) ON DELETE CASCADE
 crm_iap_lead_role_crm_reveal_rule_rel_crm_reveal_rule_id_fkey   | crm_iap_lead_role_crm_reveal_rule_rel                         | FOREIGN KEY (crm_reveal_rule_id) REFERENCES crm_reveal_rule(id) ON DELETE CASCADE
 crm_iap_lead_seniority_write_uid_fkey                           | crm_iap_lead_seniority                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_iap_lead_seniority_pkey                                     | crm_iap_lead_seniority                                        | PRIMARY KEY (id)
 crm_iap_lead_seniority_name_uniq                                | crm_iap_lead_seniority                                        | UNIQUE (name)
 crm_iap_lead_seniority_create_uid_fkey                          | crm_iap_lead_seniority                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_lead_assigned_vehicle_id_fkey                               | crm_lead                                                      | FOREIGN KEY (assigned_vehicle_id) REFERENCES fleet_vehicle(id) ON DELETE SET NULL
 crm_lead_pkey                                                   | crm_lead                                                      | PRIMARY KEY (id)
 crm_lead_partner_id_fkey                                        | crm_lead                                                      | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 crm_lead_title_fkey                                             | crm_lead                                                      | FOREIGN KEY (title) REFERENCES res_partner_title(id) ON DELETE SET NULL
 crm_lead_lang_id_fkey                                           | crm_lead                                                      | FOREIGN KEY (lang_id) REFERENCES res_lang(id) ON DELETE SET NULL
 crm_lead_state_id_fkey                                          | crm_lead                                                      | FOREIGN KEY (state_id) REFERENCES res_country_state(id) ON DELETE SET NULL
 crm_lead_check_probability                                      | crm_lead                                                      | CHECK (((probability >= (0)::double precision) AND (probability <= (100)::double precision)))
 crm_lead_x_studio_many2one_field_6v2_1jhfqmqkp_fkey             | crm_lead                                                      | FOREIGN KEY (x_studio_assigned_truck) REFERENCES fleet_vehicle(id) ON DELETE SET NULL
 crm_lead_campaign_id_fkey                                       | crm_lead                                                      | FOREIGN KEY (campaign_id) REFERENCES utm_campaign(id) ON DELETE SET NULL
 crm_lead_source_id_fkey                                         | crm_lead                                                      | FOREIGN KEY (source_id) REFERENCES utm_source(id) ON DELETE SET NULL
 crm_lead_medium_id_fkey                                         | crm_lead                                                      | FOREIGN KEY (medium_id) REFERENCES utm_medium(id) ON DELETE SET NULL
 crm_lead_user_id_fkey                                           | crm_lead                                                      | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 crm_lead_team_id_fkey                                           | crm_lead                                                      | FOREIGN KEY (team_id) REFERENCES crm_team(id) ON DELETE SET NULL
 crm_lead_company_id_fkey                                        | crm_lead                                                      | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 crm_lead_stage_id_fkey                                          | crm_lead                                                      | FOREIGN KEY (stage_id) REFERENCES crm_stage(id) ON DELETE RESTRICT
 crm_lead_recurring_plan_fkey                                    | crm_lead                                                      | FOREIGN KEY (recurring_plan) REFERENCES crm_recurring_plan(id) ON DELETE SET NULL
 crm_lead_country_id_fkey                                        | crm_lead                                                      | FOREIGN KEY (country_id) REFERENCES res_country(id) ON DELETE SET NULL
 crm_lead_lost_reason_id_fkey                                    | crm_lead                                                      | FOREIGN KEY (lost_reason_id) REFERENCES crm_lost_reason(id) ON DELETE RESTRICT
 crm_lead_create_uid_fkey                                        | crm_lead                                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_lead_write_uid_fkey                                         | crm_lead                                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_lead_lead_mining_request_id_fkey                            | crm_lead                                                      | FOREIGN KEY (lead_mining_request_id) REFERENCES crm_iap_lead_mining_request(id) ON DELETE SET NULL
 crm_lead_reveal_rule_id_fkey                                    | crm_lead                                                      | FOREIGN KEY (reveal_rule_id) REFERENCES crm_reveal_rule(id) ON DELETE SET NULL
 crm_lead_payment_terms_fkey                                     | crm_lead                                                      | FOREIGN KEY (payment_terms) REFERENCES account_payment_term(id) ON DELETE SET NULL
 crm_lead_dispatch_run_id_fkey                                   | crm_lead                                                      | FOREIGN KEY (dispatch_run_id) REFERENCES premafirm_dispatch_run(id) ON DELETE SET NULL
 crm_lead_product_id_fkey                                        | crm_lead                                                      | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE SET NULL
 crm_lead_company_currency_id_fkey                               | crm_lead                                                      | FOREIGN KEY (company_currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 crm_lead2opportunity_partner_write_uid_fkey                     | crm_lead2opportunity_partner                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_lead2opportunity_partner_create_uid_fkey                    | crm_lead2opportunity_partner                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_lead2opportunity_partner_team_id_fkey                       | crm_lead2opportunity_partner                                  | FOREIGN KEY (team_id) REFERENCES crm_team(id) ON DELETE SET NULL
 crm_lead2opportunity_partner_user_id_fkey                       | crm_lead2opportunity_partner                                  | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 crm_lead2opportunity_partner_partner_id_fkey                    | crm_lead2opportunity_partner                                  | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 crm_lead2opportunity_partner_lead_id_fkey                       | crm_lead2opportunity_partner                                  | FOREIGN KEY (lead_id) REFERENCES crm_lead(id) ON DELETE CASCADE
 crm_lead2opportunity_partner_pkey                               | crm_lead2opportunity_partner                                  | PRIMARY KEY (id)
 crm_lead2opportunity_partner_mass_write_uid_fkey                | crm_lead2opportunity_partner_mass                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_lead2opportunity_partner_mass_pkey                          | crm_lead2opportunity_partner_mass                             | PRIMARY KEY (id)
 crm_lead2opportunity_partner_mass_lead_id_fkey                  | crm_lead2opportunity_partner_mass                             | FOREIGN KEY (lead_id) REFERENCES crm_lead(id) ON DELETE SET NULL
 crm_lead2opportunity_partner_mass_partner_id_fkey               | crm_lead2opportunity_partner_mass                             | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 crm_lead2opportunity_partner_mass_user_id_fkey                  | crm_lead2opportunity_partner_mass                             | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 crm_lead2opportunity_partner_mass_team_id_fkey                  | crm_lead2opportunity_partner_mass                             | FOREIGN KEY (team_id) REFERENCES crm_team(id) ON DELETE SET NULL
 crm_lead2opportunity_partner_mass_create_uid_fkey               | crm_lead2opportunity_partner_mass                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_lead2opportunity_partner_mass_res_users_rel_pkey            | crm_lead2opportunity_partner_mass_res_users_rel               | PRIMARY KEY (crm_lead2opportunity_partner_mass_id, res_users_id)
 crm_lead2opportunity_partner__crm_lead2opportunity_partner_fkey | crm_lead2opportunity_partner_mass_res_users_rel               | FOREIGN KEY (crm_lead2opportunity_partner_mass_id) REFERENCES crm_lead2opportunity_partner_mass(id) ON DELETE CASCADE
 crm_lead2opportunity_partner_mass_res_users_r_res_users_id_fkey | crm_lead2opportunity_partner_mass_res_users_rel               | FOREIGN KEY (res_users_id) REFERENCES res_users(id) ON DELETE CASCADE
 crm_lead_convert2ticket_write_uid_fkey                          | crm_lead_convert2ticket                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_lead_convert2ticket_pkey                                    | crm_lead_convert2ticket                                       | PRIMARY KEY (id)
 crm_lead_convert2ticket_team_id_fkey                            | crm_lead_convert2ticket                                       | FOREIGN KEY (team_id) REFERENCES helpdesk_team(id) ON DELETE CASCADE
 crm_lead_convert2ticket_partner_id_fkey                         | crm_lead_convert2ticket                                       | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 crm_lead_convert2ticket_create_uid_fkey                         | crm_lead_convert2ticket                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_lead_convert2ticket_lead_id_fkey                            | crm_lead_convert2ticket                                       | FOREIGN KEY (lead_id) REFERENCES crm_lead(id) ON DELETE SET NULL
 crm_lead_crm_lead2opportunit_crm_lead2opportunity_partner_fkey1 | crm_lead_crm_lead2opportunity_partner_mass_rel                | FOREIGN KEY (crm_lead2opportunity_partner_mass_id) REFERENCES crm_lead2opportunity_partner_mass(id) ON DELETE CASCADE
 crm_lead_crm_lead2opportunity_partner_mass_rel_crm_lead_id_fkey | crm_lead_crm_lead2opportunity_partner_mass_rel                | FOREIGN KEY (crm_lead_id) REFERENCES crm_lead(id) ON DELETE CASCADE
 crm_lead_crm_lead2opportunity_partner_mass_rel_pkey             | crm_lead_crm_lead2opportunity_partner_mass_rel                | PRIMARY KEY (crm_lead2opportunity_partner_mass_id, crm_lead_id)
 crm_lead_crm_lead2opportunity_partner_rel_pkey                  | crm_lead_crm_lead2opportunity_partner_rel                     | PRIMARY KEY (crm_lead2opportunity_partner_id, crm_lead_id)
 crm_lead_crm_lead2opportunity_partner_rel_crm_lead_id_fkey      | crm_lead_crm_lead2opportunity_partner_rel                     | FOREIGN KEY (crm_lead_id) REFERENCES crm_lead(id) ON DELETE CASCADE
 crm_lead_crm_lead2opportunity_crm_lead2opportunity_partner_fkey | crm_lead_crm_lead2opportunity_partner_rel                     | FOREIGN KEY (crm_lead2opportunity_partner_id) REFERENCES crm_lead2opportunity_partner(id) ON DELETE CASCADE
 crm_lead_crm_lead_lost_rel_crm_lead_id_fkey                     | crm_lead_crm_lead_lost_rel                                    | FOREIGN KEY (crm_lead_id) REFERENCES crm_lead(id) ON DELETE CASCADE
 crm_lead_crm_lead_lost_rel_crm_lead_lost_id_fkey                | crm_lead_crm_lead_lost_rel                                    | FOREIGN KEY (crm_lead_lost_id) REFERENCES crm_lead_lost(id) ON DELETE CASCADE
 crm_lead_crm_lead_lost_rel_pkey                                 | crm_lead_crm_lead_lost_rel                                    | PRIMARY KEY (crm_lead_lost_id, crm_lead_id)
 crm_lead_lost_write_uid_fkey                                    | crm_lead_lost                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_lead_lost_pkey                                              | crm_lead_lost                                                 | PRIMARY KEY (id)
 crm_lead_lost_lost_reason_id_fkey                               | crm_lead_lost                                                 | FOREIGN KEY (lost_reason_id) REFERENCES crm_lost_reason(id) ON DELETE SET NULL
 crm_lead_lost_create_uid_fkey                                   | crm_lead_lost                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_lead_pls_update_pkey                                        | crm_lead_pls_update                                           | PRIMARY KEY (id)
 crm_lead_pls_update_write_uid_fkey                              | crm_lead_pls_update                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_lead_pls_update_create_uid_fkey                             | crm_lead_pls_update                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_lead_pls_update_crm_lead_scoring_frequency_field_rel_pkey   | crm_lead_pls_update_crm_lead_scoring_frequency_field_rel      | PRIMARY KEY (crm_lead_pls_update_id, crm_lead_scoring_frequency_field_id)
 crm_lead_pls_update_crm_lead__crm_lead_scoring_frequency_f_fkey | crm_lead_pls_update_crm_lead_scoring_frequency_field_rel      | FOREIGN KEY (crm_lead_scoring_frequency_field_id) REFERENCES crm_lead_scoring_frequency_field(id) ON DELETE CASCADE
 crm_lead_pls_update_crm_lead_scorin_crm_lead_pls_update_id_fkey | crm_lead_pls_update_crm_lead_scoring_frequency_field_rel      | FOREIGN KEY (crm_lead_pls_update_id) REFERENCES crm_lead_pls_update(id) ON DELETE CASCADE
 crm_lead_scoring_frequency_team_id_fkey                         | crm_lead_scoring_frequency                                    | FOREIGN KEY (team_id) REFERENCES crm_team(id) ON DELETE CASCADE
 crm_lead_scoring_frequency_pkey                                 | crm_lead_scoring_frequency                                    | PRIMARY KEY (id)
 crm_lead_scoring_frequency_write_uid_fkey                       | crm_lead_scoring_frequency                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_lead_scoring_frequency_create_uid_fkey                      | crm_lead_scoring_frequency                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_lead_scoring_frequency_field_pkey                           | crm_lead_scoring_frequency_field                              | PRIMARY KEY (id)
 crm_lead_scoring_frequency_field_field_id_fkey                  | crm_lead_scoring_frequency_field                              | FOREIGN KEY (field_id) REFERENCES ir_model_fields(id) ON DELETE CASCADE
 crm_lead_scoring_frequency_field_create_uid_fkey                | crm_lead_scoring_frequency_field                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_lead_scoring_frequency_field_write_uid_fkey                 | crm_lead_scoring_frequency_field                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_lead_website_visitor_rel_pkey                               | crm_lead_website_visitor_rel                                  | PRIMARY KEY (crm_lead_id, website_visitor_id)
 crm_lead_website_visitor_rel_website_visitor_id_fkey            | crm_lead_website_visitor_rel                                  | FOREIGN KEY (website_visitor_id) REFERENCES website_visitor(id) ON DELETE CASCADE
 crm_lead_website_visitor_rel_crm_lead_id_fkey                   | crm_lead_website_visitor_rel                                  | FOREIGN KEY (crm_lead_id) REFERENCES crm_lead(id) ON DELETE CASCADE
 crm_lost_reason_pkey                                            | crm_lost_reason                                               | PRIMARY KEY (id)
 crm_lost_reason_write_uid_fkey                                  | crm_lost_reason                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_lost_reason_create_uid_fkey                                 | crm_lost_reason                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_merge_opportunity_write_uid_fkey                            | crm_merge_opportunity                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_merge_opportunity_user_id_fkey                              | crm_merge_opportunity                                         | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 crm_merge_opportunity_pkey                                      | crm_merge_opportunity                                         | PRIMARY KEY (id)
 crm_merge_opportunity_team_id_fkey                              | crm_merge_opportunity                                         | FOREIGN KEY (team_id) REFERENCES crm_team(id) ON DELETE SET NULL
 crm_merge_opportunity_create_uid_fkey                           | crm_merge_opportunity                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_quotation_partner_write_uid_fkey                            | crm_quotation_partner                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_quotation_partner_pkey                                      | crm_quotation_partner                                         | PRIMARY KEY (id)
 crm_quotation_partner_lead_id_fkey                              | crm_quotation_partner                                         | FOREIGN KEY (lead_id) REFERENCES crm_lead(id) ON DELETE CASCADE
 crm_quotation_partner_partner_id_fkey                           | crm_quotation_partner                                         | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 crm_quotation_partner_create_uid_fkey                           | crm_quotation_partner                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_recurring_plan_check_number_of_months                       | crm_recurring_plan                                            | CHECK ((number_of_months >= 0))
 crm_recurring_plan_write_uid_fkey                               | crm_recurring_plan                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_recurring_plan_create_uid_fkey                              | crm_recurring_plan                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_recurring_plan_pkey                                         | crm_recurring_plan                                            | PRIMARY KEY (id)
 crm_reveal_rule_pkey                                            | crm_reveal_rule                                               | PRIMARY KEY (id)
 crm_reveal_rule_website_id_fkey                                 | crm_reveal_rule                                               | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE SET NULL
 crm_reveal_rule_seniority_id_fkey                               | crm_reveal_rule                                               | FOREIGN KEY (seniority_id) REFERENCES crm_iap_lead_seniority(id) ON DELETE SET NULL
 crm_reveal_rule_team_id_fkey                                    | crm_reveal_rule                                               | FOREIGN KEY (team_id) REFERENCES crm_team(id) ON DELETE SET NULL
 crm_reveal_rule_create_uid_fkey                                 | crm_reveal_rule                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_reveal_rule_write_uid_fkey                                  | crm_reveal_rule                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_reveal_rule_limit_extra_contacts                            | crm_reveal_rule                                               | CHECK (((extra_contacts >= 1) AND (extra_contacts <= 5)))
 crm_reveal_rule_user_id_fkey                                    | crm_reveal_rule                                               | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 crm_reveal_rule_preferred_role_id_fkey                          | crm_reveal_rule                                               | FOREIGN KEY (preferred_role_id) REFERENCES crm_iap_lead_role(id) ON DELETE SET NULL
 crm_reveal_rule_crm_tag_rel_crm_tag_id_fkey                     | crm_reveal_rule_crm_tag_rel                                   | FOREIGN KEY (crm_tag_id) REFERENCES crm_tag(id) ON DELETE CASCADE
 crm_reveal_rule_crm_tag_rel_pkey                                | crm_reveal_rule_crm_tag_rel                                   | PRIMARY KEY (crm_reveal_rule_id, crm_tag_id)
 crm_reveal_rule_crm_tag_rel_crm_reveal_rule_id_fkey             | crm_reveal_rule_crm_tag_rel                                   | FOREIGN KEY (crm_reveal_rule_id) REFERENCES crm_reveal_rule(id) ON DELETE CASCADE
 crm_reveal_rule_res_country_rel_res_country_id_fkey             | crm_reveal_rule_res_country_rel                               | FOREIGN KEY (res_country_id) REFERENCES res_country(id) ON DELETE CASCADE
 crm_reveal_rule_res_country_rel_pkey                            | crm_reveal_rule_res_country_rel                               | PRIMARY KEY (crm_reveal_rule_id, res_country_id)
 crm_reveal_rule_res_country_rel_crm_reveal_rule_id_fkey         | crm_reveal_rule_res_country_rel                               | FOREIGN KEY (crm_reveal_rule_id) REFERENCES crm_reveal_rule(id) ON DELETE CASCADE
 crm_reveal_rule_res_country_state_rel_res_country_state_id_fkey | crm_reveal_rule_res_country_state_rel                         | FOREIGN KEY (res_country_state_id) REFERENCES res_country_state(id) ON DELETE CASCADE
 crm_reveal_rule_res_country_state_rel_crm_reveal_rule_id_fkey   | crm_reveal_rule_res_country_state_rel                         | FOREIGN KEY (crm_reveal_rule_id) REFERENCES crm_reveal_rule(id) ON DELETE CASCADE
 crm_reveal_rule_res_country_state_rel_pkey                      | crm_reveal_rule_res_country_state_rel                         | PRIMARY KEY (crm_reveal_rule_id, res_country_state_id)
 crm_reveal_view_pkey                                            | crm_reveal_view                                               | PRIMARY KEY (id)
 crm_reveal_view_write_uid_fkey                                  | crm_reveal_view                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_reveal_view_create_uid_fkey                                 | crm_reveal_view                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_reveal_view_reveal_rule_id_fkey                             | crm_reveal_view                                               | FOREIGN KEY (reveal_rule_id) REFERENCES crm_reveal_rule(id) ON DELETE SET NULL
 crm_stage_write_uid_fkey                                        | crm_stage                                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_stage_pkey                                                  | crm_stage                                                     | PRIMARY KEY (id)
 crm_stage_create_uid_fkey                                       | crm_stage                                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_stage_team_id_fkey                                          | crm_stage                                                     | FOREIGN KEY (team_id) REFERENCES crm_team(id) ON DELETE SET NULL
 crm_tag_write_uid_fkey                                          | crm_tag                                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_tag_pkey                                                    | crm_tag                                                       | PRIMARY KEY (id)
 crm_tag_name_uniq                                               | crm_tag                                                       | UNIQUE (name)
 crm_tag_create_uid_fkey                                         | crm_tag                                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_tag_rel_lead_id_fkey                                        | crm_tag_rel                                                   | FOREIGN KEY (lead_id) REFERENCES crm_lead(id) ON DELETE CASCADE
 crm_tag_rel_tag_id_fkey                                         | crm_tag_rel                                                   | FOREIGN KEY (tag_id) REFERENCES crm_tag(id) ON DELETE CASCADE
 crm_tag_rel_pkey                                                | crm_tag_rel                                                   | PRIMARY KEY (lead_id, tag_id)
 crm_team_write_uid_fkey                                         | crm_team                                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_team_pkey                                                   | crm_team                                                      | PRIMARY KEY (id)
 crm_team_user_id_fkey                                           | crm_team                                                      | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 crm_team_company_id_fkey                                        | crm_team                                                      | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 crm_team_create_uid_fkey                                        | crm_team                                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_team_alias_id_fkey                                          | crm_team                                                      | FOREIGN KEY (alias_id) REFERENCES mail_alias(id) ON DELETE RESTRICT
 crm_team_member_write_uid_fkey                                  | crm_team_member                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_team_member_crm_team_id_fkey                                | crm_team_member                                               | FOREIGN KEY (crm_team_id) REFERENCES crm_team(id) ON DELETE CASCADE
 crm_team_member_user_id_fkey                                    | crm_team_member                                               | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 crm_team_member_create_uid_fkey                                 | crm_team_member                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 crm_team_member_pkey                                            | crm_team_member                                               | PRIMARY KEY (id)
 db_backup_configure_create_uid_fkey                             | db_backup_configure                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 db_backup_configure_pkey                                        | db_backup_configure                                           | PRIMARY KEY (id)
 db_backup_configure_user_id_fkey                                | db_backup_configure                                           | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 db_backup_configure_write_uid_fkey                              | db_backup_configure                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 db_backup_log_create_uid_fkey                                   | db_backup_log                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 db_backup_log_db_config_id_fkey                                 | db_backup_log                                                 | FOREIGN KEY (db_config_id) REFERENCES db_backup_configure(id) ON DELETE SET NULL
 db_backup_log_pkey                                              | db_backup_log                                                 | PRIMARY KEY (id)
 db_backup_log_write_uid_fkey                                    | db_backup_log                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 decimal_precision_create_uid_fkey                               | decimal_precision                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 decimal_precision_pkey                                          | decimal_precision                                             | PRIMARY KEY (id)
 decimal_precision_name_uniq                                     | decimal_precision                                             | UNIQUE (name)
 decimal_precision_write_uid_fkey                                | decimal_precision                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 digest_digest_pkey                                              | digest_digest                                                 | PRIMARY KEY (id)
 digest_digest_write_uid_fkey                                    | digest_digest                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 digest_digest_create_uid_fkey                                   | digest_digest                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 digest_digest_company_id_fkey                                   | digest_digest                                                 | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 digest_digest_res_users_rel_digest_digest_id_fkey               | digest_digest_res_users_rel                                   | FOREIGN KEY (digest_digest_id) REFERENCES digest_digest(id) ON DELETE CASCADE
 digest_digest_res_users_rel_pkey                                | digest_digest_res_users_rel                                   | PRIMARY KEY (digest_digest_id, res_users_id)
 digest_digest_res_users_rel_res_users_id_fkey                   | digest_digest_res_users_rel                                   | FOREIGN KEY (res_users_id) REFERENCES res_users(id) ON DELETE CASCADE
 digest_tip_create_uid_fkey                                      | digest_tip                                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 digest_tip_pkey                                                 | digest_tip                                                    | PRIMARY KEY (id)
 digest_tip_group_id_fkey                                        | digest_tip                                                    | FOREIGN KEY (group_id) REFERENCES res_groups(id) ON DELETE SET NULL
 digest_tip_write_uid_fkey                                       | digest_tip                                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 digest_tip_res_users_rel_pkey                                   | digest_tip_res_users_rel                                      | PRIMARY KEY (digest_tip_id, res_users_id)
 digest_tip_res_users_rel_digest_tip_id_fkey                     | digest_tip_res_users_rel                                      | FOREIGN KEY (digest_tip_id) REFERENCES digest_tip(id) ON DELETE CASCADE
 digest_tip_res_users_rel_res_users_id_fkey                      | digest_tip_res_users_rel                                      | FOREIGN KEY (res_users_id) REFERENCES res_users(id) ON DELETE CASCADE
 discuss_channel_whatsapp_partner_id_fkey                        | discuss_channel                                               | FOREIGN KEY (whatsapp_partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 discuss_channel_wa_account_id_fkey                              | discuss_channel                                               | FOREIGN KEY (wa_account_id) REFERENCES whatsapp_account(id) ON DELETE SET NULL
 discuss_channel_group_public_id_fkey                            | discuss_channel                                               | FOREIGN KEY (group_public_id) REFERENCES res_groups(id) ON DELETE SET NULL
 discuss_channel_from_message_id_fkey                            | discuss_channel                                               | FOREIGN KEY (from_message_id) REFERENCES mail_message(id) ON DELETE SET NULL
 discuss_channel_parent_channel_id_fkey                          | discuss_channel                                               | FOREIGN KEY (parent_channel_id) REFERENCES discuss_channel(id) ON DELETE CASCADE
 discuss_channel_channel_type_not_null                           | discuss_channel                                               | CHECK ((channel_type IS NOT NULL))
 discuss_channel_from_message_id_unique                          | discuss_channel                                               | UNIQUE (from_message_id)
 discuss_channel_sub_channel_no_group_public_id                  | discuss_channel                                               | CHECK (((parent_channel_id IS NULL) OR (group_public_id IS NULL)))
 discuss_channel_uuid_unique                                     | discuss_channel                                               | UNIQUE (uuid)
 discuss_channel_write_uid_fkey                                  | discuss_channel                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 discuss_channel_create_uid_fkey                                 | discuss_channel                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 discuss_channel_pkey                                            | discuss_channel                                               | PRIMARY KEY (id)
 discuss_channel_group_public_id_check                           | discuss_channel                                               | CHECK ((((channel_type)::text = 'channel'::text) OR ((channel_type)::text = 'whatsapp'::text) OR (group_public_id IS NULL)))
 discuss_channel_last_wa_mail_message_id_fkey                    | discuss_channel                                               | FOREIGN KEY (last_wa_mail_message_id) REFERENCES mail_message(id) ON DELETE SET NULL
 discuss_channel_hr_department_rel_hr_department_id_fkey         | discuss_channel_hr_department_rel                             | FOREIGN KEY (hr_department_id) REFERENCES hr_department(id) ON DELETE CASCADE
 discuss_channel_hr_department_rel_discuss_channel_id_fkey       | discuss_channel_hr_department_rel                             | FOREIGN KEY (discuss_channel_id) REFERENCES discuss_channel(id) ON DELETE CASCADE
 discuss_channel_hr_department_rel_pkey                          | discuss_channel_hr_department_rel                             | PRIMARY KEY (discuss_channel_id, hr_department_id)
 discuss_channel_member_rtc_inviting_session_id_fkey             | discuss_channel_member                                        | FOREIGN KEY (rtc_inviting_session_id) REFERENCES discuss_channel_rtc_session(id) ON DELETE SET NULL
 discuss_channel_member_seen_message_id_fkey                     | discuss_channel_member                                        | FOREIGN KEY (seen_message_id) REFERENCES mail_message(id) ON DELETE SET NULL
 discuss_channel_member_fetched_message_id_fkey                  | discuss_channel_member                                        | FOREIGN KEY (fetched_message_id) REFERENCES mail_message(id) ON DELETE SET NULL
 discuss_channel_member_channel_id_fkey                          | discuss_channel_member                                        | FOREIGN KEY (channel_id) REFERENCES discuss_channel(id) ON DELETE CASCADE
 discuss_channel_member_pkey                                     | discuss_channel_member                                        | PRIMARY KEY (id)
 discuss_channel_member_partner_or_guest_exists                  | discuss_channel_member                                        | CHECK ((((partner_id IS NOT NULL) AND (guest_id IS NULL)) OR ((partner_id IS NULL) AND (guest_id IS NOT NULL))))
 discuss_channel_member_guest_id_fkey                            | discuss_channel_member                                        | FOREIGN KEY (guest_id) REFERENCES mail_guest(id) ON DELETE CASCADE
 discuss_channel_member_partner_id_fkey                          | discuss_channel_member                                        | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 discuss_channel_member_write_uid_fkey                           | discuss_channel_member                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 discuss_channel_member_create_uid_fkey                          | discuss_channel_member                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 discuss_channel_res_groups_rel_pkey                             | discuss_channel_res_groups_rel                                | PRIMARY KEY (discuss_channel_id, res_groups_id)
 discuss_channel_res_groups_rel_res_groups_id_fkey               | discuss_channel_res_groups_rel                                | FOREIGN KEY (res_groups_id) REFERENCES res_groups(id) ON DELETE CASCADE
 discuss_channel_res_groups_rel_discuss_channel_id_fkey          | discuss_channel_res_groups_rel                                | FOREIGN KEY (discuss_channel_id) REFERENCES discuss_channel(id) ON DELETE CASCADE
 discuss_channel_rtc_session_channel_member_id_fkey              | discuss_channel_rtc_session                                   | FOREIGN KEY (channel_member_id) REFERENCES discuss_channel_member(id) ON DELETE CASCADE
 discuss_channel_rtc_session_channel_member_unique               | discuss_channel_rtc_session                                   | UNIQUE (channel_member_id)
 discuss_channel_rtc_session_pkey                                | discuss_channel_rtc_session                                   | PRIMARY KEY (id)
 discuss_channel_rtc_session_write_uid_fkey                      | discuss_channel_rtc_session                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 discuss_channel_rtc_session_create_uid_fkey                     | discuss_channel_rtc_session                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 discuss_channel_rtc_session_channel_id_fkey                     | discuss_channel_rtc_session                                   | FOREIGN KEY (channel_id) REFERENCES discuss_channel(id) ON DELETE SET NULL
 discuss_gif_favorite_user_gif_favorite                          | discuss_gif_favorite                                          | UNIQUE (create_uid, tenor_gif_id)
 discuss_gif_favorite_write_uid_fkey                             | discuss_gif_favorite                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 discuss_gif_favorite_create_uid_fkey                            | discuss_gif_favorite                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 discuss_gif_favorite_pkey                                       | discuss_gif_favorite                                          | PRIMARY KEY (id)
 discuss_voice_metadata_attachment_id_fkey                       | discuss_voice_metadata                                        | FOREIGN KEY (attachment_id) REFERENCES ir_attachment(id) ON DELETE CASCADE
 discuss_voice_metadata_pkey                                     | discuss_voice_metadata                                        | PRIMARY KEY (id)
 discuss_voice_metadata_write_uid_fkey                           | discuss_voice_metadata                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 discuss_voice_metadata_create_uid_fkey                          | discuss_voice_metadata                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 dms_acc_rep_export_wizard_fo_account_reports_export_wizar_fkey1 | dms_acc_rep_export_wizard_format_rel                          | FOREIGN KEY (account_reports_export_wizard_format_id) REFERENCES account_reports_export_wizard_format(id) ON DELETE CASCADE
 dms_acc_rep_export_wizard_format_rel_pkey                       | dms_acc_rep_export_wizard_format_rel                          | PRIMARY KEY (account_reports_export_wizard_id, account_reports_export_wizard_format_id)
 dms_acc_rep_export_wizard_for_account_reports_export_wizar_fkey | dms_acc_rep_export_wizard_format_rel                          | FOREIGN KEY (account_reports_export_wizard_id) REFERENCES account_reports_export_wizard(id) ON DELETE CASCADE
 document_alias_tag_rel_documents_document_id_fkey               | document_alias_tag_rel                                        | FOREIGN KEY (documents_document_id) REFERENCES documents_document(id) ON DELETE CASCADE
 document_alias_tag_rel_pkey                                     | document_alias_tag_rel                                        | PRIMARY KEY (documents_document_id, documents_tag_id)
 document_alias_tag_rel_documents_tag_id_fkey                    | document_alias_tag_rel                                        | FOREIGN KEY (documents_tag_id) REFERENCES documents_tag(id) ON DELETE CASCADE
 document_tag_rel_documents_tag_id_fkey                          | document_tag_rel                                              | FOREIGN KEY (documents_tag_id) REFERENCES documents_tag(id) ON DELETE CASCADE
 document_tag_rel_pkey                                           | document_tag_rel                                              | PRIMARY KEY (documents_document_id, documents_tag_id)
 document_tag_rel_documents_document_id_fkey                     | document_tag_rel                                              | FOREIGN KEY (documents_document_id) REFERENCES documents_document(id) ON DELETE CASCADE
 documents_access_document_id_fkey                               | documents_access                                              | FOREIGN KEY (document_id) REFERENCES documents_document(id) ON DELETE CASCADE
 documents_access_role_or_last_access_date                       | documents_access                                              | CHECK (((role IS NOT NULL) OR (last_access_date IS NOT NULL)))
 documents_access_unique_document_access_partner                 | documents_access                                              | UNIQUE (document_id, partner_id)
 documents_access_pkey                                           | documents_access                                              | PRIMARY KEY (id)
 documents_access_partner_id_fkey                                | documents_access                                              | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 documents_account_folder_setting_company_id_fkey                | documents_account_folder_setting                              | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE CASCADE
 documents_account_folder_setting_folder_id_fkey                 | documents_account_folder_setting                              | FOREIGN KEY (folder_id) REFERENCES documents_document(id) ON DELETE RESTRICT
 documents_account_folder_setting_write_uid_fkey                 | documents_account_folder_setting                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 documents_account_folder_setting_journal_id_fkey                | documents_account_folder_setting                              | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE RESTRICT
 documents_account_folder_setting_journal_unique                 | documents_account_folder_setting                              | UNIQUE (journal_id)
 documents_account_folder_setting_pkey                           | documents_account_folder_setting                              | PRIMARY KEY (id)
 documents_account_folder_setting_create_uid_fkey                | documents_account_folder_setting                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 documents_account_folder_setting_document_documents_tag_id_fkey | documents_account_folder_setting_documents_tag_rel            | FOREIGN KEY (documents_tag_id) REFERENCES documents_tag(id) ON DELETE CASCADE
 documents_account_folder_setting_documents_tag_rel_pkey         | documents_account_folder_setting_documents_tag_rel            | PRIMARY KEY (documents_account_folder_setting_id, documents_tag_id)
 documents_account_folder_sett_documents_account_folder_set_fkey | documents_account_folder_setting_documents_tag_rel            | FOREIGN KEY (documents_account_folder_setting_id) REFERENCES documents_account_folder_setting(id) ON DELETE CASCADE
 documents_document_alias_id_fkey                                | documents_document                                            | FOREIGN KEY (alias_id) REFERENCES mail_alias(id) ON DELETE RESTRICT
 documents_document_write_uid_fkey                               | documents_document                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 documents_document_create_uid_fkey                              | documents_document                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 documents_document_create_activity_user_id_fkey                 | documents_document                                            | FOREIGN KEY (create_activity_user_id) REFERENCES res_users(id) ON DELETE SET NULL
 documents_document_create_activity_type_id_fkey                 | documents_document                                            | FOREIGN KEY (create_activity_type_id) REFERENCES mail_activity_type(id) ON DELETE SET NULL
 documents_document_company_id_fkey                              | documents_document                                            | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 documents_document_folder_id_fkey                               | documents_document                                            | FOREIGN KEY (folder_id) REFERENCES documents_document(id) ON DELETE SET NULL
 documents_document_requestee_partner_id_fkey                    | documents_document                                            | FOREIGN KEY (requestee_partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 documents_document_request_activity_id_fkey                     | documents_document                                            | FOREIGN KEY (request_activity_id) REFERENCES mail_activity(id) ON DELETE SET NULL
 documents_document_lock_uid_fkey                                | documents_document                                            | FOREIGN KEY (lock_uid) REFERENCES res_users(id) ON DELETE SET NULL
 documents_document_owner_id_fkey                                | documents_document                                            | FOREIGN KEY (owner_id) REFERENCES res_users(id) ON DELETE RESTRICT
 documents_document_partner_id_fkey                              | documents_document                                            | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 documents_document_shortcut_document_id_fkey                    | documents_document                                            | FOREIGN KEY (shortcut_document_id) REFERENCES documents_document(id) ON DELETE CASCADE
 documents_document_attachment_id_fkey                           | documents_document                                            | FOREIGN KEY (attachment_id) REFERENCES ir_attachment(id) ON DELETE CASCADE
 documents_document_shortcut_document_id_not_id                  | documents_document                                            | CHECK ((shortcut_document_id <> id))
 documents_document_folder_id_not_id                             | documents_document                                            | CHECK ((folder_id <> id))
 documents_document_document_token_unique                        | documents_document                                            | UNIQUE (document_token)
 documents_document_attachment_unique                            | documents_document                                            | UNIQUE (attachment_id)
 documents_document_pkey                                         | documents_document                                            | PRIMARY KEY (id)
 documents_document_spreadsheet_access_via_link                  | documents_document                                            | CHECK ((((handler)::text <> 'spreadsheet'::text) OR ((access_via_link)::text <> 'edit'::text)))
 documents_document_frozen_spreadsheet_access_via_link__52cdd6ea | documents_document                                            | CHECK ((((handler)::text <> 'frozen_spreadsheet'::text) OR (((access_via_link)::text <> 'edit'::text) AND ((access_internal)::text <> 'edit'::text))))
 documents_document_website_id_fkey                              | documents_document                                            | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE SET NULL
 documents_document_documents__documents_link_to_record_wiz_fkey | documents_document_documents_link_to_record_wizard_rel        | FOREIGN KEY (documents_link_to_record_wizard_id) REFERENCES documents_link_to_record_wizard(id) ON DELETE CASCADE
 documents_document_documents_link_to_record_wizard_rel_pkey     | documents_document_documents_link_to_record_wizard_rel        | PRIMARY KEY (documents_link_to_record_wizard_id, documents_document_id)
 documents_document_documents_link_to_documents_document_id_fkey | documents_document_documents_link_to_record_wizard_rel        | FOREIGN KEY (documents_document_id) REFERENCES documents_document(id) ON DELETE CASCADE
 documents_document_ir_attachment_rel_pkey                       | documents_document_ir_attachment_rel                          | PRIMARY KEY (documents_document_id, ir_attachment_id)
 documents_document_ir_attachment_rel_ir_attachment_id_fkey      | documents_document_ir_attachment_rel                          | FOREIGN KEY (ir_attachment_id) REFERENCES ir_attachment(id) ON DELETE CASCADE
 documents_document_ir_attachment_rel_documents_document_id_fkey | documents_document_ir_attachment_rel                          | FOREIGN KEY (documents_document_id) REFERENCES documents_document(id) ON DELETE CASCADE
 documents_document_res_users_rel_pkey                           | documents_document_res_users_rel                              | PRIMARY KEY (documents_document_id, res_users_id)
 documents_document_res_users_rel_documents_document_id_fkey     | documents_document_res_users_rel                              | FOREIGN KEY (documents_document_id) REFERENCES documents_document(id) ON DELETE CASCADE
 documents_document_res_users_rel_res_users_id_fkey              | documents_document_res_users_rel                              | FOREIGN KEY (res_users_id) REFERENCES res_users(id) ON DELETE CASCADE
 documents_fleet_tags_table_res_company_id_fkey                  | documents_fleet_tags_table                                    | FOREIGN KEY (res_company_id) REFERENCES res_company(id) ON DELETE CASCADE
 documents_fleet_tags_table_documents_tag_id_fkey                | documents_fleet_tags_table                                    | FOREIGN KEY (documents_tag_id) REFERENCES documents_tag(id) ON DELETE CASCADE
 documents_fleet_tags_table_pkey                                 | documents_fleet_tags_table                                    | PRIMARY KEY (res_company_id, documents_tag_id)
 documents_hr_contracts_tags_table_res_company_id_fkey           | documents_hr_contracts_tags_table                             | FOREIGN KEY (res_company_id) REFERENCES res_company(id) ON DELETE CASCADE
 documents_hr_contracts_tags_table_pkey                          | documents_hr_contracts_tags_table                             | PRIMARY KEY (res_company_id, documents_tag_id)
 documents_hr_contracts_tags_table_documents_tag_id_fkey         | documents_hr_contracts_tags_table                             | FOREIGN KEY (documents_tag_id) REFERENCES documents_tag(id) ON DELETE CASCADE
 documents_link_to_record_wizard_write_uid_fkey                  | documents_link_to_record_wizard                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 documents_link_to_record_wizard_model_id_fkey                   | documents_link_to_record_wizard                               | FOREIGN KEY (model_id) REFERENCES ir_model(id) ON DELETE SET NULL
 documents_link_to_record_wizard_create_uid_fkey                 | documents_link_to_record_wizard                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 documents_link_to_record_wizard_pkey                            | documents_link_to_record_wizard                               | PRIMARY KEY (id)
 documents_redirect_document_id_fkey                             | documents_redirect                                            | FOREIGN KEY (document_id) REFERENCES documents_document(id) ON DELETE CASCADE
 documents_redirect_employee_id_fkey                             | documents_redirect                                            | FOREIGN KEY (employee_id) REFERENCES hr_employee(id) ON DELETE SET NULL
 documents_redirect_pkey                                         | documents_redirect                                            | PRIMARY KEY (id)
 documents_request_wizard_write_uid_fkey                         | documents_request_wizard                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 documents_request_wizard_create_uid_fkey                        | documents_request_wizard                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 documents_request_wizard_folder_id_fkey                         | documents_request_wizard                                      | FOREIGN KEY (folder_id) REFERENCES documents_document(id) ON DELETE SET NULL
 documents_request_wizard_activity_type_id_fkey                  | documents_request_wizard                                      | FOREIGN KEY (activity_type_id) REFERENCES mail_activity_type(id) ON DELETE CASCADE
 documents_request_wizard_partner_id_fkey                        | documents_request_wizard                                      | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 documents_request_wizard_requestee_id_fkey                      | documents_request_wizard                                      | FOREIGN KEY (requestee_id) REFERENCES res_partner(id) ON DELETE CASCADE
 documents_request_wizard_pkey                                   | documents_request_wizard                                      | PRIMARY KEY (id)
 documents_request_wizard_docum_documents_request_wizard_id_fkey | documents_request_wizard_documents_tag_rel                    | FOREIGN KEY (documents_request_wizard_id) REFERENCES documents_request_wizard(id) ON DELETE CASCADE
 documents_request_wizard_documents_tag_re_documents_tag_id_fkey | documents_request_wizard_documents_tag_rel                    | FOREIGN KEY (documents_tag_id) REFERENCES documents_tag(id) ON DELETE CASCADE
 documents_request_wizard_documents_tag_rel_pkey                 | documents_request_wizard_documents_tag_rel                    | PRIMARY KEY (documents_request_wizard_id, documents_tag_id)
 documents_tag_tag_name_unique                                   | documents_tag                                                 | UNIQUE (name)
 documents_tag_write_uid_fkey                                    | documents_tag                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 documents_tag_create_uid_fkey                                   | documents_tag                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 documents_tag_pkey                                              | documents_tag                                                 | PRIMARY KEY (id)
 documents_tag_mail_activity_type_rel_pkey                       | documents_tag_mail_activity_type_rel                          | PRIMARY KEY (mail_activity_type_id, documents_tag_id)
 documents_tag_mail_activity_type_rel_mail_activity_type_id_fkey | documents_tag_mail_activity_type_rel                          | FOREIGN KEY (mail_activity_type_id) REFERENCES mail_activity_type(id) ON DELETE CASCADE
 documents_tag_mail_activity_type_rel_documents_tag_id_fkey      | documents_tag_mail_activity_type_rel                          | FOREIGN KEY (documents_tag_id) REFERENCES documents_tag(id) ON DELETE CASCADE
 dropbox_auth_code_pkey                                          | dropbox_auth_code                                             | PRIMARY KEY (id)
 dropbox_auth_code_create_uid_fkey                               | dropbox_auth_code                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 dropbox_auth_code_write_uid_fkey                                | dropbox_auth_code                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 email_template_attachment_rel_email_template_id_fkey            | email_template_attachment_rel                                 | FOREIGN KEY (email_template_id) REFERENCES mail_template(id) ON DELETE CASCADE
 email_template_attachment_rel_pkey                              | email_template_attachment_rel                                 | PRIMARY KEY (email_template_id, attachment_id)
 email_template_attachment_rel_attachment_id_fkey                | email_template_attachment_rel                                 | FOREIGN KEY (attachment_id) REFERENCES ir_attachment(id) ON DELETE CASCADE
 employee_category_rel_category_id_fkey                          | employee_category_rel                                         | FOREIGN KEY (category_id) REFERENCES hr_employee_category(id) ON DELETE CASCADE
 employee_category_rel_pkey                                      | employee_category_rel                                         | PRIMARY KEY (employee_id, category_id)
 employee_category_rel_employee_id_fkey                          | employee_category_rel                                         | FOREIGN KEY (employee_id) REFERENCES hr_employee(id) ON DELETE CASCADE
 expense_sample_receipt_create_uid_fkey                          | expense_sample_receipt                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 expense_sample_receipt_write_uid_fkey                           | expense_sample_receipt                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 expense_sample_receipt_pkey                                     | expense_sample_receipt                                        | PRIMARY KEY (id)
 expense_sample_register_write_uid_fkey                          | expense_sample_register                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 expense_sample_register_payment_method_line_id_fkey             | expense_sample_register                                       | FOREIGN KEY (payment_method_line_id) REFERENCES account_payment_method_line(id) ON DELETE SET NULL
 expense_sample_register_pkey                                    | expense_sample_register                                       | PRIMARY KEY (id)
 expense_sample_register_journal_id_fkey                         | expense_sample_register                                       | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 expense_sample_register_sheet_id_fkey                           | expense_sample_register                                       | FOREIGN KEY (sheet_id) REFERENCES hr_expense_sheet(id) ON DELETE SET NULL
 expense_sample_register_create_uid_fkey                         | expense_sample_register                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 expense_tax_tax_id_fkey                                         | expense_tax                                                   | FOREIGN KEY (tax_id) REFERENCES account_tax(id) ON DELETE CASCADE
 expense_tax_expense_id_fkey                                     | expense_tax                                                   | FOREIGN KEY (expense_id) REFERENCES hr_expense(id) ON DELETE CASCADE
 expense_tax_pkey                                                | expense_tax                                                   | PRIMARY KEY (expense_id, tax_id)
 export_wiz_document_tag_rel_pkey                                | export_wiz_document_tag_rel                                   | PRIMARY KEY (account_reports_export_wizard_id, documents_tag_id)
 export_wiz_document_tag_rel_documents_tag_id_fkey               | export_wiz_document_tag_rel                                   | FOREIGN KEY (documents_tag_id) REFERENCES documents_tag(id) ON DELETE CASCADE
 export_wiz_document_tag_rel_account_reports_export_wizard__fkey | export_wiz_document_tag_rel                                   | FOREIGN KEY (account_reports_export_wizard_id) REFERENCES account_reports_export_wizard(id) ON DELETE CASCADE
 fetchmail_server_create_uid_fkey                                | fetchmail_server                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fetchmail_server_pkey                                           | fetchmail_server                                              | PRIMARY KEY (id)
 fetchmail_server_object_id_fkey                                 | fetchmail_server                                              | FOREIGN KEY (object_id) REFERENCES ir_model(id) ON DELETE SET NULL
 fetchmail_server_write_uid_fkey                                 | fetchmail_server                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_disallowed_expenses_rate_create_uid_fkey                  | fleet_disallowed_expenses_rate                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_disallowed_expenses_rate_write_uid_fkey                   | fleet_disallowed_expenses_rate                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_disallowed_expenses_rate_pkey                             | fleet_disallowed_expenses_rate                                | PRIMARY KEY (id)
 fleet_disallowed_expenses_rate_vehicle_id_fkey                  | fleet_disallowed_expenses_rate                                | FOREIGN KEY (vehicle_id) REFERENCES fleet_vehicle(id) ON DELETE RESTRICT
 fleet_service_type_write_uid_fkey                               | fleet_service_type                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_service_type_pkey                                         | fleet_service_type                                            | PRIMARY KEY (id)
 fleet_service_type_create_uid_fkey                              | fleet_service_type                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_service_type_fleet_vehicle_log_contract_rel_pkey          | fleet_service_type_fleet_vehicle_log_contract_rel             | PRIMARY KEY (fleet_vehicle_log_contract_id, fleet_service_type_id)
 fleet_service_type_fleet_vehicle_log_fleet_service_type_id_fkey | fleet_service_type_fleet_vehicle_log_contract_rel             | FOREIGN KEY (fleet_service_type_id) REFERENCES fleet_service_type(id) ON DELETE CASCADE
 fleet_service_type_fleet_vehi_fleet_vehicle_log_contract_i_fkey | fleet_service_type_fleet_vehicle_log_contract_rel             | FOREIGN KEY (fleet_vehicle_log_contract_id) REFERENCES fleet_vehicle_log_contract(id) ON DELETE CASCADE
 fleet_vehicle_brand_id_fkey                                     | fleet_vehicle                                                 | FOREIGN KEY (brand_id) REFERENCES fleet_vehicle_model_brand(id) ON DELETE SET NULL
 fleet_vehicle_state_id_fkey                                     | fleet_vehicle                                                 | FOREIGN KEY (state_id) REFERENCES fleet_vehicle_state(id) ON DELETE SET NULL
 fleet_vehicle_category_id_fkey                                  | fleet_vehicle                                                 | FOREIGN KEY (category_id) REFERENCES fleet_vehicle_model_category(id) ON DELETE SET NULL
 fleet_vehicle_create_uid_fkey                                   | fleet_vehicle                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_write_uid_fkey                                    | fleet_vehicle                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_manager_id_fkey                                   | fleet_vehicle                                                 | FOREIGN KEY (manager_id) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_company_id_fkey                                   | fleet_vehicle                                                 | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 fleet_vehicle_driver_id_fkey                                    | fleet_vehicle                                                 | FOREIGN KEY (driver_id) REFERENCES res_partner(id) ON DELETE SET NULL
 fleet_vehicle_future_driver_id_fkey                             | fleet_vehicle                                                 | FOREIGN KEY (future_driver_id) REFERENCES res_partner(id) ON DELETE SET NULL
 fleet_vehicle_model_id_fkey                                     | fleet_vehicle                                                 | FOREIGN KEY (model_id) REFERENCES fleet_vehicle_model(id) ON DELETE RESTRICT
 fleet_vehicle_pkey                                              | fleet_vehicle                                                 | PRIMARY KEY (id)
 fleet_vehicle_driver_employee_id_fkey                           | fleet_vehicle                                                 | FOREIGN KEY (driver_employee_id) REFERENCES hr_employee(id) ON DELETE SET NULL
 fleet_vehicle_future_driver_employee_id_fkey                    | fleet_vehicle                                                 | FOREIGN KEY (future_driver_employee_id) REFERENCES hr_employee(id) ON DELETE SET NULL
 fleet_vehicle_assignation_log_write_uid_fkey                    | fleet_vehicle_assignation_log                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_assignation_log_vehicle_id_fkey                   | fleet_vehicle_assignation_log                                 | FOREIGN KEY (vehicle_id) REFERENCES fleet_vehicle(id) ON DELETE RESTRICT
 fleet_vehicle_assignation_log_driver_employee_id_fkey           | fleet_vehicle_assignation_log                                 | FOREIGN KEY (driver_employee_id) REFERENCES hr_employee(id) ON DELETE SET NULL
 fleet_vehicle_assignation_log_pkey                              | fleet_vehicle_assignation_log                                 | PRIMARY KEY (id)
 fleet_vehicle_assignation_log_driver_id_fkey                    | fleet_vehicle_assignation_log                                 | FOREIGN KEY (driver_id) REFERENCES res_partner(id) ON DELETE RESTRICT
 fleet_vehicle_assignation_log_create_uid_fkey                   | fleet_vehicle_assignation_log                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_fleet_vehicle_send_mail_rel_fleet_vehicle_id_fkey | fleet_vehicle_fleet_vehicle_send_mail_rel                     | FOREIGN KEY (fleet_vehicle_id) REFERENCES fleet_vehicle(id) ON DELETE CASCADE
 fleet_vehicle_fleet_vehicle_sen_fleet_vehicle_send_mail_id_fkey | fleet_vehicle_fleet_vehicle_send_mail_rel                     | FOREIGN KEY (fleet_vehicle_send_mail_id) REFERENCES fleet_vehicle_send_mail(id) ON DELETE CASCADE
 fleet_vehicle_fleet_vehicle_send_mail_rel_pkey                  | fleet_vehicle_fleet_vehicle_send_mail_rel                     | PRIMARY KEY (fleet_vehicle_send_mail_id, fleet_vehicle_id)
 fleet_vehicle_log_contract_write_uid_fkey                       | fleet_vehicle_log_contract                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_log_contract_pkey                                 | fleet_vehicle_log_contract                                    | PRIMARY KEY (id)
 fleet_vehicle_log_contract_vehicle_id_fkey                      | fleet_vehicle_log_contract                                    | FOREIGN KEY (vehicle_id) REFERENCES fleet_vehicle(id) ON DELETE RESTRICT
 fleet_vehicle_log_contract_cost_subtype_id_fkey                 | fleet_vehicle_log_contract                                    | FOREIGN KEY (cost_subtype_id) REFERENCES fleet_service_type(id) ON DELETE SET NULL
 fleet_vehicle_log_contract_user_id_fkey                         | fleet_vehicle_log_contract                                    | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_log_contract_company_id_fkey                      | fleet_vehicle_log_contract                                    | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 fleet_vehicle_log_contract_insurer_id_fkey                      | fleet_vehicle_log_contract                                    | FOREIGN KEY (insurer_id) REFERENCES res_partner(id) ON DELETE SET NULL
 fleet_vehicle_log_contract_create_uid_fkey                      | fleet_vehicle_log_contract                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_log_services_purchaser_id_fkey                    | fleet_vehicle_log_services                                    | FOREIGN KEY (purchaser_id) REFERENCES res_partner(id) ON DELETE SET NULL
 fleet_vehicle_log_services_pkey                                 | fleet_vehicle_log_services                                    | PRIMARY KEY (id)
 fleet_vehicle_log_services_purchaser_employee_id_fkey           | fleet_vehicle_log_services                                    | FOREIGN KEY (purchaser_employee_id) REFERENCES hr_employee(id) ON DELETE SET NULL
 fleet_vehicle_log_services_account_move_line_id_fkey            | fleet_vehicle_log_services                                    | FOREIGN KEY (account_move_line_id) REFERENCES account_move_line(id) ON DELETE SET NULL
 fleet_vehicle_log_services_write_uid_fkey                       | fleet_vehicle_log_services                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_log_services_create_uid_fkey                      | fleet_vehicle_log_services                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_log_services_service_type_id_fkey                 | fleet_vehicle_log_services                                    | FOREIGN KEY (service_type_id) REFERENCES fleet_service_type(id) ON DELETE RESTRICT
 fleet_vehicle_log_services_vendor_id_fkey                       | fleet_vehicle_log_services                                    | FOREIGN KEY (vendor_id) REFERENCES res_partner(id) ON DELETE SET NULL
 fleet_vehicle_log_services_company_id_fkey                      | fleet_vehicle_log_services                                    | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 fleet_vehicle_log_services_odometer_id_fkey                     | fleet_vehicle_log_services                                    | FOREIGN KEY (odometer_id) REFERENCES fleet_vehicle_odometer(id) ON DELETE SET NULL
 fleet_vehicle_log_services_manager_id_fkey                      | fleet_vehicle_log_services                                    | FOREIGN KEY (manager_id) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_log_services_vehicle_id_fkey                      | fleet_vehicle_log_services                                    | FOREIGN KEY (vehicle_id) REFERENCES fleet_vehicle(id) ON DELETE RESTRICT
 fleet_vehicle_mail_compose_message_ir_attachment_wizard_id_fkey | fleet_vehicle_mail_compose_message_ir_attachments_rel         | FOREIGN KEY (wizard_id) REFERENCES fleet_vehicle_send_mail(id) ON DELETE CASCADE
 fleet_vehicle_mail_compose_message_ir_attachments_rel_pkey      | fleet_vehicle_mail_compose_message_ir_attachments_rel         | PRIMARY KEY (wizard_id, attachment_id)
 fleet_vehicle_mail_compose_message_ir_attach_attachment_id_fkey | fleet_vehicle_mail_compose_message_ir_attachments_rel         | FOREIGN KEY (attachment_id) REFERENCES ir_attachment(id) ON DELETE CASCADE
 fleet_vehicle_model_brand_id_fkey                               | fleet_vehicle_model                                           | FOREIGN KEY (brand_id) REFERENCES fleet_vehicle_model_brand(id) ON DELETE RESTRICT
 fleet_vehicle_model_create_uid_fkey                             | fleet_vehicle_model                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_model_write_uid_fkey                              | fleet_vehicle_model                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_model_pkey                                        | fleet_vehicle_model                                           | PRIMARY KEY (id)
 fleet_vehicle_model_category_id_fkey                            | fleet_vehicle_model                                           | FOREIGN KEY (category_id) REFERENCES fleet_vehicle_model_category(id) ON DELETE SET NULL
 fleet_vehicle_model_brand_create_uid_fkey                       | fleet_vehicle_model_brand                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_model_brand_pkey                                  | fleet_vehicle_model_brand                                     | PRIMARY KEY (id)
 fleet_vehicle_model_brand_write_uid_fkey                        | fleet_vehicle_model_brand                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_model_category_create_uid_fkey                    | fleet_vehicle_model_category                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_model_category_pkey                               | fleet_vehicle_model_category                                  | PRIMARY KEY (id)
 fleet_vehicle_model_category_name_uniq                          | fleet_vehicle_model_category                                  | UNIQUE (name)
 fleet_vehicle_model_category_write_uid_fkey                     | fleet_vehicle_model_category                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_model_vendors_model_id_fkey                       | fleet_vehicle_model_vendors                                   | FOREIGN KEY (model_id) REFERENCES fleet_vehicle_model(id) ON DELETE CASCADE
 fleet_vehicle_model_vendors_partner_id_fkey                     | fleet_vehicle_model_vendors                                   | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 fleet_vehicle_model_vendors_pkey                                | fleet_vehicle_model_vendors                                   | PRIMARY KEY (model_id, partner_id)
 fleet_vehicle_odometer_write_uid_fkey                           | fleet_vehicle_odometer                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_odometer_create_uid_fkey                          | fleet_vehicle_odometer                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_odometer_vehicle_id_fkey                          | fleet_vehicle_odometer                                        | FOREIGN KEY (vehicle_id) REFERENCES fleet_vehicle(id) ON DELETE RESTRICT
 fleet_vehicle_odometer_pkey                                     | fleet_vehicle_odometer                                        | PRIMARY KEY (id)
 fleet_vehicle_send_mail_author_id_fkey                          | fleet_vehicle_send_mail                                       | FOREIGN KEY (author_id) REFERENCES res_partner(id) ON DELETE CASCADE
 fleet_vehicle_send_mail_pkey                                    | fleet_vehicle_send_mail                                       | PRIMARY KEY (id)
 fleet_vehicle_send_mail_template_id_fkey                        | fleet_vehicle_send_mail                                       | FOREIGN KEY (template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 fleet_vehicle_send_mail_write_uid_fkey                          | fleet_vehicle_send_mail                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_send_mail_create_uid_fkey                         | fleet_vehicle_send_mail                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_state_fleet_state_name_unique                     | fleet_vehicle_state                                           | UNIQUE (name)
 fleet_vehicle_state_pkey                                        | fleet_vehicle_state                                           | PRIMARY KEY (id)
 fleet_vehicle_state_write_uid_fkey                              | fleet_vehicle_state                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_state_create_uid_fkey                             | fleet_vehicle_state                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_tag_name_uniq                                     | fleet_vehicle_tag                                             | UNIQUE (name)
 fleet_vehicle_tag_create_uid_fkey                               | fleet_vehicle_tag                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_tag_write_uid_fkey                                | fleet_vehicle_tag                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 fleet_vehicle_tag_pkey                                          | fleet_vehicle_tag                                             | PRIMARY KEY (id)
 fleet_vehicle_vehicle_tag_rel_tag_id_fkey                       | fleet_vehicle_vehicle_tag_rel                                 | FOREIGN KEY (tag_id) REFERENCES fleet_vehicle_tag(id) ON DELETE CASCADE
 fleet_vehicle_vehicle_tag_rel_vehicle_tag_id_fkey               | fleet_vehicle_vehicle_tag_rel                                 | FOREIGN KEY (vehicle_tag_id) REFERENCES fleet_vehicle(id) ON DELETE CASCADE
 fleet_vehicle_vehicle_tag_rel_pkey                              | fleet_vehicle_vehicle_tag_rel                                 | PRIMARY KEY (vehicle_tag_id, tag_id)
 header_footer_quotation_template_re_sale_order_template_id_fkey | header_footer_quotation_template_rel                          | FOREIGN KEY (sale_order_template_id) REFERENCES sale_order_template(id) ON DELETE CASCADE
 header_footer_quotation_template_rel_quotation_document_id_fkey | header_footer_quotation_template_rel                          | FOREIGN KEY (quotation_document_id) REFERENCES quotation_document(id) ON DELETE CASCADE
 header_footer_quotation_template_rel_pkey                       | header_footer_quotation_template_rel                          | PRIMARY KEY (quotation_document_id, sale_order_template_id)
 helpdesk_sla_company_id_fkey                                    | helpdesk_sla                                                  | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 helpdesk_sla_create_uid_fkey                                    | helpdesk_sla                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 helpdesk_sla_pkey                                               | helpdesk_sla                                                  | PRIMARY KEY (id)
 helpdesk_sla_team_id_fkey                                       | helpdesk_sla                                                  | FOREIGN KEY (team_id) REFERENCES helpdesk_team(id) ON DELETE RESTRICT
 helpdesk_sla_stage_id_fkey                                      | helpdesk_sla                                                  | FOREIGN KEY (stage_id) REFERENCES helpdesk_stage(id) ON DELETE SET NULL
 helpdesk_sla_write_uid_fkey                                     | helpdesk_sla                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 helpdesk_sla_helpdesk_stage_rel_pkey                            | helpdesk_sla_helpdesk_stage_rel                               | PRIMARY KEY (helpdesk_sla_id, helpdesk_stage_id)
 helpdesk_sla_helpdesk_stage_rel_helpdesk_sla_id_fkey            | helpdesk_sla_helpdesk_stage_rel                               | FOREIGN KEY (helpdesk_sla_id) REFERENCES helpdesk_sla(id) ON DELETE CASCADE
 helpdesk_sla_helpdesk_stage_rel_helpdesk_stage_id_fkey          | helpdesk_sla_helpdesk_stage_rel                               | FOREIGN KEY (helpdesk_stage_id) REFERENCES helpdesk_stage(id) ON DELETE CASCADE
 helpdesk_sla_helpdesk_tag_rel_helpdesk_sla_id_fkey              | helpdesk_sla_helpdesk_tag_rel                                 | FOREIGN KEY (helpdesk_sla_id) REFERENCES helpdesk_sla(id) ON DELETE CASCADE
 helpdesk_sla_helpdesk_tag_rel_pkey                              | helpdesk_sla_helpdesk_tag_rel                                 | PRIMARY KEY (helpdesk_sla_id, helpdesk_tag_id)
 helpdesk_sla_helpdesk_tag_rel_helpdesk_tag_id_fkey              | helpdesk_sla_helpdesk_tag_rel                                 | FOREIGN KEY (helpdesk_tag_id) REFERENCES helpdesk_tag(id) ON DELETE CASCADE
 helpdesk_sla_res_partner_rel_res_partner_id_fkey                | helpdesk_sla_res_partner_rel                                  | FOREIGN KEY (res_partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 helpdesk_sla_res_partner_rel_helpdesk_sla_id_fkey               | helpdesk_sla_res_partner_rel                                  | FOREIGN KEY (helpdesk_sla_id) REFERENCES helpdesk_sla(id) ON DELETE CASCADE
 helpdesk_sla_res_partner_rel_pkey                               | helpdesk_sla_res_partner_rel                                  | PRIMARY KEY (helpdesk_sla_id, res_partner_id)
 helpdesk_sla_status_sla_stage_id_fkey                           | helpdesk_sla_status                                           | FOREIGN KEY (sla_stage_id) REFERENCES helpdesk_stage(id) ON DELETE SET NULL
 helpdesk_sla_status_create_uid_fkey                             | helpdesk_sla_status                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 helpdesk_sla_status_write_uid_fkey                              | helpdesk_sla_status                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 helpdesk_sla_status_ticket_id_fkey                              | helpdesk_sla_status                                           | FOREIGN KEY (ticket_id) REFERENCES helpdesk_ticket(id) ON DELETE CASCADE
 helpdesk_sla_status_pkey                                        | helpdesk_sla_status                                           | PRIMARY KEY (id)
 helpdesk_sla_status_sla_id_fkey                                 | helpdesk_sla_status                                           | FOREIGN KEY (sla_id) REFERENCES helpdesk_sla(id) ON DELETE CASCADE
 helpdesk_stage_template_id_fkey                                 | helpdesk_stage                                                | FOREIGN KEY (template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 helpdesk_stage_create_uid_fkey                                  | helpdesk_stage                                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 helpdesk_stage_pkey                                             | helpdesk_stage                                                | PRIMARY KEY (id)
 helpdesk_stage_write_uid_fkey                                   | helpdesk_stage                                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 helpdesk_stage_sms_template_id_fkey                             | helpdesk_stage                                                | FOREIGN KEY (sms_template_id) REFERENCES sms_template(id) ON DELETE SET NULL
 helpdesk_stage_delete_wizard_write_uid_fkey                     | helpdesk_stage_delete_wizard                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 helpdesk_stage_delete_wizard_pkey                               | helpdesk_stage_delete_wizard                                  | PRIMARY KEY (id)
 helpdesk_stage_delete_wizard_create_uid_fkey                    | helpdesk_stage_delete_wizard                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 helpdesk_stage_delete_wizard_helpdesk_tea_helpdesk_team_id_fkey | helpdesk_stage_delete_wizard_helpdesk_team_rel                | FOREIGN KEY (helpdesk_team_id) REFERENCES helpdesk_team(id) ON DELETE CASCADE
 helpdesk_stage_delete_wizard_helpdesk_team_rel_pkey             | helpdesk_stage_delete_wizard_helpdesk_team_rel                | PRIMARY KEY (helpdesk_stage_delete_wizard_id, helpdesk_team_id)
 helpdesk_stage_delete_wizard__helpdesk_stage_delete_wizard_fkey | helpdesk_stage_delete_wizard_helpdesk_team_rel                | FOREIGN KEY (helpdesk_stage_delete_wizard_id) REFERENCES helpdesk_stage_delete_wizard(id) ON DELETE CASCADE
 helpdesk_stage_helpdesk_stage_delete_wizard_rel_pkey            | helpdesk_stage_helpdesk_stage_delete_wizard_rel               | PRIMARY KEY (helpdesk_stage_delete_wizard_id, helpdesk_stage_id)
 helpdesk_stage_helpdesk_stage_helpdesk_stage_delete_wizard_fkey | helpdesk_stage_helpdesk_stage_delete_wizard_rel               | FOREIGN KEY (helpdesk_stage_delete_wizard_id) REFERENCES helpdesk_stage_delete_wizard(id) ON DELETE CASCADE
 helpdesk_stage_helpdesk_stage_delete_wiz_helpdesk_stage_id_fkey | helpdesk_stage_helpdesk_stage_delete_wizard_rel               | FOREIGN KEY (helpdesk_stage_id) REFERENCES helpdesk_stage(id) ON DELETE CASCADE
 helpdesk_tag_pkey                                               | helpdesk_tag                                                  | PRIMARY KEY (id)
 helpdesk_tag_write_uid_fkey                                     | helpdesk_tag                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 helpdesk_tag_create_uid_fkey                                    | helpdesk_tag                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 helpdesk_tag_name_uniq                                          | helpdesk_tag                                                  | UNIQUE (name)
 helpdesk_tag_helpdesk_ticket_rel_pkey                           | helpdesk_tag_helpdesk_ticket_rel                              | PRIMARY KEY (helpdesk_ticket_id, helpdesk_tag_id)
 helpdesk_tag_helpdesk_ticket_rel_helpdesk_tag_id_fkey           | helpdesk_tag_helpdesk_ticket_rel                              | FOREIGN KEY (helpdesk_tag_id) REFERENCES helpdesk_tag(id) ON DELETE CASCADE
 helpdesk_tag_helpdesk_ticket_rel_helpdesk_ticket_id_fkey        | helpdesk_tag_helpdesk_ticket_rel                              | FOREIGN KEY (helpdesk_ticket_id) REFERENCES helpdesk_ticket(id) ON DELETE CASCADE
 helpdesk_team_to_stage_id_fkey                                  | helpdesk_team                                                 | FOREIGN KEY (to_stage_id) REFERENCES helpdesk_stage(id) ON DELETE SET NULL
 helpdesk_team_website_form_view_id_fkey                         | helpdesk_team                                                 | FOREIGN KEY (website_form_view_id) REFERENCES ir_ui_view(id) ON DELETE SET NULL
 helpdesk_team_website_menu_id_fkey                              | helpdesk_team                                                 | FOREIGN KEY (website_menu_id) REFERENCES website_menu(id) ON DELETE SET NULL
 helpdesk_team_website_id_fkey                                   | helpdesk_team                                                 | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE SET NULL
 helpdesk_team_write_uid_fkey                                    | helpdesk_team                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 helpdesk_team_create_uid_fkey                                   | helpdesk_team                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 helpdesk_team_resource_calendar_id_fkey                         | helpdesk_team                                                 | FOREIGN KEY (resource_calendar_id) REFERENCES resource_calendar(id) ON DELETE SET NULL
 helpdesk_team_company_id_fkey                                   | helpdesk_team                                                 | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 helpdesk_team_alias_id_fkey                                     | helpdesk_team                                                 | FOREIGN KEY (alias_id) REFERENCES mail_alias(id) ON DELETE RESTRICT
 helpdesk_team_pkey                                              | helpdesk_team                                                 | PRIMARY KEY (id)
 helpdesk_team_res_users_rel_res_users_id_fkey                   | helpdesk_team_res_users_rel                                   | FOREIGN KEY (res_users_id) REFERENCES res_users(id) ON DELETE CASCADE
 helpdesk_team_res_users_rel_helpdesk_team_id_fkey               | helpdesk_team_res_users_rel                                   | FOREIGN KEY (helpdesk_team_id) REFERENCES helpdesk_team(id) ON DELETE CASCADE
 helpdesk_team_res_users_rel_pkey                                | helpdesk_team_res_users_rel                                   | PRIMARY KEY (helpdesk_team_id, res_users_id)
 helpdesk_ticket_team_id_fkey                                    | helpdesk_ticket                                               | FOREIGN KEY (team_id) REFERENCES helpdesk_team(id) ON DELETE SET NULL
 helpdesk_ticket_company_id_fkey                                 | helpdesk_ticket                                               | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 helpdesk_ticket_user_id_fkey                                    | helpdesk_ticket                                               | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 helpdesk_ticket_partner_id_fkey                                 | helpdesk_ticket                                               | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 helpdesk_ticket_stage_id_fkey                                   | helpdesk_ticket                                               | FOREIGN KEY (stage_id) REFERENCES helpdesk_stage(id) ON DELETE RESTRICT
 helpdesk_ticket_pkey                                            | helpdesk_ticket                                               | PRIMARY KEY (id)
 helpdesk_ticket_sale_order_id_fkey                              | helpdesk_ticket                                               | FOREIGN KEY (sale_order_id) REFERENCES sale_order(id) ON DELETE SET NULL
 helpdesk_ticket_create_uid_fkey                                 | helpdesk_ticket                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 helpdesk_ticket_write_uid_fkey                                  | helpdesk_ticket                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 helpdesk_ticket_medium_id_fkey                                  | helpdesk_ticket                                               | FOREIGN KEY (medium_id) REFERENCES utm_medium(id) ON DELETE SET NULL
 helpdesk_ticket_source_id_fkey                                  | helpdesk_ticket                                               | FOREIGN KEY (source_id) REFERENCES utm_source(id) ON DELETE SET NULL
 helpdesk_ticket_campaign_id_fkey                                | helpdesk_ticket                                               | FOREIGN KEY (campaign_id) REFERENCES utm_campaign(id) ON DELETE SET NULL
 helpdesk_ticket_convert_wizard_write_uid_fkey                   | helpdesk_ticket_convert_wizard                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 helpdesk_ticket_convert_wizard_pkey                             | helpdesk_ticket_convert_wizard                                | PRIMARY KEY (id)
 helpdesk_ticket_convert_wizard_create_uid_fkey                  | helpdesk_ticket_convert_wizard                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 helpdesk_ticket_convert_wizard_stage_id_fkey                    | helpdesk_ticket_convert_wizard                                | FOREIGN KEY (stage_id) REFERENCES project_task_type(id) ON DELETE CASCADE
 helpdesk_ticket_convert_wizard_project_id_fkey                  | helpdesk_ticket_convert_wizard                                | FOREIGN KEY (project_id) REFERENCES project_project(id) ON DELETE SET NULL
 helpdesk_ticket_to_lead_partner_id_fkey                         | helpdesk_ticket_to_lead                                       | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 helpdesk_ticket_to_lead_ticket_id_fkey                          | helpdesk_ticket_to_lead                                       | FOREIGN KEY (ticket_id) REFERENCES helpdesk_ticket(id) ON DELETE CASCADE
 helpdesk_ticket_to_lead_pkey                                    | helpdesk_ticket_to_lead                                       | PRIMARY KEY (id)
 helpdesk_ticket_to_lead_write_uid_fkey                          | helpdesk_ticket_to_lead                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 helpdesk_ticket_to_lead_create_uid_fkey                         | helpdesk_ticket_to_lead                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 helpdesk_ticket_to_lead_user_id_fkey                            | helpdesk_ticket_to_lead                                       | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 helpdesk_ticket_to_lead_team_id_fkey                            | helpdesk_ticket_to_lead                                       | FOREIGN KEY (team_id) REFERENCES crm_team(id) ON DELETE SET NULL
 hr_applicant_refuse_reason_id_fkey                              | hr_applicant                                                  | FOREIGN KEY (refuse_reason_id) REFERENCES hr_applicant_refuse_reason(id) ON DELETE SET NULL
 hr_applicant_campaign_id_fkey                                   | hr_applicant                                                  | FOREIGN KEY (campaign_id) REFERENCES utm_campaign(id) ON DELETE SET NULL
 hr_applicant_create_uid_fkey                                    | hr_applicant                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_applicant_write_uid_fkey                                     | hr_applicant                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_applicant_source_id_fkey                                     | hr_applicant                                                  | FOREIGN KEY (source_id) REFERENCES utm_source(id) ON DELETE SET NULL
 hr_applicant_pkey                                               | hr_applicant                                                  | PRIMARY KEY (id)
 hr_applicant_last_stage_id_fkey                                 | hr_applicant                                                  | FOREIGN KEY (last_stage_id) REFERENCES hr_recruitment_stage(id) ON DELETE SET NULL
 hr_applicant_company_id_fkey                                    | hr_applicant                                                  | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 hr_applicant_user_id_fkey                                       | hr_applicant                                                  | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 hr_applicant_job_id_fkey                                        | hr_applicant                                                  | FOREIGN KEY (job_id) REFERENCES hr_job(id) ON DELETE SET NULL
 hr_applicant_department_id_fkey                                 | hr_applicant                                                  | FOREIGN KEY (department_id) REFERENCES hr_department(id) ON DELETE SET NULL
 hr_applicant_stage_id_fkey                                      | hr_applicant                                                  | FOREIGN KEY (stage_id) REFERENCES hr_recruitment_stage(id) ON DELETE RESTRICT
 hr_applicant_candidate_id_fkey                                  | hr_applicant                                                  | FOREIGN KEY (candidate_id) REFERENCES hr_candidate(id) ON DELETE RESTRICT
 hr_applicant_message_main_attachment_id_fkey                    | hr_applicant                                                  | FOREIGN KEY (message_main_attachment_id) REFERENCES ir_attachment(id) ON DELETE SET NULL
 hr_applicant_medium_id_fkey                                     | hr_applicant                                                  | FOREIGN KEY (medium_id) REFERENCES utm_medium(id) ON DELETE SET NULL
 hr_applicant_category_name_uniq                                 | hr_applicant_category                                         | UNIQUE (name)
 hr_applicant_category_pkey                                      | hr_applicant_category                                         | PRIMARY KEY (id)
 hr_applicant_category_write_uid_fkey                            | hr_applicant_category                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_applicant_category_create_uid_fkey                           | hr_applicant_category                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_applicant_category_hr_candidate_rel_hr_candidate_id_fkey     | hr_applicant_category_hr_candidate_rel                        | FOREIGN KEY (hr_candidate_id) REFERENCES hr_candidate(id) ON DELETE CASCADE
 hr_applicant_category_hr_candidat_hr_applicant_category_id_fkey | hr_applicant_category_hr_candidate_rel                        | FOREIGN KEY (hr_applicant_category_id) REFERENCES hr_applicant_category(id) ON DELETE CASCADE
 hr_applicant_category_hr_candidate_rel_pkey                     | hr_applicant_category_hr_candidate_rel                        | PRIMARY KEY (hr_candidate_id, hr_applicant_category_id)
 hr_applicant_hr_applicant_category_rel_pkey                     | hr_applicant_hr_applicant_category_rel                        | PRIMARY KEY (hr_applicant_id, hr_applicant_category_id)
 hr_applicant_hr_applicant_category_rel_hr_applicant_id_fkey     | hr_applicant_hr_applicant_category_rel                        | FOREIGN KEY (hr_applicant_id) REFERENCES hr_applicant(id) ON DELETE CASCADE
 hr_applicant_hr_applicant_categor_hr_applicant_category_id_fkey | hr_applicant_hr_applicant_category_rel                        | FOREIGN KEY (hr_applicant_category_id) REFERENCES hr_applicant_category(id) ON DELETE CASCADE
 hr_applicant_refuse_reason_create_uid_fkey                      | hr_applicant_refuse_reason                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_applicant_refuse_reason_write_uid_fkey                       | hr_applicant_refuse_reason                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_applicant_refuse_reason_pkey                                 | hr_applicant_refuse_reason                                    | PRIMARY KEY (id)
 hr_applicant_refuse_reason_template_id_fkey                     | hr_applicant_refuse_reason                                    | FOREIGN KEY (template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 hr_applicant_res_users_interviewers_rel_pkey                    | hr_applicant_res_users_interviewers_rel                       | PRIMARY KEY (hr_applicant_id, res_users_id)
 hr_applicant_res_users_interviewers_rel_hr_applicant_id_fkey    | hr_applicant_res_users_interviewers_rel                       | FOREIGN KEY (hr_applicant_id) REFERENCES hr_applicant(id) ON DELETE CASCADE
 hr_applicant_res_users_interviewers_rel_res_users_id_fkey       | hr_applicant_res_users_interviewers_rel                       | FOREIGN KEY (res_users_id) REFERENCES res_users(id) ON DELETE CASCADE
 hr_candidate_company_id_fkey                                    | hr_candidate                                                  | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 hr_candidate_pkey                                               | hr_candidate                                                  | PRIMARY KEY (id)
 hr_candidate_type_id_fkey                                       | hr_candidate                                                  | FOREIGN KEY (type_id) REFERENCES hr_recruitment_degree(id) ON DELETE SET NULL
 hr_candidate_employee_id_fkey                                   | hr_candidate                                                  | FOREIGN KEY (employee_id) REFERENCES hr_employee(id) ON DELETE SET NULL
 hr_candidate_user_id_fkey                                       | hr_candidate                                                  | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 hr_candidate_write_uid_fkey                                     | hr_candidate                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_candidate_partner_id_fkey                                    | hr_candidate                                                  | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 hr_candidate_message_main_attachment_id_fkey                    | hr_candidate                                                  | FOREIGN KEY (message_main_attachment_id) REFERENCES ir_attachment(id) ON DELETE SET NULL
 hr_candidate_create_uid_fkey                                    | hr_candidate                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_candidate_hr_skill_rel_pkey                                  | hr_candidate_hr_skill_rel                                     | PRIMARY KEY (hr_candidate_id, hr_skill_id)
 hr_candidate_hr_skill_rel_hr_candidate_id_fkey                  | hr_candidate_hr_skill_rel                                     | FOREIGN KEY (hr_candidate_id) REFERENCES hr_candidate(id) ON DELETE CASCADE
 hr_candidate_hr_skill_rel_hr_skill_id_fkey                      | hr_candidate_hr_skill_rel                                     | FOREIGN KEY (hr_skill_id) REFERENCES hr_skill(id) ON DELETE CASCADE
 hr_candidate_skill_candidate_id_fkey                            | hr_candidate_skill                                            | FOREIGN KEY (candidate_id) REFERENCES hr_candidate(id) ON DELETE CASCADE
 hr_candidate_skill_skill_level_id_fkey                          | hr_candidate_skill                                            | FOREIGN KEY (skill_level_id) REFERENCES hr_skill_level(id) ON DELETE RESTRICT
 hr_candidate_skill_skill_id_fkey                                | hr_candidate_skill                                            | FOREIGN KEY (skill_id) REFERENCES hr_skill(id) ON DELETE RESTRICT
 hr_candidate_skill_skill_type_id_fkey                           | hr_candidate_skill                                            | FOREIGN KEY (skill_type_id) REFERENCES hr_skill_type(id) ON DELETE RESTRICT
 hr_candidate_skill_create_uid_fkey                              | hr_candidate_skill                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_candidate_skill_write_uid_fkey                               | hr_candidate_skill                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_candidate_skill_pkey                                         | hr_candidate_skill                                            | PRIMARY KEY (id)
 hr_candidate_skill__unique_skill                                | hr_candidate_skill                                            | UNIQUE (candidate_id, skill_id)
 hr_contract_write_uid_fkey                                      | hr_contract                                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_contract_create_uid_fkey                                     | hr_contract                                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_contract_company_id_fkey                                     | hr_contract                                                   | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 hr_contract_structure_type_id_fkey                              | hr_contract                                                   | FOREIGN KEY (structure_type_id) REFERENCES hr_payroll_structure_type(id) ON DELETE SET NULL
 hr_contract_pkey                                                | hr_contract                                                   | PRIMARY KEY (id)
 hr_contract_department_id_fkey                                  | hr_contract                                                   | FOREIGN KEY (department_id) REFERENCES hr_department(id) ON DELETE SET NULL
 hr_contract_employee_id_fkey                                    | hr_contract                                                   | FOREIGN KEY (employee_id) REFERENCES hr_employee(id) ON DELETE SET NULL
 hr_contract_job_id_fkey                                         | hr_contract                                                   | FOREIGN KEY (job_id) REFERENCES hr_job(id) ON DELETE SET NULL
 hr_contract_hr_responsible_id_fkey                              | hr_contract                                                   | FOREIGN KEY (hr_responsible_id) REFERENCES res_users(id) ON DELETE SET NULL
 hr_contract_contract_type_id_fkey                               | hr_contract                                                   | FOREIGN KEY (contract_type_id) REFERENCES hr_contract_type(id) ON DELETE SET NULL
 hr_contract_resource_calendar_id_fkey                           | hr_contract                                                   | FOREIGN KEY (resource_calendar_id) REFERENCES resource_calendar(id) ON DELETE SET NULL
 hr_contract_type_create_uid_fkey                                | hr_contract_type                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_contract_type_write_uid_fkey                                 | hr_contract_type                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_contract_type_country_id_fkey                                | hr_contract_type                                              | FOREIGN KEY (country_id) REFERENCES res_country(id) ON DELETE SET NULL
 hr_contract_type_pkey                                           | hr_contract_type                                              | PRIMARY KEY (id)
 hr_department_write_uid_fkey                                    | hr_department                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_department_company_id_fkey                                   | hr_department                                                 | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 hr_department_manager_id_fkey                                   | hr_department                                                 | FOREIGN KEY (manager_id) REFERENCES hr_employee(id) ON DELETE SET NULL
 hr_department_master_department_id_fkey                         | hr_department                                                 | FOREIGN KEY (master_department_id) REFERENCES hr_department(id) ON DELETE SET NULL
 hr_department_pkey                                              | hr_department                                                 | PRIMARY KEY (id)
 hr_department_create_uid_fkey                                   | hr_department                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_department_parent_id_fkey                                    | hr_department                                                 | FOREIGN KEY (parent_id) REFERENCES hr_department(id) ON DELETE SET NULL
 hr_departure_reason_create_uid_fkey                             | hr_departure_reason                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_departure_reason_pkey                                        | hr_departure_reason                                           | PRIMARY KEY (id)
 hr_departure_reason_write_uid_fkey                              | hr_departure_reason                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_departure_wizard_employee_id_fkey                            | hr_departure_wizard                                           | FOREIGN KEY (employee_id) REFERENCES hr_employee(id) ON DELETE CASCADE
 hr_departure_wizard_write_uid_fkey                              | hr_departure_wizard                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_departure_wizard_departure_reason_id_fkey                    | hr_departure_wizard                                           | FOREIGN KEY (departure_reason_id) REFERENCES hr_departure_reason(id) ON DELETE CASCADE
 hr_departure_wizard_pkey                                        | hr_departure_wizard                                           | PRIMARY KEY (id)
 hr_departure_wizard_create_uid_fkey                             | hr_departure_wizard                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_employee_departure_reason_id_fkey                            | hr_employee                                                   | FOREIGN KEY (departure_reason_id) REFERENCES hr_departure_reason(id) ON DELETE RESTRICT
 hr_employee_check_billable_time_target                          | hr_employee                                                   | CHECK ((billable_time_target >= (0)::double precision))
 hr_employee_contract_id_fkey                                    | hr_employee                                                   | FOREIGN KEY (contract_id) REFERENCES hr_contract(id) ON DELETE SET NULL
 hr_employee_timesheet_manager_id_fkey                           | hr_employee                                                   | FOREIGN KEY (timesheet_manager_id) REFERENCES res_users(id) ON DELETE SET NULL
 hr_employee_pkey                                                | hr_employee                                                   | PRIMARY KEY (id)
 hr_employee_barcode_uniq                                        | hr_employee                                                   | UNIQUE (barcode)
 hr_employee_user_uniq                                           | hr_employee                                                   | UNIQUE (user_id, company_id)
 hr_employee_resource_id_fkey                                    | hr_employee                                                   | FOREIGN KEY (resource_id) REFERENCES resource_resource(id) ON DELETE RESTRICT
 hr_employee_company_id_fkey                                     | hr_employee                                                   | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 hr_employee_resource_calendar_id_fkey                           | hr_employee                                                   | FOREIGN KEY (resource_calendar_id) REFERENCES resource_calendar(id) ON DELETE SET NULL
 hr_employee_message_main_attachment_id_fkey                     | hr_employee                                                   | FOREIGN KEY (message_main_attachment_id) REFERENCES ir_attachment(id) ON DELETE SET NULL
 hr_employee_department_id_fkey                                  | hr_employee                                                   | FOREIGN KEY (department_id) REFERENCES hr_department(id) ON DELETE SET NULL
 hr_employee_job_id_fkey                                         | hr_employee                                                   | FOREIGN KEY (job_id) REFERENCES hr_job(id) ON DELETE SET NULL
 hr_employee_address_id_fkey                                     | hr_employee                                                   | FOREIGN KEY (address_id) REFERENCES res_partner(id) ON DELETE SET NULL
 hr_employee_work_contact_id_fkey                                | hr_employee                                                   | FOREIGN KEY (work_contact_id) REFERENCES res_partner(id) ON DELETE SET NULL
 hr_employee_work_location_id_fkey                               | hr_employee                                                   | FOREIGN KEY (work_location_id) REFERENCES hr_work_location(id) ON DELETE SET NULL
 hr_employee_user_id_fkey                                        | hr_employee                                                   | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE RESTRICT
 hr_employee_parent_id_fkey                                      | hr_employee                                                   | FOREIGN KEY (parent_id) REFERENCES hr_employee(id) ON DELETE SET NULL
 hr_employee_coach_id_fkey                                       | hr_employee                                                   | FOREIGN KEY (coach_id) REFERENCES hr_employee(id) ON DELETE SET NULL
 hr_employee_private_state_id_fkey                               | hr_employee                                                   | FOREIGN KEY (private_state_id) REFERENCES res_country_state(id) ON DELETE SET NULL
 hr_employee_private_country_id_fkey                             | hr_employee                                                   | FOREIGN KEY (private_country_id) REFERENCES res_country(id) ON DELETE SET NULL
 hr_employee_country_id_fkey                                     | hr_employee                                                   | FOREIGN KEY (country_id) REFERENCES res_country(id) ON DELETE SET NULL
 hr_employee_country_of_birth_fkey                               | hr_employee                                                   | FOREIGN KEY (country_of_birth) REFERENCES res_country(id) ON DELETE SET NULL
 hr_employee_bank_account_id_fkey                                | hr_employee                                                   | FOREIGN KEY (bank_account_id) REFERENCES res_partner_bank(id) ON DELETE SET NULL
 hr_employee_create_uid_fkey                                     | hr_employee                                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_employee_write_uid_fkey                                      | hr_employee                                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_employee_expense_manager_id_fkey                             | hr_employee                                                   | FOREIGN KEY (expense_manager_id) REFERENCES res_users(id) ON DELETE SET NULL
 hr_employee_category_name_uniq                                  | hr_employee_category                                          | UNIQUE (name)
 hr_employee_category_create_uid_fkey                            | hr_employee_category                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_employee_category_write_uid_fkey                             | hr_employee_category                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_employee_category_pkey                                       | hr_employee_category                                          | PRIMARY KEY (id)
 hr_employee_cv_wizard_write_uid_fkey                            | hr_employee_cv_wizard                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_employee_cv_wizard_create_uid_fkey                           | hr_employee_cv_wizard                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_employee_cv_wizard_pkey                                      | hr_employee_cv_wizard                                         | PRIMARY KEY (id)
 hr_employee_delete_wizard_write_uid_fkey                        | hr_employee_delete_wizard                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_employee_delete_wizard_create_uid_fkey                       | hr_employee_delete_wizard                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_employee_delete_wizard_pkey                                  | hr_employee_delete_wizard                                     | PRIMARY KEY (id)
 hr_employee_hr_employee_cv_wizard_rel_hr_employee_id_fkey       | hr_employee_hr_employee_cv_wizard_rel                         | FOREIGN KEY (hr_employee_id) REFERENCES hr_employee(id) ON DELETE CASCADE
 hr_employee_hr_employee_cv_wizard_rel_pkey                      | hr_employee_hr_employee_cv_wizard_rel                         | PRIMARY KEY (hr_employee_cv_wizard_id, hr_employee_id)
 hr_employee_hr_employee_cv_wizard_hr_employee_cv_wizard_id_fkey | hr_employee_hr_employee_cv_wizard_rel                         | FOREIGN KEY (hr_employee_cv_wizard_id) REFERENCES hr_employee_cv_wizard(id) ON DELETE CASCADE
 hr_employee_hr_employee_delete_wizard_rel_pkey                  | hr_employee_hr_employee_delete_wizard_rel                     | PRIMARY KEY (hr_employee_delete_wizard_id, hr_employee_id)
 hr_employee_hr_employee_delet_hr_employee_delete_wizard_id_fkey | hr_employee_hr_employee_delete_wizard_rel                     | FOREIGN KEY (hr_employee_delete_wizard_id) REFERENCES hr_employee_delete_wizard(id) ON DELETE CASCADE
 hr_employee_hr_employee_delete_wizard_rel_hr_employee_id_fkey   | hr_employee_hr_employee_delete_wizard_rel                     | FOREIGN KEY (hr_employee_id) REFERENCES hr_employee(id) ON DELETE CASCADE
 hr_employee_hr_skill_rel_hr_skill_id_fkey                       | hr_employee_hr_skill_rel                                      | FOREIGN KEY (hr_skill_id) REFERENCES hr_skill(id) ON DELETE CASCADE
 hr_employee_hr_skill_rel_hr_employee_id_fkey                    | hr_employee_hr_skill_rel                                      | FOREIGN KEY (hr_employee_id) REFERENCES hr_employee(id) ON DELETE CASCADE
 hr_employee_hr_skill_rel_pkey                                   | hr_employee_hr_skill_rel                                      | PRIMARY KEY (hr_employee_id, hr_skill_id)
 hr_employee_mrp_workcenter_rel_hr_employee_id_fkey              | hr_employee_mrp_workcenter_rel                                | FOREIGN KEY (hr_employee_id) REFERENCES hr_employee(id) ON DELETE CASCADE
 hr_employee_mrp_workcenter_rel_pkey                             | hr_employee_mrp_workcenter_rel                                | PRIMARY KEY (mrp_workcenter_id, hr_employee_id)
 hr_employee_mrp_workcenter_rel_mrp_workcenter_id_fkey           | hr_employee_mrp_workcenter_rel                                | FOREIGN KEY (mrp_workcenter_id) REFERENCES mrp_workcenter(id) ON DELETE CASCADE
 hr_employee_mrp_workorder_rel_mrp_workorder_id_fkey             | hr_employee_mrp_workorder_rel                                 | FOREIGN KEY (mrp_workorder_id) REFERENCES mrp_workorder(id) ON DELETE CASCADE
 hr_employee_mrp_workorder_rel_pkey                              | hr_employee_mrp_workorder_rel                                 | PRIMARY KEY (mrp_workorder_id, hr_employee_id)
 hr_employee_mrp_workorder_rel_hr_employee_id_fkey               | hr_employee_mrp_workorder_rel                                 | FOREIGN KEY (hr_employee_id) REFERENCES hr_employee(id) ON DELETE CASCADE
 hr_employee_skill__unique_skill                                 | hr_employee_skill                                             | UNIQUE (employee_id, skill_id)
 hr_employee_skill_write_uid_fkey                                | hr_employee_skill                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_employee_skill_create_uid_fkey                               | hr_employee_skill                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_employee_skill_skill_type_id_fkey                            | hr_employee_skill                                             | FOREIGN KEY (skill_type_id) REFERENCES hr_skill_type(id) ON DELETE CASCADE
 hr_employee_skill_skill_level_id_fkey                           | hr_employee_skill                                             | FOREIGN KEY (skill_level_id) REFERENCES hr_skill_level(id) ON DELETE CASCADE
 hr_employee_skill_skill_id_fkey                                 | hr_employee_skill                                             | FOREIGN KEY (skill_id) REFERENCES hr_skill(id) ON DELETE CASCADE
 hr_employee_skill_employee_id_fkey                              | hr_employee_skill                                             | FOREIGN KEY (employee_id) REFERENCES hr_employee(id) ON DELETE CASCADE
 hr_employee_skill_pkey                                          | hr_employee_skill                                             | PRIMARY KEY (id)
 hr_employee_skill_log_pkey                                      | hr_employee_skill_log                                         | PRIMARY KEY (id)
 hr_employee_skill_log_skill_type_id_fkey                        | hr_employee_skill_log                                         | FOREIGN KEY (skill_type_id) REFERENCES hr_skill_type(id) ON DELETE CASCADE
 hr_employee_skill_log_skill_id_fkey                             | hr_employee_skill_log                                         | FOREIGN KEY (skill_id) REFERENCES hr_skill(id) ON DELETE CASCADE
 hr_employee_skill_log_create_uid_fkey                           | hr_employee_skill_log                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_employee_skill_log_department_id_fkey                        | hr_employee_skill_log                                         | FOREIGN KEY (department_id) REFERENCES hr_department(id) ON DELETE SET NULL
 hr_employee_skill_log_write_uid_fkey                            | hr_employee_skill_log                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_employee_skill_log_skill_level_id_fkey                       | hr_employee_skill_log                                         | FOREIGN KEY (skill_level_id) REFERENCES hr_skill_level(id) ON DELETE CASCADE
 hr_employee_skill_log_employee_id_fkey                          | hr_employee_skill_log                                         | FOREIGN KEY (employee_id) REFERENCES hr_employee(id) ON DELETE CASCADE
 hr_employee_skill_log__unique_skill_log                         | hr_employee_skill_log                                         | UNIQUE (employee_id, department_id, skill_id, date)
 hr_expense_create_uid_fkey                                      | hr_expense                                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_expense_write_uid_fkey                                       | hr_expense                                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_expense_sale_order_id_fkey                                   | hr_expense                                                    | FOREIGN KEY (sale_order_id) REFERENCES sale_order(id) ON DELETE SET NULL
 hr_expense_pkey                                                 | hr_expense                                                    | PRIMARY KEY (id)
 hr_expense_currency_id_fkey                                     | hr_expense                                                    | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE RESTRICT
 hr_expense_vendor_id_fkey                                       | hr_expense                                                    | FOREIGN KEY (vendor_id) REFERENCES res_partner(id) ON DELETE SET NULL
 hr_expense_account_id_fkey                                      | hr_expense                                                    | FOREIGN KEY (account_id) REFERENCES account_account(id) ON DELETE SET NULL
 hr_expense_message_main_attachment_id_fkey                      | hr_expense                                                    | FOREIGN KEY (message_main_attachment_id) REFERENCES ir_attachment(id) ON DELETE SET NULL
 hr_expense_employee_id_fkey                                     | hr_expense                                                    | FOREIGN KEY (employee_id) REFERENCES hr_employee(id) ON DELETE RESTRICT
 hr_expense_company_id_fkey                                      | hr_expense                                                    | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 hr_expense_product_id_fkey                                      | hr_expense                                                    | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE RESTRICT
 hr_expense_product_uom_id_fkey                                  | hr_expense                                                    | FOREIGN KEY (product_uom_id) REFERENCES uom_uom(id) ON DELETE SET NULL
 hr_expense_sheet_id_fkey                                        | hr_expense                                                    | FOREIGN KEY (sheet_id) REFERENCES hr_expense_sheet(id) ON DELETE SET NULL
 hr_expense_approve_duplicate_write_uid_fkey                     | hr_expense_approve_duplicate                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_expense_approve_duplicate_create_uid_fkey                    | hr_expense_approve_duplicate                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_expense_approve_duplicate_pkey                               | hr_expense_approve_duplicate                                  | PRIMARY KEY (id)
 hr_expense_approve_duplicate_hr_expense_sheet_rel_pkey          | hr_expense_approve_duplicate_hr_expense_sheet_rel             | PRIMARY KEY (hr_expense_approve_duplicate_id, hr_expense_sheet_id)
 hr_expense_approve_duplicate__hr_expense_approve_duplicate_fkey | hr_expense_approve_duplicate_hr_expense_sheet_rel             | FOREIGN KEY (hr_expense_approve_duplicate_id) REFERENCES hr_expense_approve_duplicate(id) ON DELETE CASCADE
 hr_expense_approve_duplicate_hr_expens_hr_expense_sheet_id_fkey | hr_expense_approve_duplicate_hr_expense_sheet_rel             | FOREIGN KEY (hr_expense_sheet_id) REFERENCES hr_expense_sheet(id) ON DELETE CASCADE
 hr_expense_hr_expense_approve_duplicate_rel_pkey                | hr_expense_hr_expense_approve_duplicate_rel                   | PRIMARY KEY (hr_expense_approve_duplicate_id, hr_expense_id)
 hr_expense_hr_expense_approve_duplicate_rel_hr_expense_id_fkey  | hr_expense_hr_expense_approve_duplicate_rel                   | FOREIGN KEY (hr_expense_id) REFERENCES hr_expense(id) ON DELETE CASCADE
 hr_expense_hr_expense_approve_hr_expense_approve_duplicate_fkey | hr_expense_hr_expense_approve_duplicate_rel                   | FOREIGN KEY (hr_expense_approve_duplicate_id) REFERENCES hr_expense_approve_duplicate(id) ON DELETE CASCADE
 hr_expense_refuse_wizard_write_uid_fkey                         | hr_expense_refuse_wizard                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_expense_refuse_wizard_create_uid_fkey                        | hr_expense_refuse_wizard                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_expense_refuse_wizard_pkey                                   | hr_expense_refuse_wizard                                      | PRIMARY KEY (id)
 hr_expense_refuse_wizard_hr_expense_sheet_rel_pkey              | hr_expense_refuse_wizard_hr_expense_sheet_rel                 | PRIMARY KEY (hr_expense_refuse_wizard_id, hr_expense_sheet_id)
 hr_expense_refuse_wizard_hr_expense_sh_hr_expense_sheet_id_fkey | hr_expense_refuse_wizard_hr_expense_sheet_rel                 | FOREIGN KEY (hr_expense_sheet_id) REFERENCES hr_expense_sheet(id) ON DELETE CASCADE
 hr_expense_refuse_wizard_hr_ex_hr_expense_refuse_wizard_id_fkey | hr_expense_refuse_wizard_hr_expense_sheet_rel                 | FOREIGN KEY (hr_expense_refuse_wizard_id) REFERENCES hr_expense_refuse_wizard(id) ON DELETE CASCADE
 hr_expense_sheet_department_id_fkey                             | hr_expense_sheet                                              | FOREIGN KEY (department_id) REFERENCES hr_department(id) ON DELETE SET NULL
 hr_expense_sheet_pkey                                           | hr_expense_sheet                                              | PRIMARY KEY (id)
 hr_expense_sheet_employee_journal_id_fkey                       | hr_expense_sheet                                              | FOREIGN KEY (employee_journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 hr_expense_sheet_journal_id_required_posted                     | hr_expense_sheet                                              | CHECK (((((state)::text = ANY ((ARRAY['post'::character varying, 'done'::character varying])::text[])) AND (journal_id IS NOT NULL)) OR ((state)::text <> ALL ((ARRAY['post'::character varying, 'done'::character varying])::text[]))))
 hr_expense_sheet_message_main_attachment_id_fkey                | hr_expense_sheet                                              | FOREIGN KEY (message_main_attachment_id) REFERENCES ir_attachment(id) ON DELETE SET NULL
 hr_expense_sheet_company_id_fkey                                | hr_expense_sheet                                              | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 hr_expense_sheet_employee_id_fkey                               | hr_expense_sheet                                              | FOREIGN KEY (employee_id) REFERENCES hr_employee(id) ON DELETE RESTRICT
 hr_expense_sheet_user_id_fkey                                   | hr_expense_sheet                                              | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 hr_expense_sheet_currency_id_fkey                               | hr_expense_sheet                                              | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 hr_expense_sheet_payment_method_line_id_fkey                    | hr_expense_sheet                                              | FOREIGN KEY (payment_method_line_id) REFERENCES account_payment_method_line(id) ON DELETE SET NULL
 hr_expense_sheet_journal_id_fkey                                | hr_expense_sheet                                              | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 hr_expense_sheet_create_uid_fkey                                | hr_expense_sheet                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_expense_sheet_write_uid_fkey                                 | hr_expense_sheet                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_expense_split_wizard_id_fkey                                 | hr_expense_split                                              | FOREIGN KEY (wizard_id) REFERENCES hr_expense_split_wizard(id) ON DELETE SET NULL
 hr_expense_split_sale_order_id_fkey                             | hr_expense_split                                              | FOREIGN KEY (sale_order_id) REFERENCES sale_order(id) ON DELETE SET NULL
 hr_expense_split_expense_id_fkey                                | hr_expense_split                                              | FOREIGN KEY (expense_id) REFERENCES hr_expense(id) ON DELETE SET NULL
 hr_expense_split_product_id_fkey                                | hr_expense_split                                              | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE CASCADE
 hr_expense_split_employee_id_fkey                               | hr_expense_split                                              | FOREIGN KEY (employee_id) REFERENCES hr_employee(id) ON DELETE CASCADE
 hr_expense_split_currency_id_fkey                               | hr_expense_split                                              | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 hr_expense_split_pkey                                           | hr_expense_split                                              | PRIMARY KEY (id)
 hr_expense_split_create_uid_fkey                                | hr_expense_split                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_expense_split_write_uid_fkey                                 | hr_expense_split                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_expense_split_company_id_fkey                                | hr_expense_split                                              | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 hr_expense_split_wizard_create_uid_fkey                         | hr_expense_split_wizard                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_expense_split_wizard_pkey                                    | hr_expense_split_wizard                                       | PRIMARY KEY (id)
 hr_expense_split_wizard_write_uid_fkey                          | hr_expense_split_wizard                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_expense_split_wizard_expense_id_fkey                         | hr_expense_split_wizard                                       | FOREIGN KEY (expense_id) REFERENCES hr_expense(id) ON DELETE CASCADE
 hr_job_write_uid_fkey                                           | hr_job                                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_job_website_id_fkey                                          | hr_job                                                        | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE RESTRICT
 hr_job_pkey                                                     | hr_job                                                        | PRIMARY KEY (id)
 hr_job_name_company_uniq                                        | hr_job                                                        | UNIQUE (name, company_id, department_id)
 hr_job_alias_id_fkey                                            | hr_job                                                        | FOREIGN KEY (alias_id) REFERENCES mail_alias(id) ON DELETE RESTRICT
 hr_job_address_id_fkey                                          | hr_job                                                        | FOREIGN KEY (address_id) REFERENCES res_partner(id) ON DELETE SET NULL
 hr_job_manager_id_fkey                                          | hr_job                                                        | FOREIGN KEY (manager_id) REFERENCES hr_employee(id) ON DELETE SET NULL
 hr_job_user_id_fkey                                             | hr_job                                                        | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 hr_job_industry_id_fkey                                         | hr_job                                                        | FOREIGN KEY (industry_id) REFERENCES res_partner_industry(id) ON DELETE SET NULL
 hr_job_no_of_recruitment_positive                               | hr_job                                                        | CHECK ((no_of_recruitment >= 0))
 hr_job_department_id_fkey                                       | hr_job                                                        | FOREIGN KEY (department_id) REFERENCES hr_department(id) ON DELETE SET NULL
 hr_job_company_id_fkey                                          | hr_job                                                        | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 hr_job_contract_type_id_fkey                                    | hr_job                                                        | FOREIGN KEY (contract_type_id) REFERENCES hr_contract_type(id) ON DELETE SET NULL
 hr_job_create_uid_fkey                                          | hr_job                                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_job_extended_interviewer_res_users_hr_job_id_fkey            | hr_job_extended_interviewer_res_users                         | FOREIGN KEY (hr_job_id) REFERENCES hr_job(id) ON DELETE CASCADE
 hr_job_extended_interviewer_res_users_pkey                      | hr_job_extended_interviewer_res_users                         | PRIMARY KEY (hr_job_id, res_users_id)
 hr_job_extended_interviewer_res_users_res_users_id_fkey         | hr_job_extended_interviewer_res_users                         | FOREIGN KEY (res_users_id) REFERENCES res_users(id) ON DELETE CASCADE
 hr_job_hr_recruitment_stage_rel_hr_job_id_fkey                  | hr_job_hr_recruitment_stage_rel                               | FOREIGN KEY (hr_job_id) REFERENCES hr_job(id) ON DELETE CASCADE
 hr_job_hr_recruitment_stage_rel_pkey                            | hr_job_hr_recruitment_stage_rel                               | PRIMARY KEY (hr_recruitment_stage_id, hr_job_id)
 hr_job_hr_recruitment_stage_rel_hr_recruitment_stage_id_fkey    | hr_job_hr_recruitment_stage_rel                               | FOREIGN KEY (hr_recruitment_stage_id) REFERENCES hr_recruitment_stage(id) ON DELETE CASCADE
 hr_job_hr_skill_rel_hr_skill_id_fkey                            | hr_job_hr_skill_rel                                           | FOREIGN KEY (hr_skill_id) REFERENCES hr_skill(id) ON DELETE CASCADE
 hr_job_hr_skill_rel_pkey                                        | hr_job_hr_skill_rel                                           | PRIMARY KEY (hr_job_id, hr_skill_id)
 hr_job_hr_skill_rel_hr_job_id_fkey                              | hr_job_hr_skill_rel                                           | FOREIGN KEY (hr_job_id) REFERENCES hr_job(id) ON DELETE CASCADE
 hr_job_platform_create_uid_fkey                                 | hr_job_platform                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_job_platform_pkey                                            | hr_job_platform                                               | PRIMARY KEY (id)
 hr_job_platform_write_uid_fkey                                  | hr_job_platform                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_job_platform_email_uniq                                      | hr_job_platform                                               | UNIQUE (email)
 hr_job_res_users_rel_res_users_id_fkey                          | hr_job_res_users_rel                                          | FOREIGN KEY (res_users_id) REFERENCES res_users(id) ON DELETE CASCADE
 hr_job_res_users_rel_hr_job_id_fkey                             | hr_job_res_users_rel                                          | FOREIGN KEY (hr_job_id) REFERENCES hr_job(id) ON DELETE CASCADE
 hr_job_res_users_rel_pkey                                       | hr_job_res_users_rel                                          | PRIMARY KEY (hr_job_id, res_users_id)
 hr_payroll_structure_type_pkey                                  | hr_payroll_structure_type                                     | PRIMARY KEY (id)
 hr_payroll_structure_type_create_uid_fkey                       | hr_payroll_structure_type                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_payroll_structure_type_country_id_fkey                       | hr_payroll_structure_type                                     | FOREIGN KEY (country_id) REFERENCES res_country(id) ON DELETE SET NULL
 hr_payroll_structure_type_write_uid_fkey                        | hr_payroll_structure_type                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_payroll_structure_type_default_resource_calendar_id_fkey     | hr_payroll_structure_type                                     | FOREIGN KEY (default_resource_calendar_id) REFERENCES resource_calendar(id) ON DELETE SET NULL
 hr_recruitment_degree_name_uniq                                 | hr_recruitment_degree                                         | UNIQUE (name)
 hr_recruitment_degree_write_uid_fkey                            | hr_recruitment_degree                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_recruitment_degree_create_uid_fkey                           | hr_recruitment_degree                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_recruitment_degree_pkey                                      | hr_recruitment_degree                                         | PRIMARY KEY (id)
 hr_recruitment_source_source_id_fkey                            | hr_recruitment_source                                         | FOREIGN KEY (source_id) REFERENCES utm_source(id) ON DELETE RESTRICT
 hr_recruitment_source_create_uid_fkey                           | hr_recruitment_source                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_recruitment_source_job_id_fkey                               | hr_recruitment_source                                         | FOREIGN KEY (job_id) REFERENCES hr_job(id) ON DELETE CASCADE
 hr_recruitment_source_alias_id_fkey                             | hr_recruitment_source                                         | FOREIGN KEY (alias_id) REFERENCES mail_alias(id) ON DELETE RESTRICT
 hr_recruitment_source_medium_id_fkey                            | hr_recruitment_source                                         | FOREIGN KEY (medium_id) REFERENCES utm_medium(id) ON DELETE SET NULL
 hr_recruitment_source_pkey                                      | hr_recruitment_source                                         | PRIMARY KEY (id)
 hr_recruitment_source_write_uid_fkey                            | hr_recruitment_source                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_recruitment_stage_pkey                                       | hr_recruitment_stage                                          | PRIMARY KEY (id)
 hr_recruitment_stage_template_id_fkey                           | hr_recruitment_stage                                          | FOREIGN KEY (template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 hr_recruitment_stage_create_uid_fkey                            | hr_recruitment_stage                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_recruitment_stage_write_uid_fkey                             | hr_recruitment_stage                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_resume_line_date_check                                       | hr_resume_line                                                | CHECK (((date_start <= date_end) OR (date_end IS NULL)))
 hr_resume_line_write_uid_fkey                                   | hr_resume_line                                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_resume_line_employee_id_fkey                                 | hr_resume_line                                                | FOREIGN KEY (employee_id) REFERENCES hr_employee(id) ON DELETE CASCADE
 hr_resume_line_create_uid_fkey                                  | hr_resume_line                                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_resume_line_line_type_id_fkey                                | hr_resume_line                                                | FOREIGN KEY (line_type_id) REFERENCES hr_resume_line_type(id) ON DELETE SET NULL
 hr_resume_line_pkey                                             | hr_resume_line                                                | PRIMARY KEY (id)
 hr_resume_line_type_write_uid_fkey                              | hr_resume_line_type                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_resume_line_type_pkey                                        | hr_resume_line_type                                           | PRIMARY KEY (id)
 hr_resume_line_type_create_uid_fkey                             | hr_resume_line_type                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_skill_skill_type_id_fkey                                     | hr_skill                                                      | FOREIGN KEY (skill_type_id) REFERENCES hr_skill_type(id) ON DELETE CASCADE
 hr_skill_pkey                                                   | hr_skill                                                      | PRIMARY KEY (id)
 hr_skill_create_uid_fkey                                        | hr_skill                                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_skill_write_uid_fkey                                         | hr_skill                                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_skill_level_skill_type_id_fkey                               | hr_skill_level                                                | FOREIGN KEY (skill_type_id) REFERENCES hr_skill_type(id) ON DELETE CASCADE
 hr_skill_level_pkey                                             | hr_skill_level                                                | PRIMARY KEY (id)
 hr_skill_level_check_level_progress                             | hr_skill_level                                                | CHECK (((level_progress >= 0) AND (level_progress <= 100)))
 hr_skill_level_write_uid_fkey                                   | hr_skill_level                                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_skill_level_create_uid_fkey                                  | hr_skill_level                                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_skill_type_pkey                                              | hr_skill_type                                                 | PRIMARY KEY (id)
 hr_skill_type_create_uid_fkey                                   | hr_skill_type                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_skill_type_write_uid_fkey                                    | hr_skill_type                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_timesheet_merge_wizard_encoding_uom_id_fkey                  | hr_timesheet_merge_wizard                                     | FOREIGN KEY (encoding_uom_id) REFERENCES uom_uom(id) ON DELETE SET NULL
 hr_timesheet_merge_wizard_pkey                                  | hr_timesheet_merge_wizard                                     | PRIMARY KEY (id)
 hr_timesheet_merge_wizard_create_uid_fkey                       | hr_timesheet_merge_wizard                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_timesheet_merge_wizard_employee_id_fkey                      | hr_timesheet_merge_wizard                                     | FOREIGN KEY (employee_id) REFERENCES hr_employee(id) ON DELETE SET NULL
 hr_timesheet_merge_wizard_write_uid_fkey                        | hr_timesheet_merge_wizard                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_timesheet_merge_wizard_task_id_fkey                          | hr_timesheet_merge_wizard                                     | FOREIGN KEY (task_id) REFERENCES project_task(id) ON DELETE SET NULL
 hr_timesheet_merge_wizard_project_id_fkey                       | hr_timesheet_merge_wizard                                     | FOREIGN KEY (project_id) REFERENCES project_project(id) ON DELETE SET NULL
 hr_timesheet_tip_create_uid_fkey                                | hr_timesheet_tip                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_timesheet_tip_write_uid_fkey                                 | hr_timesheet_tip                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_timesheet_tip_pkey                                           | hr_timesheet_tip                                              | PRIMARY KEY (id)
 hr_work_location_address_id_fkey                                | hr_work_location                                              | FOREIGN KEY (address_id) REFERENCES res_partner(id) ON DELETE RESTRICT
 hr_work_location_pkey                                           | hr_work_location                                              | PRIMARY KEY (id)
 hr_work_location_create_uid_fkey                                | hr_work_location                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 hr_work_location_company_id_fkey                                | hr_work_location                                              | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 hr_work_location_write_uid_fkey                                 | hr_work_location                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 iap_account_create_uid_fkey                                     | iap_account                                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 iap_account_pkey                                                | iap_account                                                   | PRIMARY KEY (id)
 iap_account_write_uid_fkey                                      | iap_account                                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 iap_account_service_id_fkey                                     | iap_account                                                   | FOREIGN KEY (service_id) REFERENCES iap_service(id) ON DELETE RESTRICT
 iap_account_res_company_rel_pkey                                | iap_account_res_company_rel                                   | PRIMARY KEY (iap_account_id, res_company_id)
 iap_account_res_company_rel_res_company_id_fkey                 | iap_account_res_company_rel                                   | FOREIGN KEY (res_company_id) REFERENCES res_company(id) ON DELETE CASCADE
 iap_account_res_company_rel_iap_account_id_fkey                 | iap_account_res_company_rel                                   | FOREIGN KEY (iap_account_id) REFERENCES iap_account(id) ON DELETE CASCADE
 iap_account_res_users_rel_pkey                                  | iap_account_res_users_rel                                     | PRIMARY KEY (iap_account_id, res_users_id)
 iap_account_res_users_rel_iap_account_id_fkey                   | iap_account_res_users_rel                                     | FOREIGN KEY (iap_account_id) REFERENCES iap_account(id) ON DELETE CASCADE
 iap_account_res_users_rel_res_users_id_fkey                     | iap_account_res_users_rel                                     | FOREIGN KEY (res_users_id) REFERENCES res_users(id) ON DELETE CASCADE
 iap_service_create_uid_fkey                                     | iap_service                                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 iap_service_write_uid_fkey                                      | iap_service                                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 iap_service_unique_technical_name                               | iap_service                                                   | UNIQUE (technical_name)
 iap_service_pkey                                                | iap_service                                                   | PRIMARY KEY (id)
 ir_act_client_path_unique                                       | ir_act_client                                                 | UNIQUE (path)
 ir_act_client_binding_model_id_fkey                             | ir_act_client                                                 | FOREIGN KEY (binding_model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 ir_act_client_create_uid_fkey                                   | ir_act_client                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_act_client_write_uid_fkey                                    | ir_act_client                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_act_client_pkey                                              | ir_act_client                                                 | PRIMARY KEY (id)
 ir_act_report_xml_path_unique                                   | ir_act_report_xml                                             | UNIQUE (path)
 ir_act_report_xml_paperformat_id_fkey                           | ir_act_report_xml                                             | FOREIGN KEY (paperformat_id) REFERENCES report_paperformat(id) ON DELETE SET NULL
 ir_act_report_xml_binding_model_id_fkey                         | ir_act_report_xml                                             | FOREIGN KEY (binding_model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 ir_act_report_xml_create_uid_fkey                               | ir_act_report_xml                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_act_report_xml_pkey                                          | ir_act_report_xml                                             | PRIMARY KEY (id)
 ir_act_report_xml_write_uid_fkey                                | ir_act_report_xml                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_act_server_binding_model_id_fkey                             | ir_act_server                                                 | FOREIGN KEY (binding_model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 ir_act_server_activity_type_id_fkey                             | ir_act_server                                                 | FOREIGN KEY (activity_type_id) REFERENCES mail_activity_type(id) ON DELETE RESTRICT
 ir_act_server_template_id_fkey                                  | ir_act_server                                                 | FOREIGN KEY (template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 ir_act_server_base_automation_id_fkey                           | ir_act_server                                                 | FOREIGN KEY (base_automation_id) REFERENCES base_automation(id) ON DELETE CASCADE
 ir_act_server_activity_user_id_fkey                             | ir_act_server                                                 | FOREIGN KEY (activity_user_id) REFERENCES res_users(id) ON DELETE SET NULL
 ir_act_server_wa_template_id_fkey                               | ir_act_server                                                 | FOREIGN KEY (wa_template_id) REFERENCES whatsapp_template(id) ON DELETE RESTRICT
 ir_act_server_path_unique                                       | ir_act_server                                                 | UNIQUE (path)
 ir_act_server_pkey                                              | ir_act_server                                                 | PRIMARY KEY (id)
 ir_act_server_create_uid_fkey                                   | ir_act_server                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_act_server_write_uid_fkey                                    | ir_act_server                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_act_server_model_id_fkey                                     | ir_act_server                                                 | FOREIGN KEY (model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 ir_act_server_sms_template_id_fkey                              | ir_act_server                                                 | FOREIGN KEY (sms_template_id) REFERENCES sms_template(id) ON DELETE SET NULL
 ir_act_server_crud_model_id_fkey                                | ir_act_server                                                 | FOREIGN KEY (crud_model_id) REFERENCES ir_model(id) ON DELETE SET NULL
 ir_act_server_link_field_id_fkey                                | ir_act_server                                                 | FOREIGN KEY (link_field_id) REFERENCES ir_model_fields(id) ON DELETE SET NULL
 ir_act_server_update_field_id_fkey                              | ir_act_server                                                 | FOREIGN KEY (update_field_id) REFERENCES ir_model_fields(id) ON DELETE CASCADE
 ir_act_server_update_related_model_id_fkey                      | ir_act_server                                                 | FOREIGN KEY (update_related_model_id) REFERENCES ir_model(id) ON DELETE SET NULL
 ir_act_server_selection_value_fkey                              | ir_act_server                                                 | FOREIGN KEY (selection_value) REFERENCES ir_model_fields_selection(id) ON DELETE CASCADE
 ir_act_server_group_rel_act_id_fkey                             | ir_act_server_group_rel                                       | FOREIGN KEY (act_id) REFERENCES ir_act_server(id) ON DELETE CASCADE
 ir_act_server_group_rel_gid_fkey                                | ir_act_server_group_rel                                       | FOREIGN KEY (gid) REFERENCES res_groups(id) ON DELETE CASCADE
 ir_act_server_group_rel_pkey                                    | ir_act_server_group_rel                                       | PRIMARY KEY (act_id, gid)
 ir_act_server_res_partner_rel_pkey                              | ir_act_server_res_partner_rel                                 | PRIMARY KEY (ir_act_server_id, res_partner_id)
 ir_act_server_res_partner_rel_ir_act_server_id_fkey             | ir_act_server_res_partner_rel                                 | FOREIGN KEY (ir_act_server_id) REFERENCES ir_act_server(id) ON DELETE CASCADE
 ir_act_server_res_partner_rel_res_partner_id_fkey               | ir_act_server_res_partner_rel                                 | FOREIGN KEY (res_partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 ir_act_server_webhook_field_rel_field_id_fkey                   | ir_act_server_webhook_field_rel                               | FOREIGN KEY (field_id) REFERENCES ir_model_fields(id) ON DELETE CASCADE
 ir_act_server_webhook_field_rel_pkey                            | ir_act_server_webhook_field_rel                               | PRIMARY KEY (server_id, field_id)
 ir_act_server_webhook_field_rel_server_id_fkey                  | ir_act_server_webhook_field_rel                               | FOREIGN KEY (server_id) REFERENCES ir_act_server(id) ON DELETE CASCADE
 ir_act_url_path_unique                                          | ir_act_url                                                    | UNIQUE (path)
 ir_act_url_binding_model_id_fkey                                | ir_act_url                                                    | FOREIGN KEY (binding_model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 ir_act_url_create_uid_fkey                                      | ir_act_url                                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_act_url_write_uid_fkey                                       | ir_act_url                                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_act_url_pkey                                                 | ir_act_url                                                    | PRIMARY KEY (id)
 ir_act_window_path_unique                                       | ir_act_window                                                 | UNIQUE (path)
 ir_act_window_binding_model_id_fkey                             | ir_act_window                                                 | FOREIGN KEY (binding_model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 ir_act_window_create_uid_fkey                                   | ir_act_window                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_act_window_view_id_fkey                                      | ir_act_window                                                 | FOREIGN KEY (view_id) REFERENCES ir_ui_view(id) ON DELETE SET NULL
 ir_act_window_search_view_id_fkey                               | ir_act_window                                                 | FOREIGN KEY (search_view_id) REFERENCES ir_ui_view(id) ON DELETE SET NULL
 ir_act_window_pkey                                              | ir_act_window                                                 | PRIMARY KEY (id)
 ir_act_window_write_uid_fkey                                    | ir_act_window                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_act_window_group_rel_gid_fkey                                | ir_act_window_group_rel                                       | FOREIGN KEY (gid) REFERENCES res_groups(id) ON DELETE CASCADE
 ir_act_window_group_rel_pkey                                    | ir_act_window_group_rel                                       | PRIMARY KEY (act_id, gid)
 ir_act_window_group_rel_act_id_fkey                             | ir_act_window_group_rel                                       | FOREIGN KEY (act_id) REFERENCES ir_act_window(id) ON DELETE CASCADE
 ir_act_window_view_view_id_fkey                                 | ir_act_window_view                                            | FOREIGN KEY (view_id) REFERENCES ir_ui_view(id) ON DELETE SET NULL
 ir_act_window_view_pkey                                         | ir_act_window_view                                            | PRIMARY KEY (id)
 ir_act_window_view_act_window_id_fkey                           | ir_act_window_view                                            | FOREIGN KEY (act_window_id) REFERENCES ir_act_window(id) ON DELETE CASCADE
 ir_act_window_view_create_uid_fkey                              | ir_act_window_view                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_act_window_view_write_uid_fkey                               | ir_act_window_view                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_actions_path_unique                                          | ir_actions                                                    | UNIQUE (path)
 ir_actions_binding_model_id_fkey                                | ir_actions                                                    | FOREIGN KEY (binding_model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 ir_actions_create_uid_fkey                                      | ir_actions                                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_actions_write_uid_fkey                                       | ir_actions                                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_actions_pkey                                                 | ir_actions                                                    | PRIMARY KEY (id)
 ir_actions_todo_pkey                                            | ir_actions_todo                                               | PRIMARY KEY (id)
 ir_actions_todo_write_uid_fkey                                  | ir_actions_todo                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_actions_todo_create_uid_fkey                                 | ir_actions_todo                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_asset_create_uid_fkey                                        | ir_asset                                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_asset_website_id_fkey                                        | ir_asset                                                      | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE CASCADE
 ir_asset_theme_template_id_fkey                                 | ir_asset                                                      | FOREIGN KEY (theme_template_id) REFERENCES theme_ir_asset(id) ON DELETE SET NULL
 ir_asset_pkey                                                   | ir_asset                                                      | PRIMARY KEY (id)
 ir_asset_write_uid_fkey                                         | ir_asset                                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_attachment_pkey                                              | ir_attachment                                                 | PRIMARY KEY (id)
 ir_attachment_write_uid_fkey                                    | ir_attachment                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_attachment_original_id_fkey                                  | ir_attachment                                                 | FOREIGN KEY (original_id) REFERENCES ir_attachment(id) ON DELETE SET NULL
 ir_attachment_company_id_fkey                                   | ir_attachment                                                 | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 ir_attachment_create_uid_fkey                                   | ir_attachment                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_attachment_website_id_fkey                                   | ir_attachment                                                 | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE SET NULL
 ir_attachment_theme_template_id_fkey                            | ir_attachment                                                 | FOREIGN KEY (theme_template_id) REFERENCES theme_ir_attachment(id) ON DELETE SET NULL
 ir_attachment_whatsapp_template_rel_pkey                        | ir_attachment_whatsapp_template_rel                           | PRIMARY KEY (whatsapp_template_id, ir_attachment_id)
 ir_attachment_whatsapp_template_rel_ir_attachment_id_fkey       | ir_attachment_whatsapp_template_rel                           | FOREIGN KEY (ir_attachment_id) REFERENCES ir_attachment(id) ON DELETE CASCADE
 ir_attachment_whatsapp_template_rel_whatsapp_template_id_fkey   | ir_attachment_whatsapp_template_rel                           | FOREIGN KEY (whatsapp_template_id) REFERENCES whatsapp_template(id) ON DELETE CASCADE
 ir_config_parameter_create_uid_fkey                             | ir_config_parameter                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_config_parameter_write_uid_fkey                              | ir_config_parameter                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_config_parameter_pkey                                        | ir_config_parameter                                           | PRIMARY KEY (id)
 ir_config_parameter_key_uniq                                    | ir_config_parameter                                           | UNIQUE (key)
 ir_cron_user_id_fkey                                            | ir_cron                                                       | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE RESTRICT
 ir_cron_pkey                                                    | ir_cron                                                       | PRIMARY KEY (id)
 ir_cron_check_strictly_positive_interval                        | ir_cron                                                       | CHECK ((interval_number > 0))
 ir_cron_create_uid_fkey                                         | ir_cron                                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_cron_write_uid_fkey                                          | ir_cron                                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_cron_ir_actions_server_id_fkey                               | ir_cron                                                       | FOREIGN KEY (ir_actions_server_id) REFERENCES ir_act_server(id) ON DELETE RESTRICT
 ir_cron_progress_write_uid_fkey                                 | ir_cron_progress                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_cron_progress_pkey                                           | ir_cron_progress                                              | PRIMARY KEY (id)
 ir_cron_progress_create_uid_fkey                                | ir_cron_progress                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_cron_progress_cron_id_fkey                                   | ir_cron_progress                                              | FOREIGN KEY (cron_id) REFERENCES ir_cron(id) ON DELETE CASCADE
 ir_cron_trigger_pkey                                            | ir_cron_trigger                                               | PRIMARY KEY (id)
 ir_cron_trigger_write_uid_fkey                                  | ir_cron_trigger                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_cron_trigger_create_uid_fkey                                 | ir_cron_trigger                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_cron_trigger_cron_id_fkey                                    | ir_cron_trigger                                               | FOREIGN KEY (cron_id) REFERENCES ir_cron(id) ON DELETE SET NULL
 ir_default_user_id_fkey                                         | ir_default                                                    | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 ir_default_field_id_fkey                                        | ir_default                                                    | FOREIGN KEY (field_id) REFERENCES ir_model_fields(id) ON DELETE CASCADE
 ir_default_write_uid_fkey                                       | ir_default                                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_default_pkey                                                 | ir_default                                                    | PRIMARY KEY (id)
 ir_default_create_uid_fkey                                      | ir_default                                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_default_company_id_fkey                                      | ir_default                                                    | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE CASCADE
 ir_demo_pkey                                                    | ir_demo                                                       | PRIMARY KEY (id)
 ir_demo_create_uid_fkey                                         | ir_demo                                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_demo_write_uid_fkey                                          | ir_demo                                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_demo_failure_write_uid_fkey                                  | ir_demo_failure                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_demo_failure_pkey                                            | ir_demo_failure                                               | PRIMARY KEY (id)
 ir_demo_failure_module_id_fkey                                  | ir_demo_failure                                               | FOREIGN KEY (module_id) REFERENCES ir_module_module(id) ON DELETE CASCADE
 ir_demo_failure_wizard_id_fkey                                  | ir_demo_failure                                               | FOREIGN KEY (wizard_id) REFERENCES ir_demo_failure_wizard(id) ON DELETE SET NULL
 ir_demo_failure_create_uid_fkey                                 | ir_demo_failure                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_demo_failure_wizard_write_uid_fkey                           | ir_demo_failure_wizard                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_demo_failure_wizard_pkey                                     | ir_demo_failure_wizard                                        | PRIMARY KEY (id)
 ir_demo_failure_wizard_create_uid_fkey                          | ir_demo_failure_wizard                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_embedded_actions_pkey                                        | ir_embedded_actions                                           | PRIMARY KEY (id)
 ir_embedded_actions_parent_action_id_fkey                       | ir_embedded_actions                                           | FOREIGN KEY (parent_action_id) REFERENCES ir_act_window(id) ON DELETE CASCADE
 ir_embedded_actions_check_python_method_requires_name           | ir_embedded_actions                                           | CHECK ((NOT ((python_method IS NOT NULL) AND (name IS NULL))))
 ir_embedded_actions_create_uid_fkey                             | ir_embedded_actions                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_embedded_actions_user_id_fkey                                | ir_embedded_actions                                           | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 ir_embedded_actions_check_only_one_action_defined               | ir_embedded_actions                                           | CHECK ((((action_id IS NOT NULL) AND (python_method IS NULL)) OR ((action_id IS NULL) AND (python_method IS NOT NULL))))
 ir_embedded_actions_write_uid_fkey                              | ir_embedded_actions                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_embedded_actions_res_groups_rel_pkey                         | ir_embedded_actions_res_groups_rel                            | PRIMARY KEY (ir_embedded_actions_id, res_groups_id)
 ir_embedded_actions_res_groups_rel_res_groups_id_fkey           | ir_embedded_actions_res_groups_rel                            | FOREIGN KEY (res_groups_id) REFERENCES res_groups(id) ON DELETE CASCADE
 ir_embedded_actions_res_groups_rel_ir_embedded_actions_id_fkey  | ir_embedded_actions_res_groups_rel                            | FOREIGN KEY (ir_embedded_actions_id) REFERENCES ir_embedded_actions(id) ON DELETE CASCADE
 ir_exports_create_uid_fkey                                      | ir_exports                                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_exports_pkey                                                 | ir_exports                                                    | PRIMARY KEY (id)
 ir_exports_write_uid_fkey                                       | ir_exports                                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_exports_line_export_id_fkey                                  | ir_exports_line                                               | FOREIGN KEY (export_id) REFERENCES ir_exports(id) ON DELETE CASCADE
 ir_exports_line_create_uid_fkey                                 | ir_exports_line                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_exports_line_write_uid_fkey                                  | ir_exports_line                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_exports_line_pkey                                            | ir_exports_line                                               | PRIMARY KEY (id)
 ir_filters_user_id_fkey                                         | ir_filters                                                    | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 ir_filters_embedded_action_id_fkey                              | ir_filters                                                    | FOREIGN KEY (embedded_action_id) REFERENCES ir_embedded_actions(id) ON DELETE CASCADE
 ir_filters_create_uid_fkey                                      | ir_filters                                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_filters_write_uid_fkey                                       | ir_filters                                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_filters_check_sort_json                                      | ir_filters                                                    | CHECK (((sort IS NULL) OR (jsonb_typeof((sort)::jsonb) = 'array'::text)))
 ir_filters_check_res_id_only_when_embedded_action               | ir_filters                                                    | CHECK ((NOT ((embedded_parent_res_id IS NOT NULL) AND (embedded_action_id IS NULL))))
 ir_filters_name_model_uid_unique                                | ir_filters                                                    | UNIQUE (model_id, user_id, action_id, embedded_action_id, embedded_parent_res_id, name)
 ir_filters_pkey                                                 | ir_filters                                                    | PRIMARY KEY (id)
 ir_logging_pkey                                                 | ir_logging                                                    | PRIMARY KEY (id)
 ir_mail_server_create_uid_fkey                                  | ir_mail_server                                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_mail_server_write_uid_fkey                                   | ir_mail_server                                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_mail_server_pkey                                             | ir_mail_server                                                | PRIMARY KEY (id)
 ir_mail_server_certificate_requires_tls                         | ir_mail_server                                                | CHECK ((((smtp_encryption)::text <> 'none'::text) OR ((smtp_authentication)::text <> 'certificate'::text)))
 ir_model_write_uid_fkey                                         | ir_model                                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_model_website_form_default_field_id_fkey                     | ir_model                                                      | FOREIGN KEY (website_form_default_field_id) REFERENCES ir_model_fields(id) ON DELETE SET NULL
 ir_model_create_uid_fkey                                        | ir_model                                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_model_pkey                                                   | ir_model                                                      | PRIMARY KEY (id)
 ir_model_obj_name_uniq                                          | ir_model                                                      | UNIQUE (model)
 ir_model_access_create_uid_fkey                                 | ir_model_access                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_model_access_write_uid_fkey                                  | ir_model_access                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_model_access_pkey                                            | ir_model_access                                               | PRIMARY KEY (id)
 ir_model_access_model_id_fkey                                   | ir_model_access                                               | FOREIGN KEY (model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 ir_model_access_group_id_fkey                                   | ir_model_access                                               | FOREIGN KEY (group_id) REFERENCES res_groups(id) ON DELETE RESTRICT
 ir_model_constraint_create_uid_fkey                             | ir_model_constraint                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_model_constraint_write_uid_fkey                              | ir_model_constraint                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_model_constraint_module_name_uniq                            | ir_model_constraint                                           | UNIQUE (name, module)
 ir_model_constraint_pkey                                        | ir_model_constraint                                           | PRIMARY KEY (id)
 ir_model_constraint_model_fkey                                  | ir_model_constraint                                           | FOREIGN KEY (model) REFERENCES ir_model(id) ON DELETE CASCADE
 ir_model_constraint_module_fkey                                 | ir_model_constraint                                           | FOREIGN KEY (module) REFERENCES ir_module_module(id) ON DELETE CASCADE
 ir_model_data_write_uid_fkey                                    | ir_model_data                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_model_data_create_uid_fkey                                   | ir_model_data                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_model_data_name_nospaces                                     | ir_model_data                                                 | CHECK (((name)::text !~~ '% %'::text))
 ir_model_data_pkey                                              | ir_model_data                                                 | PRIMARY KEY (id)
 ir_model_fields_pkey                                            | ir_model_fields                                               | PRIMARY KEY (id)
 ir_model_fields_related_field_id_fkey                           | ir_model_fields                                               | FOREIGN KEY (related_field_id) REFERENCES ir_model_fields(id) ON DELETE CASCADE
 ir_model_fields_model_id_fkey                                   | ir_model_fields                                               | FOREIGN KEY (model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 ir_model_fields_relation_field_id_fkey                          | ir_model_fields                                               | FOREIGN KEY (relation_field_id) REFERENCES ir_model_fields(id) ON DELETE CASCADE
 ir_model_fields_name_manual_field                               | ir_model_fields                                               | CHECK ((((state)::text <> 'manual'::text) OR ((name)::text ~~ 'x\_%'::text)))
 ir_model_fields_size_gt_zero                                    | ir_model_fields                                               | CHECK ((size >= 0))
 ir_model_fields_name_unique                                     | ir_model_fields                                               | UNIQUE (model, name)
 ir_model_fields_write_uid_fkey                                  | ir_model_fields                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_model_fields_create_uid_fkey                                 | ir_model_fields                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_model_fields_group_rel_pkey                                  | ir_model_fields_group_rel                                     | PRIMARY KEY (field_id, group_id)
 ir_model_fields_group_rel_group_id_fkey                         | ir_model_fields_group_rel                                     | FOREIGN KEY (group_id) REFERENCES res_groups(id) ON DELETE CASCADE
 ir_model_fields_group_rel_field_id_fkey                         | ir_model_fields_group_rel                                     | FOREIGN KEY (field_id) REFERENCES ir_model_fields(id) ON DELETE CASCADE
 ir_model_fields_selection_write_uid_fkey                        | ir_model_fields_selection                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_model_fields_selection_create_uid_fkey                       | ir_model_fields_selection                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_model_fields_selection_pkey                                  | ir_model_fields_selection                                     | PRIMARY KEY (id)
 ir_model_fields_selection_field_id_fkey                         | ir_model_fields_selection                                     | FOREIGN KEY (field_id) REFERENCES ir_model_fields(id) ON DELETE CASCADE
 ir_model_fields_selection_selection_field_uniq                  | ir_model_fields_selection                                     | UNIQUE (field_id, value)
 ir_model_fields_studio_export_model_studio_export_model_id_fkey | ir_model_fields_studio_export_model_rel                       | FOREIGN KEY (studio_export_model_id) REFERENCES studio_export_model(id) ON DELETE CASCADE
 ir_model_fields_studio_export_model_rel_pkey                    | ir_model_fields_studio_export_model_rel                       | PRIMARY KEY (studio_export_model_id, ir_model_fields_id)
 ir_model_fields_studio_export_model_rel_ir_model_fields_id_fkey | ir_model_fields_studio_export_model_rel                       | FOREIGN KEY (ir_model_fields_id) REFERENCES ir_model_fields(id) ON DELETE CASCADE
 ir_model_inherit_pkey                                           | ir_model_inherit                                              | PRIMARY KEY (id)
 ir_model_inherit_parent_field_id_fkey                           | ir_model_inherit                                              | FOREIGN KEY (parent_field_id) REFERENCES ir_model_fields(id) ON DELETE CASCADE
 ir_model_inherit_parent_id_fkey                                 | ir_model_inherit                                              | FOREIGN KEY (parent_id) REFERENCES ir_model(id) ON DELETE CASCADE
 ir_model_inherit_model_id_fkey                                  | ir_model_inherit                                              | FOREIGN KEY (model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 ir_model_inherit_uniq                                           | ir_model_inherit                                              | UNIQUE (model_id, parent_id)
 ir_model_relation_write_uid_fkey                                | ir_model_relation                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_model_relation_model_fkey                                    | ir_model_relation                                             | FOREIGN KEY (model) REFERENCES ir_model(id) ON DELETE CASCADE
 ir_model_relation_module_fkey                                   | ir_model_relation                                             | FOREIGN KEY (module) REFERENCES ir_module_module(id) ON DELETE CASCADE
 ir_model_relation_create_uid_fkey                               | ir_model_relation                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_model_relation_pkey                                          | ir_model_relation                                             | PRIMARY KEY (id)
 ir_model_spreadsheet_dashboard_re_spreadsheet_dashboard_id_fkey | ir_model_spreadsheet_dashboard_rel                            | FOREIGN KEY (spreadsheet_dashboard_id) REFERENCES spreadsheet_dashboard(id) ON DELETE CASCADE
 ir_model_spreadsheet_dashboard_rel_ir_model_id_fkey             | ir_model_spreadsheet_dashboard_rel                            | FOREIGN KEY (ir_model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 ir_model_spreadsheet_dashboard_rel_pkey                         | ir_model_spreadsheet_dashboard_rel                            | PRIMARY KEY (spreadsheet_dashboard_id, ir_model_id)
 ir_module_category_pkey                                         | ir_module_category                                            | PRIMARY KEY (id)
 ir_module_category_create_uid_fkey                              | ir_module_category                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_module_category_parent_id_fkey                               | ir_module_category                                            | FOREIGN KEY (parent_id) REFERENCES ir_module_category(id) ON DELETE SET NULL
 ir_module_category_write_uid_fkey                               | ir_module_category                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_module_module_create_uid_fkey                                | ir_module_module                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_module_module_write_uid_fkey                                 | ir_module_module                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_module_module_name_uniq                                      | ir_module_module                                              | UNIQUE (name)
 ir_module_module_category_id_fkey                               | ir_module_module                                              | FOREIGN KEY (category_id) REFERENCES ir_module_category(id) ON DELETE SET NULL
 ir_module_module_pkey                                           | ir_module_module                                              | PRIMARY KEY (id)
 ir_module_module_dependency_module_id_fkey                      | ir_module_module_dependency                                   | FOREIGN KEY (module_id) REFERENCES ir_module_module(id) ON DELETE CASCADE
 ir_module_module_dependency_pkey                                | ir_module_module_dependency                                   | PRIMARY KEY (id)
 ir_module_module_exclusion_pkey                                 | ir_module_module_exclusion                                    | PRIMARY KEY (id)
 ir_module_module_exclusion_module_id_fkey                       | ir_module_module_exclusion                                    | FOREIGN KEY (module_id) REFERENCES ir_module_module(id) ON DELETE CASCADE
 ir_module_module_exclusion_create_uid_fkey                      | ir_module_module_exclusion                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_module_module_exclusion_write_uid_fkey                       | ir_module_module_exclusion                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_profile_pkey                                                 | ir_profile                                                    | PRIMARY KEY (id)
 ir_rule_write_uid_fkey                                          | ir_rule                                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_rule_create_uid_fkey                                         | ir_rule                                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_rule_pkey                                                    | ir_rule                                                       | PRIMARY KEY (id)
 ir_rule_model_id_fkey                                           | ir_rule                                                       | FOREIGN KEY (model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 ir_rule_no_access_rights                                        | ir_rule                                                       | CHECK (((perm_read <> false) OR (perm_write <> false) OR (perm_create <> false) OR (perm_unlink <> false)))
 ir_sequence_company_id_fkey                                     | ir_sequence                                                   | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 ir_sequence_create_uid_fkey                                     | ir_sequence                                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_sequence_pkey                                                | ir_sequence                                                   | PRIMARY KEY (id)
 ir_sequence_write_uid_fkey                                      | ir_sequence                                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_sequence_date_range_create_uid_fkey                          | ir_sequence_date_range                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_sequence_date_range_unique_range_per_sequence                | ir_sequence_date_range                                        | UNIQUE (sequence_id, date_from, date_to)
 ir_sequence_date_range_sequence_id_fkey                         | ir_sequence_date_range                                        | FOREIGN KEY (sequence_id) REFERENCES ir_sequence(id) ON DELETE CASCADE
 ir_sequence_date_range_pkey                                     | ir_sequence_date_range                                        | PRIMARY KEY (id)
 ir_sequence_date_range_write_uid_fkey                           | ir_sequence_date_range                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_ui_menu_parent_id_fkey                                       | ir_ui_menu                                                    | FOREIGN KEY (parent_id) REFERENCES ir_ui_menu(id) ON DELETE RESTRICT
 ir_ui_menu_create_uid_fkey                                      | ir_ui_menu                                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_ui_menu_write_uid_fkey                                       | ir_ui_menu                                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_ui_menu_pkey                                                 | ir_ui_menu                                                    | PRIMARY KEY (id)
 ir_ui_menu_group_rel_menu_id_fkey                               | ir_ui_menu_group_rel                                          | FOREIGN KEY (menu_id) REFERENCES ir_ui_menu(id) ON DELETE CASCADE
 ir_ui_menu_group_rel_gid_fkey                                   | ir_ui_menu_group_rel                                          | FOREIGN KEY (gid) REFERENCES res_groups(id) ON DELETE CASCADE
 ir_ui_menu_group_rel_pkey                                       | ir_ui_menu_group_rel                                          | PRIMARY KEY (menu_id, gid)
 ir_ui_view_create_uid_fkey                                      | ir_ui_view                                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_ui_view_inheritance_mode                                     | ir_ui_view                                                    | CHECK ((((mode)::text <> 'extension'::text) OR (inherit_id IS NOT NULL)))
 ir_ui_view_inherit_id_fkey                                      | ir_ui_view                                                    | FOREIGN KEY (inherit_id) REFERENCES ir_ui_view(id) ON DELETE RESTRICT
 ir_ui_view_theme_template_id_fkey                               | ir_ui_view                                                    | FOREIGN KEY (theme_template_id) REFERENCES theme_ir_ui_view(id) ON DELETE SET NULL
 ir_ui_view_pkey                                                 | ir_ui_view                                                    | PRIMARY KEY (id)
 ir_ui_view_qweb_required_key                                    | ir_ui_view                                                    | CHECK ((((type)::text <> 'qweb'::text) OR (key IS NOT NULL)))
 ir_ui_view_write_uid_fkey                                       | ir_ui_view                                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_ui_view_website_id_fkey                                      | ir_ui_view                                                    | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE CASCADE
 ir_ui_view_custom_user_id_fkey                                  | ir_ui_view_custom                                             | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 ir_ui_view_custom_pkey                                          | ir_ui_view_custom                                             | PRIMARY KEY (id)
 ir_ui_view_custom_ref_id_fkey                                   | ir_ui_view_custom                                             | FOREIGN KEY (ref_id) REFERENCES ir_ui_view(id) ON DELETE CASCADE
 ir_ui_view_custom_write_uid_fkey                                | ir_ui_view_custom                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_ui_view_custom_create_uid_fkey                               | ir_ui_view_custom                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 ir_ui_view_group_rel_group_id_fkey                              | ir_ui_view_group_rel                                          | FOREIGN KEY (group_id) REFERENCES res_groups(id) ON DELETE CASCADE
 ir_ui_view_group_rel_view_id_fkey                               | ir_ui_view_group_rel                                          | FOREIGN KEY (view_id) REFERENCES ir_ui_view(id) ON DELETE CASCADE
 ir_ui_view_group_rel_pkey                                       | ir_ui_view_group_rel                                          | PRIMARY KEY (view_id, group_id)
 job_favorite_user_rel_user_id_fkey                              | job_favorite_user_rel                                         | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 job_favorite_user_rel_job_id_fkey                               | job_favorite_user_rel                                         | FOREIGN KEY (job_id) REFERENCES hr_job(id) ON DELETE CASCADE
 job_favorite_user_rel_pkey                                      | job_favorite_user_rel                                         | PRIMARY KEY (job_id, user_id)
 journal_account_control_rel_account_id_fkey                     | journal_account_control_rel                                   | FOREIGN KEY (account_id) REFERENCES account_account(id) ON DELETE CASCADE
 journal_account_control_rel_pkey                                | journal_account_control_rel                                   | PRIMARY KEY (journal_id, account_id)
 journal_account_control_rel_journal_id_fkey                     | journal_account_control_rel                                   | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE CASCADE
 link_tracker_create_uid_fkey                                    | link_tracker                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 link_tracker_campaign_id_fkey                                   | link_tracker                                                  | FOREIGN KEY (campaign_id) REFERENCES utm_campaign(id) ON DELETE SET NULL
 link_tracker_source_id_fkey                                     | link_tracker                                                  | FOREIGN KEY (source_id) REFERENCES utm_source(id) ON DELETE SET NULL
 link_tracker_medium_id_fkey                                     | link_tracker                                                  | FOREIGN KEY (medium_id) REFERENCES utm_medium(id) ON DELETE SET NULL
 link_tracker_pkey                                               | link_tracker                                                  | PRIMARY KEY (id)
 link_tracker_write_uid_fkey                                     | link_tracker                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 link_tracker_mass_mailing_id_fkey                               | link_tracker                                                  | FOREIGN KEY (mass_mailing_id) REFERENCES mailing_mailing(id) ON DELETE SET NULL
 link_tracker_click_create_uid_fkey                              | link_tracker_click                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 link_tracker_click_whatsapp_message_id_fkey                     | link_tracker_click                                            | FOREIGN KEY (whatsapp_message_id) REFERENCES whatsapp_message(id) ON DELETE SET NULL
 link_tracker_click_mass_mailing_id_fkey                         | link_tracker_click                                            | FOREIGN KEY (mass_mailing_id) REFERENCES mailing_mailing(id) ON DELETE SET NULL
 link_tracker_click_mailing_trace_id_fkey                        | link_tracker_click                                            | FOREIGN KEY (mailing_trace_id) REFERENCES mailing_trace(id) ON DELETE SET NULL
 link_tracker_click_write_uid_fkey                               | link_tracker_click                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 link_tracker_click_country_id_fkey                              | link_tracker_click                                            | FOREIGN KEY (country_id) REFERENCES res_country(id) ON DELETE SET NULL
 link_tracker_click_link_id_fkey                                 | link_tracker_click                                            | FOREIGN KEY (link_id) REFERENCES link_tracker(id) ON DELETE CASCADE
 link_tracker_click_campaign_id_fkey                             | link_tracker_click                                            | FOREIGN KEY (campaign_id) REFERENCES utm_campaign(id) ON DELETE SET NULL
 link_tracker_click_pkey                                         | link_tracker_click                                            | PRIMARY KEY (id)
 link_tracker_code_pkey                                          | link_tracker_code                                             | PRIMARY KEY (id)
 link_tracker_code_create_uid_fkey                               | link_tracker_code                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 link_tracker_code_link_id_fkey                                  | link_tracker_code                                             | FOREIGN KEY (link_id) REFERENCES link_tracker(id) ON DELETE CASCADE
 link_tracker_code_code                                          | link_tracker_code                                             | UNIQUE (code)
 link_tracker_code_write_uid_fkey                                | link_tracker_code                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 lot_label_layout_write_uid_fkey                                 | lot_label_layout                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 lot_label_layout_create_uid_fkey                                | lot_label_layout                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 lot_label_layout_pkey                                           | lot_label_layout                                              | PRIMARY KEY (id)
 lot_label_layout_stock_move_line_rel_stock_move_line_id_fkey    | lot_label_layout_stock_move_line_rel                          | FOREIGN KEY (stock_move_line_id) REFERENCES stock_move_line(id) ON DELETE CASCADE
 lot_label_layout_stock_move_line_rel_pkey                       | lot_label_layout_stock_move_line_rel                          | PRIMARY KEY (lot_label_layout_id, stock_move_line_id)
 lot_label_layout_stock_move_line_rel_lot_label_layout_id_fkey   | lot_label_layout_stock_move_line_rel                          | FOREIGN KEY (lot_label_layout_id) REFERENCES lot_label_layout(id) ON DELETE CASCADE
 mail_activity_create_uid_fkey                                   | mail_activity                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_activity_res_model_id_fkey                                 | mail_activity                                                 | FOREIGN KEY (res_model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 mail_activity_activity_type_id_fkey                             | mail_activity                                                 | FOREIGN KEY (activity_type_id) REFERENCES mail_activity_type(id) ON DELETE RESTRICT
 mail_activity_user_id_fkey                                      | mail_activity                                                 | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 mail_activity_request_partner_id_fkey                           | mail_activity                                                 | FOREIGN KEY (request_partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 mail_activity_recommended_activity_type_id_fkey                 | mail_activity                                                 | FOREIGN KEY (recommended_activity_type_id) REFERENCES mail_activity_type(id) ON DELETE SET NULL
 mail_activity_previous_activity_type_id_fkey                    | mail_activity                                                 | FOREIGN KEY (previous_activity_type_id) REFERENCES mail_activity_type(id) ON DELETE SET NULL
 mail_activity_calendar_event_id_fkey                            | mail_activity                                                 | FOREIGN KEY (calendar_event_id) REFERENCES calendar_event(id) ON DELETE CASCADE
 mail_activity_write_uid_fkey                                    | mail_activity                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_activity_check_res_id_is_set                               | mail_activity                                                 | CHECK (((res_id IS NOT NULL) AND (res_id <> 0)))
 mail_activity_pkey                                              | mail_activity                                                 | PRIMARY KEY (id)
 mail_activity_plan_pkey                                         | mail_activity_plan                                            | PRIMARY KEY (id)
 mail_activity_plan_company_id_fkey                              | mail_activity_plan                                            | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 mail_activity_plan_res_model_id_fkey                            | mail_activity_plan                                            | FOREIGN KEY (res_model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 mail_activity_plan_create_uid_fkey                              | mail_activity_plan                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_activity_plan_write_uid_fkey                               | mail_activity_plan                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_activity_plan_department_id_fkey                           | mail_activity_plan                                            | FOREIGN KEY (department_id) REFERENCES hr_department(id) ON DELETE CASCADE
 mail_activity_plan_mail_activity_schedule_rel_pkey              | mail_activity_plan_mail_activity_schedule_rel                 | PRIMARY KEY (mail_activity_schedule_id, mail_activity_plan_id)
 mail_activity_plan_mail_activity_mail_activity_schedule_id_fkey | mail_activity_plan_mail_activity_schedule_rel                 | FOREIGN KEY (mail_activity_schedule_id) REFERENCES mail_activity_schedule(id) ON DELETE CASCADE
 mail_activity_plan_mail_activity_sch_mail_activity_plan_id_fkey | mail_activity_plan_mail_activity_schedule_rel                 | FOREIGN KEY (mail_activity_plan_id) REFERENCES mail_activity_plan(id) ON DELETE CASCADE
 mail_activity_plan_template_plan_id_fkey                        | mail_activity_plan_template                                   | FOREIGN KEY (plan_id) REFERENCES mail_activity_plan(id) ON DELETE CASCADE
 mail_activity_plan_template_activity_type_id_fkey               | mail_activity_plan_template                                   | FOREIGN KEY (activity_type_id) REFERENCES mail_activity_type(id) ON DELETE RESTRICT
 mail_activity_plan_template_responsible_id_fkey                 | mail_activity_plan_template                                   | FOREIGN KEY (responsible_id) REFERENCES res_users(id) ON DELETE SET NULL
 mail_activity_plan_template_create_uid_fkey                     | mail_activity_plan_template                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_activity_plan_template_write_uid_fkey                      | mail_activity_plan_template                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_activity_plan_template_pkey                                | mail_activity_plan_template                                   | PRIMARY KEY (id)
 mail_activity_rel_recommended_id_fkey                           | mail_activity_rel                                             | FOREIGN KEY (recommended_id) REFERENCES mail_activity_type(id) ON DELETE CASCADE
 mail_activity_rel_pkey                                          | mail_activity_rel                                             | PRIMARY KEY (activity_id, recommended_id)
 mail_activity_rel_activity_id_fkey                              | mail_activity_rel                                             | FOREIGN KEY (activity_id) REFERENCES mail_activity_type(id) ON DELETE CASCADE
 mail_activity_schedule_activity_user_id_fkey                    | mail_activity_schedule                                        | FOREIGN KEY (activity_user_id) REFERENCES res_users(id) ON DELETE SET NULL
 mail_activity_schedule_pkey                                     | mail_activity_schedule                                        | PRIMARY KEY (id)
 mail_activity_schedule_activity_type_id_fkey                    | mail_activity_schedule                                        | FOREIGN KEY (activity_type_id) REFERENCES mail_activity_type(id) ON DELETE SET NULL
 mail_activity_schedule_write_uid_fkey                           | mail_activity_schedule                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_activity_schedule_plan_id_fkey                             | mail_activity_schedule                                        | FOREIGN KEY (plan_id) REFERENCES mail_activity_plan(id) ON DELETE SET NULL
 mail_activity_schedule_res_model_id_fkey                        | mail_activity_schedule                                        | FOREIGN KEY (res_model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 mail_activity_schedule_plan_on_demand_user_id_fkey              | mail_activity_schedule                                        | FOREIGN KEY (plan_on_demand_user_id) REFERENCES res_users(id) ON DELETE SET NULL
 mail_activity_schedule_create_uid_fkey                          | mail_activity_schedule                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_activity_todo_create_pkey                                  | mail_activity_todo_create                                     | PRIMARY KEY (id)
 mail_activity_todo_create_write_uid_fkey                        | mail_activity_todo_create                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_activity_todo_create_create_uid_fkey                       | mail_activity_todo_create                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_activity_todo_create_user_id_fkey                          | mail_activity_todo_create                                     | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 mail_activity_type_create_uid_fkey                              | mail_activity_type                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_activity_type_write_uid_fkey                               | mail_activity_type                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_activity_type_default_user_id_fkey                         | mail_activity_type                                            | FOREIGN KEY (default_user_id) REFERENCES res_users(id) ON DELETE SET NULL
 mail_activity_type_triggered_next_type_id_fkey                  | mail_activity_type                                            | FOREIGN KEY (triggered_next_type_id) REFERENCES mail_activity_type(id) ON DELETE RESTRICT
 mail_activity_type_folder_id_fkey                               | mail_activity_type                                            | FOREIGN KEY (folder_id) REFERENCES documents_document(id) ON DELETE SET NULL
 mail_activity_type_pkey                                         | mail_activity_type                                            | PRIMARY KEY (id)
 mail_activity_type_mail_template_rel_pkey                       | mail_activity_type_mail_template_rel                          | PRIMARY KEY (mail_activity_type_id, mail_template_id)
 mail_activity_type_mail_template_rel_mail_activity_type_id_fkey | mail_activity_type_mail_template_rel                          | FOREIGN KEY (mail_activity_type_id) REFERENCES mail_activity_type(id) ON DELETE CASCADE
 mail_activity_type_mail_template_rel_mail_template_id_fkey      | mail_activity_type_mail_template_rel                          | FOREIGN KEY (mail_template_id) REFERENCES mail_template(id) ON DELETE CASCADE
 mail_alias_create_uid_fkey                                      | mail_alias                                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_alias_pkey                                                 | mail_alias                                                    | PRIMARY KEY (id)
 mail_alias_alias_domain_id_fkey                                 | mail_alias                                                    | FOREIGN KEY (alias_domain_id) REFERENCES mail_alias_domain(id) ON DELETE RESTRICT
 mail_alias_alias_model_id_fkey                                  | mail_alias                                                    | FOREIGN KEY (alias_model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 mail_alias_alias_parent_model_id_fkey                           | mail_alias                                                    | FOREIGN KEY (alias_parent_model_id) REFERENCES ir_model(id) ON DELETE SET NULL
 mail_alias_write_uid_fkey                                       | mail_alias                                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_alias_domain_write_uid_fkey                                | mail_alias_domain                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_alias_domain_catchall_email_uniques                        | mail_alias_domain                                             | UNIQUE (catchall_alias, name)
 mail_alias_domain_bounce_email_uniques                          | mail_alias_domain                                             | UNIQUE (bounce_alias, name)
 mail_alias_domain_pkey                                          | mail_alias_domain                                             | PRIMARY KEY (id)
 mail_alias_domain_create_uid_fkey                               | mail_alias_domain                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_blacklist_write_uid_fkey                                   | mail_blacklist                                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_blacklist_unique_email                                     | mail_blacklist                                                | UNIQUE (email)
 mail_blacklist_pkey                                             | mail_blacklist                                                | PRIMARY KEY (id)
 mail_blacklist_opt_out_reason_id_fkey                           | mail_blacklist                                                | FOREIGN KEY (opt_out_reason_id) REFERENCES mailing_subscription_optout(id) ON DELETE RESTRICT
 mail_blacklist_create_uid_fkey                                  | mail_blacklist                                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_blacklist_remove_create_uid_fkey                           | mail_blacklist_remove                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_blacklist_remove_pkey                                      | mail_blacklist_remove                                         | PRIMARY KEY (id)
 mail_blacklist_remove_write_uid_fkey                            | mail_blacklist_remove                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_canned_response_create_uid_fkey                            | mail_canned_response                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_canned_response_write_uid_fkey                             | mail_canned_response                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_canned_response_pkey                                       | mail_canned_response                                          | PRIMARY KEY (id)
 mail_canned_response_res_groups_rel_res_groups_id_fkey          | mail_canned_response_res_groups_rel                           | FOREIGN KEY (res_groups_id) REFERENCES res_groups(id) ON DELETE CASCADE
 mail_canned_response_res_groups_rel_pkey                        | mail_canned_response_res_groups_rel                           | PRIMARY KEY (mail_canned_response_id, res_groups_id)
 mail_canned_response_res_groups_re_mail_canned_response_id_fkey | mail_canned_response_res_groups_rel                           | FOREIGN KEY (mail_canned_response_id) REFERENCES mail_canned_response(id) ON DELETE CASCADE
 mail_compose_message_record_alias_domain_id_fkey                | mail_compose_message                                          | FOREIGN KEY (record_alias_domain_id) REFERENCES mail_alias_domain(id) ON DELETE SET NULL
 mail_compose_message_subtype_id_fkey                            | mail_compose_message                                          | FOREIGN KEY (subtype_id) REFERENCES mail_message_subtype(id) ON DELETE SET NULL
 mail_compose_message_mail_activity_type_id_fkey                 | mail_compose_message                                          | FOREIGN KEY (mail_activity_type_id) REFERENCES mail_activity_type(id) ON DELETE SET NULL
 mail_compose_message_record_company_id_fkey                     | mail_compose_message                                          | FOREIGN KEY (record_company_id) REFERENCES res_company(id) ON DELETE SET NULL
 mail_compose_message_mail_server_id_fkey                        | mail_compose_message                                          | FOREIGN KEY (mail_server_id) REFERENCES ir_mail_server(id) ON DELETE SET NULL
 mail_compose_message_create_uid_fkey                            | mail_compose_message                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_compose_message_pkey                                       | mail_compose_message                                          | PRIMARY KEY (id)
 mail_compose_message_write_uid_fkey                             | mail_compose_message                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_compose_message_res_domain_user_id_fkey                    | mail_compose_message                                          | FOREIGN KEY (res_domain_user_id) REFERENCES res_users(id) ON DELETE SET NULL
 mail_compose_message_author_id_fkey                             | mail_compose_message                                          | FOREIGN KEY (author_id) REFERENCES res_partner(id) ON DELETE SET NULL
 mail_compose_message_parent_id_fkey                             | mail_compose_message                                          | FOREIGN KEY (parent_id) REFERENCES mail_message(id) ON DELETE SET NULL
 mail_compose_message_template_id_fkey                           | mail_compose_message                                          | FOREIGN KEY (template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 mail_compose_message_marketing_activity_id_fkey                 | mail_compose_message                                          | FOREIGN KEY (marketing_activity_id) REFERENCES marketing_activity(id) ON DELETE SET NULL
 mail_compose_message_campaign_id_fkey                           | mail_compose_message                                          | FOREIGN KEY (campaign_id) REFERENCES utm_campaign(id) ON DELETE SET NULL
 mail_compose_message_mass_mailing_id_fkey                       | mail_compose_message                                          | FOREIGN KEY (mass_mailing_id) REFERENCES mailing_mailing(id) ON DELETE CASCADE
 mail_compose_message_ir_attachments_rel_pkey                    | mail_compose_message_ir_attachments_rel                       | PRIMARY KEY (wizard_id, attachment_id)
 mail_compose_message_ir_attachments_rel_wizard_id_fkey          | mail_compose_message_ir_attachments_rel                       | FOREIGN KEY (wizard_id) REFERENCES mail_compose_message(id) ON DELETE CASCADE
 mail_compose_message_ir_attachments_rel_attachment_id_fkey      | mail_compose_message_ir_attachments_rel                       | FOREIGN KEY (attachment_id) REFERENCES ir_attachment(id) ON DELETE CASCADE
 mail_compose_message_mailing_list_rel_pkey                      | mail_compose_message_mailing_list_rel                         | PRIMARY KEY (mail_compose_message_id, mailing_list_id)
 mail_compose_message_mailing_list__mail_compose_message_id_fkey | mail_compose_message_mailing_list_rel                         | FOREIGN KEY (mail_compose_message_id) REFERENCES mail_compose_message(id) ON DELETE CASCADE
 mail_compose_message_mailing_list_rel_mailing_list_id_fkey      | mail_compose_message_mailing_list_rel                         | FOREIGN KEY (mailing_list_id) REFERENCES mailing_list(id) ON DELETE CASCADE
 mail_compose_message_res_partner_rel_pkey                       | mail_compose_message_res_partner_rel                          | PRIMARY KEY (wizard_id, partner_id)
 mail_compose_message_res_partner_rel_partner_id_fkey            | mail_compose_message_res_partner_rel                          | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 mail_compose_message_res_partner_rel_wizard_id_fkey             | mail_compose_message_res_partner_rel                          | FOREIGN KEY (wizard_id) REFERENCES mail_compose_message(id) ON DELETE CASCADE
 mail_followers_pkey                                             | mail_followers                                                | PRIMARY KEY (id)
 mail_followers_mail_followers_res_partner_res_model_id_uniq     | mail_followers                                                | UNIQUE (res_model, res_id, partner_id)
 mail_followers_partner_id_fkey                                  | mail_followers                                                | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 mail_followers_mail_message_subtype_rel_pkey                    | mail_followers_mail_message_subtype_rel                       | PRIMARY KEY (mail_followers_id, mail_message_subtype_id)
 mail_followers_mail_message_subtype_rel_mail_followers_id_fkey  | mail_followers_mail_message_subtype_rel                       | FOREIGN KEY (mail_followers_id) REFERENCES mail_followers(id) ON DELETE CASCADE
 mail_followers_mail_message_subtyp_mail_message_subtype_id_fkey | mail_followers_mail_message_subtype_rel                       | FOREIGN KEY (mail_message_subtype_id) REFERENCES mail_message_subtype(id) ON DELETE CASCADE
 mail_gateway_allowed_pkey                                       | mail_gateway_allowed                                          | PRIMARY KEY (id)
 mail_gateway_allowed_create_uid_fkey                            | mail_gateway_allowed                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_gateway_allowed_write_uid_fkey                             | mail_gateway_allowed                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_guest_create_uid_fkey                                      | mail_guest                                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_guest_write_uid_fkey                                       | mail_guest                                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_guest_pkey                                                 | mail_guest                                                    | PRIMARY KEY (id)
 mail_guest_country_id_fkey                                      | mail_guest                                                    | FOREIGN KEY (country_id) REFERENCES res_country(id) ON DELETE SET NULL
 mail_ice_server_write_uid_fkey                                  | mail_ice_server                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_ice_server_create_uid_fkey                                 | mail_ice_server                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_ice_server_pkey                                            | mail_ice_server                                               | PRIMARY KEY (id)
 mail_link_preview_write_uid_fkey                                | mail_link_preview                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_link_preview_create_uid_fkey                               | mail_link_preview                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_link_preview_message_id_fkey                               | mail_link_preview                                             | FOREIGN KEY (message_id) REFERENCES mail_message(id) ON DELETE CASCADE
 mail_link_preview_pkey                                          | mail_link_preview                                             | PRIMARY KEY (id)
 mail_mail_write_uid_fkey                                        | mail_mail                                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_mail_create_uid_fkey                                       | mail_mail                                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_mail_mail_message_id_fkey                                  | mail_mail                                                     | FOREIGN KEY (mail_message_id) REFERENCES mail_message(id) ON DELETE CASCADE
 mail_mail_mailing_id_fkey                                       | mail_mail                                                     | FOREIGN KEY (mailing_id) REFERENCES mailing_mailing(id) ON DELETE SET NULL
 mail_mail_fetchmail_server_id_fkey                              | mail_mail                                                     | FOREIGN KEY (fetchmail_server_id) REFERENCES fetchmail_server(id) ON DELETE SET NULL
 mail_mail_pkey                                                  | mail_mail                                                     | PRIMARY KEY (id)
 mail_mail_res_partner_rel_mail_mail_id_fkey                     | mail_mail_res_partner_rel                                     | FOREIGN KEY (mail_mail_id) REFERENCES mail_mail(id) ON DELETE CASCADE
 mail_mail_res_partner_rel_pkey                                  | mail_mail_res_partner_rel                                     | PRIMARY KEY (mail_mail_id, res_partner_id)
 mail_mail_res_partner_rel_res_partner_id_fkey                   | mail_mail_res_partner_rel                                     | FOREIGN KEY (res_partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 mail_mass_mailing_list_rel_mailing_list_id_fkey                 | mail_mass_mailing_list_rel                                    | FOREIGN KEY (mailing_list_id) REFERENCES mailing_list(id) ON DELETE CASCADE
 mail_mass_mailing_list_rel_mailing_mailing_id_fkey              | mail_mass_mailing_list_rel                                    | FOREIGN KEY (mailing_mailing_id) REFERENCES mailing_mailing(id) ON DELETE CASCADE
 mail_mass_mailing_list_rel_pkey                                 | mail_mass_mailing_list_rel                                    | PRIMARY KEY (mailing_list_id, mailing_mailing_id)
 mail_message_write_uid_fkey                                     | mail_message                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_message_parent_id_fkey                                     | mail_message                                                  | FOREIGN KEY (parent_id) REFERENCES mail_message(id) ON DELETE SET NULL
 mail_message_record_alias_domain_id_fkey                        | mail_message                                                  | FOREIGN KEY (record_alias_domain_id) REFERENCES mail_alias_domain(id) ON DELETE SET NULL
 mail_message_record_company_id_fkey                             | mail_message                                                  | FOREIGN KEY (record_company_id) REFERENCES res_company(id) ON DELETE SET NULL
 mail_message_subtype_id_fkey                                    | mail_message                                                  | FOREIGN KEY (subtype_id) REFERENCES mail_message_subtype(id) ON DELETE SET NULL
 mail_message_mail_activity_type_id_fkey                         | mail_message                                                  | FOREIGN KEY (mail_activity_type_id) REFERENCES mail_activity_type(id) ON DELETE SET NULL
 mail_message_author_id_fkey                                     | mail_message                                                  | FOREIGN KEY (author_id) REFERENCES res_partner(id) ON DELETE SET NULL
 mail_message_author_guest_id_fkey                               | mail_message                                                  | FOREIGN KEY (author_guest_id) REFERENCES mail_guest(id) ON DELETE SET NULL
 mail_message_mail_server_id_fkey                                | mail_message                                                  | FOREIGN KEY (mail_server_id) REFERENCES ir_mail_server(id) ON DELETE SET NULL
 mail_message_create_uid_fkey                                    | mail_message                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_message_pkey                                               | mail_message                                                  | PRIMARY KEY (id)
 mail_message_reaction_message_id_fkey                           | mail_message_reaction                                         | FOREIGN KEY (message_id) REFERENCES mail_message(id) ON DELETE CASCADE
 mail_message_reaction_guest_id_fkey                             | mail_message_reaction                                         | FOREIGN KEY (guest_id) REFERENCES mail_guest(id) ON DELETE CASCADE
 mail_message_reaction_partner_or_guest_exists                   | mail_message_reaction                                         | CHECK ((((partner_id IS NOT NULL) AND (guest_id IS NULL)) OR ((partner_id IS NULL) AND (guest_id IS NOT NULL))))
 mail_message_reaction_pkey                                      | mail_message_reaction                                         | PRIMARY KEY (id)
 mail_message_reaction_partner_id_fkey                           | mail_message_reaction                                         | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 mail_message_res_partner_rel_res_partner_id_fkey                | mail_message_res_partner_rel                                  | FOREIGN KEY (res_partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 mail_message_res_partner_rel_mail_message_id_fkey               | mail_message_res_partner_rel                                  | FOREIGN KEY (mail_message_id) REFERENCES mail_message(id) ON DELETE CASCADE
 mail_message_res_partner_rel_pkey                               | mail_message_res_partner_rel                                  | PRIMARY KEY (mail_message_id, res_partner_id)
 mail_message_res_partner_starred_rel_mail_message_id_fkey       | mail_message_res_partner_starred_rel                          | FOREIGN KEY (mail_message_id) REFERENCES mail_message(id) ON DELETE CASCADE
 mail_message_res_partner_starred_rel_res_partner_id_fkey        | mail_message_res_partner_starred_rel                          | FOREIGN KEY (res_partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 mail_message_res_partner_starred_rel_pkey                       | mail_message_res_partner_starred_rel                          | PRIMARY KEY (mail_message_id, res_partner_id)
 mail_message_schedule_mail_message_id_fkey                      | mail_message_schedule                                         | FOREIGN KEY (mail_message_id) REFERENCES mail_message(id) ON DELETE CASCADE
 mail_message_schedule_write_uid_fkey                            | mail_message_schedule                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_message_schedule_create_uid_fkey                           | mail_message_schedule                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_message_schedule_pkey                                      | mail_message_schedule                                         | PRIMARY KEY (id)
 mail_message_subtype_write_uid_fkey                             | mail_message_subtype                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_message_subtype_pkey                                       | mail_message_subtype                                          | PRIMARY KEY (id)
 mail_message_subtype_parent_id_fkey                             | mail_message_subtype                                          | FOREIGN KEY (parent_id) REFERENCES mail_message_subtype(id) ON DELETE SET NULL
 mail_message_subtype_create_uid_fkey                            | mail_message_subtype                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_message_translation_write_uid_fkey                         | mail_message_translation                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_message_translation_message_id_fkey                        | mail_message_translation                                      | FOREIGN KEY (message_id) REFERENCES mail_message(id) ON DELETE CASCADE
 mail_message_translation_pkey                                   | mail_message_translation                                      | PRIMARY KEY (id)
 mail_message_translation_create_uid_fkey                        | mail_message_translation                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_notification_letter_id_fkey                                | mail_notification                                             | FOREIGN KEY (letter_id) REFERENCES snailmail_letter(id) ON DELETE CASCADE
 mail_notification_res_partner_id_fkey                           | mail_notification                                             | FOREIGN KEY (res_partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 mail_notification_mail_mail_id_fkey                             | mail_notification                                             | FOREIGN KEY (mail_mail_id) REFERENCES mail_mail(id) ON DELETE SET NULL
 mail_notification_mail_message_id_fkey                          | mail_notification                                             | FOREIGN KEY (mail_message_id) REFERENCES mail_message(id) ON DELETE CASCADE
 mail_notification_author_id_fkey                                | mail_notification                                             | FOREIGN KEY (author_id) REFERENCES res_partner(id) ON DELETE SET NULL
 mail_notification_notification_partner_required                 | mail_notification                                             | CHECK ((((notification_type)::text <> ALL ((ARRAY['email'::character varying, 'inbox'::character varying])::text[])) OR (res_partner_id IS NOT NULL)))
 mail_notification_pkey                                          | mail_notification                                             | PRIMARY KEY (id)
 mail_notification_mail_resend_message_mail_notification_id_fkey | mail_notification_mail_resend_message_rel                     | FOREIGN KEY (mail_notification_id) REFERENCES mail_notification(id) ON DELETE CASCADE
 mail_notification_mail_resend_messa_mail_resend_message_id_fkey | mail_notification_mail_resend_message_rel                     | FOREIGN KEY (mail_resend_message_id) REFERENCES mail_resend_message(id) ON DELETE CASCADE
 mail_notification_mail_resend_message_rel_pkey                  | mail_notification_mail_resend_message_rel                     | PRIMARY KEY (mail_resend_message_id, mail_notification_id)
 mail_push_write_uid_fkey                                        | mail_push                                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_push_mail_push_device_id_fkey                              | mail_push                                                     | FOREIGN KEY (mail_push_device_id) REFERENCES mail_push_device(id) ON DELETE CASCADE
 mail_push_pkey                                                  | mail_push                                                     | PRIMARY KEY (id)
 mail_push_create_uid_fkey                                       | mail_push                                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_push_device_endpoint_unique                                | mail_push_device                                              | UNIQUE (endpoint)
 mail_push_device_pkey                                           | mail_push_device                                              | PRIMARY KEY (id)
 mail_push_device_partner_id_fkey                                | mail_push_device                                              | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE RESTRICT
 mail_push_device_write_uid_fkey                                 | mail_push_device                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_push_device_create_uid_fkey                                | mail_push_device                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_resend_message_create_uid_fkey                             | mail_resend_message                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_resend_message_pkey                                        | mail_resend_message                                           | PRIMARY KEY (id)
 mail_resend_message_mail_message_id_fkey                        | mail_resend_message                                           | FOREIGN KEY (mail_message_id) REFERENCES mail_message(id) ON DELETE SET NULL
 mail_resend_message_write_uid_fkey                              | mail_resend_message                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_resend_partner_notification_id_fkey                        | mail_resend_partner                                           | FOREIGN KEY (notification_id) REFERENCES mail_notification(id) ON DELETE CASCADE
 mail_resend_partner_resend_wizard_id_fkey                       | mail_resend_partner                                           | FOREIGN KEY (resend_wizard_id) REFERENCES mail_resend_message(id) ON DELETE SET NULL
 mail_resend_partner_create_uid_fkey                             | mail_resend_partner                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_resend_partner_pkey                                        | mail_resend_partner                                           | PRIMARY KEY (id)
 mail_resend_partner_write_uid_fkey                              | mail_resend_partner                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_scheduled_message_create_uid_fkey                          | mail_scheduled_message                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_scheduled_message_write_uid_fkey                           | mail_scheduled_message                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_scheduled_message_author_id_fkey                           | mail_scheduled_message                                        | FOREIGN KEY (author_id) REFERENCES res_partner(id) ON DELETE RESTRICT
 mail_scheduled_message_pkey                                     | mail_scheduled_message                                        | PRIMARY KEY (id)
 mail_scheduled_message_res_partner_rel_pkey                     | mail_scheduled_message_res_partner_rel                        | PRIMARY KEY (mail_scheduled_message_id, res_partner_id)
 mail_scheduled_message_res_partner_rel_res_partner_id_fkey      | mail_scheduled_message_res_partner_rel                        | FOREIGN KEY (res_partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 mail_scheduled_message_res_partn_mail_scheduled_message_id_fkey | mail_scheduled_message_res_partner_rel                        | FOREIGN KEY (mail_scheduled_message_id) REFERENCES mail_scheduled_message(id) ON DELETE CASCADE
 mail_template_create_uid_fkey                                   | mail_template                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_template_pkey                                              | mail_template                                                 | PRIMARY KEY (id)
 mail_template_write_uid_fkey                                    | mail_template                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_template_ref_ir_act_window_fkey                            | mail_template                                                 | FOREIGN KEY (ref_ir_act_window) REFERENCES ir_act_window(id) ON DELETE SET NULL
 mail_template_mail_server_id_fkey                               | mail_template                                                 | FOREIGN KEY (mail_server_id) REFERENCES ir_mail_server(id) ON DELETE SET NULL
 mail_template_user_id_fkey                                      | mail_template                                                 | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 mail_template_model_id_fkey                                     | mail_template                                                 | FOREIGN KEY (model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 mail_template_ir_actions_report_rel_mail_template_id_fkey       | mail_template_ir_actions_report_rel                           | FOREIGN KEY (mail_template_id) REFERENCES mail_template(id) ON DELETE CASCADE
 mail_template_ir_actions_report_rel_ir_actions_report_id_fkey   | mail_template_ir_actions_report_rel                           | FOREIGN KEY (ir_actions_report_id) REFERENCES ir_act_report_xml(id) ON DELETE CASCADE
 mail_template_ir_actions_report_rel_pkey                        | mail_template_ir_actions_report_rel                           | PRIMARY KEY (mail_template_id, ir_actions_report_id)
 mail_template_mail_template_reset_rel_pkey                      | mail_template_mail_template_reset_rel                         | PRIMARY KEY (mail_template_reset_id, mail_template_id)
 mail_template_mail_template_reset_r_mail_template_reset_id_fkey | mail_template_mail_template_reset_rel                         | FOREIGN KEY (mail_template_reset_id) REFERENCES mail_template_reset(id) ON DELETE CASCADE
 mail_template_mail_template_reset_rel_mail_template_id_fkey     | mail_template_mail_template_reset_rel                         | FOREIGN KEY (mail_template_id) REFERENCES mail_template(id) ON DELETE CASCADE
 mail_template_preview_mail_template_id_fkey                     | mail_template_preview                                         | FOREIGN KEY (mail_template_id) REFERENCES mail_template(id) ON DELETE CASCADE
 mail_template_preview_create_uid_fkey                           | mail_template_preview                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_template_preview_pkey                                      | mail_template_preview                                         | PRIMARY KEY (id)
 mail_template_preview_write_uid_fkey                            | mail_template_preview                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_template_reset_write_uid_fkey                              | mail_template_reset                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_template_reset_create_uid_fkey                             | mail_template_reset                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_template_reset_pkey                                        | mail_template_reset                                           | PRIMARY KEY (id)
 mail_tracking_value_pkey                                        | mail_tracking_value                                           | PRIMARY KEY (id)
 mail_tracking_value_mail_message_id_fkey                        | mail_tracking_value                                           | FOREIGN KEY (mail_message_id) REFERENCES mail_message(id) ON DELETE CASCADE
 mail_tracking_value_currency_id_fkey                            | mail_tracking_value                                           | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 mail_tracking_value_field_id_fkey                               | mail_tracking_value                                           | FOREIGN KEY (field_id) REFERENCES ir_model_fields(id) ON DELETE SET NULL
 mail_tracking_value_write_uid_fkey                              | mail_tracking_value                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_tracking_value_create_uid_fkey                             | mail_tracking_value                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_wizard_invite_pkey                                         | mail_wizard_invite                                            | PRIMARY KEY (id)
 mail_wizard_invite_create_uid_fkey                              | mail_wizard_invite                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_wizard_invite_write_uid_fkey                               | mail_wizard_invite                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mail_wizard_invite_res_partner_rel_res_partner_id_fkey          | mail_wizard_invite_res_partner_rel                            | FOREIGN KEY (res_partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 mail_wizard_invite_res_partner_rel_mail_wizard_invite_id_fkey   | mail_wizard_invite_res_partner_rel                            | FOREIGN KEY (mail_wizard_invite_id) REFERENCES mail_wizard_invite(id) ON DELETE CASCADE
 mail_wizard_invite_res_partner_rel_pkey                         | mail_wizard_invite_res_partner_rel                            | PRIMARY KEY (mail_wizard_invite_id, res_partner_id)
 mailing_contact_title_id_fkey                                   | mailing_contact                                               | FOREIGN KEY (title_id) REFERENCES res_partner_title(id) ON DELETE SET NULL
 mailing_contact_country_id_fkey                                 | mailing_contact                                               | FOREIGN KEY (country_id) REFERENCES res_country(id) ON DELETE SET NULL
 mailing_contact_create_uid_fkey                                 | mailing_contact                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_contact_write_uid_fkey                                  | mailing_contact                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_contact_pkey                                            | mailing_contact                                               | PRIMARY KEY (id)
 mailing_contact_import_write_uid_fkey                           | mailing_contact_import                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_contact_import_pkey                                     | mailing_contact_import                                        | PRIMARY KEY (id)
 mailing_contact_import_create_uid_fkey                          | mailing_contact_import                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_contact_import_mailing_list_rel_mailing_list_id_fkey    | mailing_contact_import_mailing_list_rel                       | FOREIGN KEY (mailing_list_id) REFERENCES mailing_list(id) ON DELETE CASCADE
 mailing_contact_import_mailing_l_mailing_contact_import_id_fkey | mailing_contact_import_mailing_list_rel                       | FOREIGN KEY (mailing_contact_import_id) REFERENCES mailing_contact_import(id) ON DELETE CASCADE
 mailing_contact_import_mailing_list_rel_pkey                    | mailing_contact_import_mailing_list_rel                       | PRIMARY KEY (mailing_contact_import_id, mailing_list_id)
 mailing_contact_mailing_contact_to_list_rel_pkey                | mailing_contact_mailing_contact_to_list_rel                   | PRIMARY KEY (mailing_contact_to_list_id, mailing_contact_id)
 mailing_contact_mailing_contact_mailing_contact_to_list_id_fkey | mailing_contact_mailing_contact_to_list_rel                   | FOREIGN KEY (mailing_contact_to_list_id) REFERENCES mailing_contact_to_list(id) ON DELETE CASCADE
 mailing_contact_mailing_contact_to_list_mailing_contact_id_fkey | mailing_contact_mailing_contact_to_list_rel                   | FOREIGN KEY (mailing_contact_id) REFERENCES mailing_contact(id) ON DELETE CASCADE
 mailing_contact_res_partner_category_re_mailing_contact_id_fkey | mailing_contact_res_partner_category_rel                      | FOREIGN KEY (mailing_contact_id) REFERENCES mailing_contact(id) ON DELETE CASCADE
 mailing_contact_res_partner_category_rel_pkey                   | mailing_contact_res_partner_category_rel                      | PRIMARY KEY (mailing_contact_id, res_partner_category_id)
 mailing_contact_res_partner_catego_res_partner_category_id_fkey | mailing_contact_res_partner_category_rel                      | FOREIGN KEY (res_partner_category_id) REFERENCES res_partner_category(id) ON DELETE CASCADE
 mailing_contact_to_list_mailing_list_id_fkey                    | mailing_contact_to_list                                       | FOREIGN KEY (mailing_list_id) REFERENCES mailing_list(id) ON DELETE CASCADE
 mailing_contact_to_list_create_uid_fkey                         | mailing_contact_to_list                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_contact_to_list_write_uid_fkey                          | mailing_contact_to_list                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_contact_to_list_pkey                                    | mailing_contact_to_list                                       | PRIMARY KEY (id)
 mailing_filter_mailing_model_id_fkey                            | mailing_filter                                                | FOREIGN KEY (mailing_model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 mailing_filter_pkey                                             | mailing_filter                                                | PRIMARY KEY (id)
 mailing_filter_create_uid_fkey                                  | mailing_filter                                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_filter_write_uid_fkey                                   | mailing_filter                                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_list_pkey                                               | mailing_list                                                  | PRIMARY KEY (id)
 mailing_list_write_uid_fkey                                     | mailing_list                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_list_create_uid_fkey                                    | mailing_list                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_list_mailing_list_merge_rel_mailing_list_id_fkey        | mailing_list_mailing_list_merge_rel                           | FOREIGN KEY (mailing_list_id) REFERENCES mailing_list(id) ON DELETE CASCADE
 mailing_list_mailing_list_merge_rel_mailing_list_merge_id_fkey  | mailing_list_mailing_list_merge_rel                           | FOREIGN KEY (mailing_list_merge_id) REFERENCES mailing_list_merge(id) ON DELETE CASCADE
 mailing_list_mailing_list_merge_rel_pkey                        | mailing_list_mailing_list_merge_rel                           | PRIMARY KEY (mailing_list_merge_id, mailing_list_id)
 mailing_list_merge_pkey                                         | mailing_list_merge                                            | PRIMARY KEY (id)
 mailing_list_merge_write_uid_fkey                               | mailing_list_merge                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_list_merge_create_uid_fkey                              | mailing_list_merge                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_list_merge_dest_list_id_fkey                            | mailing_list_merge                                            | FOREIGN KEY (dest_list_id) REFERENCES mailing_list(id) ON DELETE SET NULL
 mailing_mailing_pkey                                            | mailing_mailing                                               | PRIMARY KEY (id)
 mailing_mailing_percentage_valid                                | mailing_mailing                                               | CHECK (((ab_testing_pc >= 0) AND (ab_testing_pc <= 100)))
 mailing_mailing_write_uid_fkey                                  | mailing_mailing                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_mailing_create_uid_fkey                                 | mailing_mailing                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_mailing_mailing_filter_id_fkey                          | mailing_mailing                                               | FOREIGN KEY (mailing_filter_id) REFERENCES mailing_filter(id) ON DELETE SET NULL
 mailing_mailing_mail_server_id_fkey                             | mailing_mailing                                               | FOREIGN KEY (mail_server_id) REFERENCES ir_mail_server(id) ON DELETE SET NULL
 mailing_mailing_mailing_model_id_fkey                           | mailing_mailing                                               | FOREIGN KEY (mailing_model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 mailing_mailing_user_id_fkey                                    | mailing_mailing                                               | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_mailing_medium_id_fkey                                  | mailing_mailing                                               | FOREIGN KEY (medium_id) REFERENCES utm_medium(id) ON DELETE RESTRICT
 mailing_mailing_campaign_id_fkey                                | mailing_mailing                                               | FOREIGN KEY (campaign_id) REFERENCES utm_campaign(id) ON DELETE SET NULL
 mailing_mailing_source_id_fkey                                  | mailing_mailing                                               | FOREIGN KEY (source_id) REFERENCES utm_source(id) ON DELETE RESTRICT
 mailing_mailing_schedule_date_write_uid_fkey                    | mailing_mailing_schedule_date                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_mailing_schedule_date_create_uid_fkey                   | mailing_mailing_schedule_date                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_mailing_schedule_date_mass_mailing_id_fkey              | mailing_mailing_schedule_date                                 | FOREIGN KEY (mass_mailing_id) REFERENCES mailing_mailing(id) ON DELETE CASCADE
 mailing_mailing_schedule_date_pkey                              | mailing_mailing_schedule_date                                 | PRIMARY KEY (id)
 mailing_mailing_test_create_uid_fkey                            | mailing_mailing_test                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_mailing_test_mass_mailing_id_fkey                       | mailing_mailing_test                                          | FOREIGN KEY (mass_mailing_id) REFERENCES mailing_mailing(id) ON DELETE CASCADE
 mailing_mailing_test_pkey                                       | mailing_mailing_test                                          | PRIMARY KEY (id)
 mailing_mailing_test_write_uid_fkey                             | mailing_mailing_test                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_subscription_create_uid_fkey                            | mailing_subscription                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_subscription_pkey                                       | mailing_subscription                                          | PRIMARY KEY (id)
 mailing_subscription_unique_contact_list                        | mailing_subscription                                          | UNIQUE (contact_id, list_id)
 mailing_subscription_list_id_fkey                               | mailing_subscription                                          | FOREIGN KEY (list_id) REFERENCES mailing_list(id) ON DELETE CASCADE
 mailing_subscription_contact_id_fkey                            | mailing_subscription                                          | FOREIGN KEY (contact_id) REFERENCES mailing_contact(id) ON DELETE CASCADE
 mailing_subscription_write_uid_fkey                             | mailing_subscription                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_subscription_opt_out_reason_id_fkey                     | mailing_subscription                                          | FOREIGN KEY (opt_out_reason_id) REFERENCES mailing_subscription_optout(id) ON DELETE RESTRICT
 mailing_subscription_optout_create_uid_fkey                     | mailing_subscription_optout                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_subscription_optout_pkey                                | mailing_subscription_optout                                   | PRIMARY KEY (id)
 mailing_subscription_optout_write_uid_fkey                      | mailing_subscription_optout                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_trace_mail_mail_id_fkey                                 | mailing_trace                                                 | FOREIGN KEY (mail_mail_id) REFERENCES mail_mail(id) ON DELETE SET NULL
 mailing_trace_write_uid_fkey                                    | mailing_trace                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_trace_create_uid_fkey                                   | mailing_trace                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mailing_trace_marketing_trace_id_fkey                           | mailing_trace                                                 | FOREIGN KEY (marketing_trace_id) REFERENCES marketing_trace(id) ON DELETE CASCADE
 mailing_trace_campaign_id_fkey                                  | mailing_trace                                                 | FOREIGN KEY (campaign_id) REFERENCES utm_campaign(id) ON DELETE SET NULL
 mailing_trace_mass_mailing_id_fkey                              | mailing_trace                                                 | FOREIGN KEY (mass_mailing_id) REFERENCES mailing_mailing(id) ON DELETE CASCADE
 mailing_trace_pkey                                              | mailing_trace                                                 | PRIMARY KEY (id)
 mailing_trace_check_res_id_is_set                               | mailing_trace                                                 | CHECK (((res_id IS NOT NULL) AND (res_id <> 0)))
 marketing_activity_mass_mailing_id_fkey                         | marketing_activity                                            | FOREIGN KEY (mass_mailing_id) REFERENCES mailing_mailing(id) ON DELETE SET NULL
 marketing_activity_pkey                                         | marketing_activity                                            | PRIMARY KEY (id)
 marketing_activity_whatsapp_template_id_fkey                    | marketing_activity                                            | FOREIGN KEY (whatsapp_template_id) REFERENCES whatsapp_template(id) ON DELETE RESTRICT
 marketing_activity_source_id_fkey                               | marketing_activity                                            | FOREIGN KEY (source_id) REFERENCES utm_source(id) ON DELETE RESTRICT
 marketing_activity_write_uid_fkey                               | marketing_activity                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 marketing_activity_parent_id_fkey                               | marketing_activity                                            | FOREIGN KEY (parent_id) REFERENCES marketing_activity(id) ON DELETE CASCADE
 marketing_activity_create_uid_fkey                              | marketing_activity                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 marketing_activity_server_action_id_fkey                        | marketing_activity                                            | FOREIGN KEY (server_action_id) REFERENCES ir_act_server(id) ON DELETE SET NULL
 marketing_activity_campaign_id_fkey                             | marketing_activity                                            | FOREIGN KEY (campaign_id) REFERENCES marketing_campaign(id) ON DELETE CASCADE
 marketing_campaign_unique_field_id_fkey                         | marketing_campaign                                            | FOREIGN KEY (unique_field_id) REFERENCES ir_model_fields(id) ON DELETE SET NULL
 marketing_campaign_utm_campaign_id_fkey                         | marketing_campaign                                            | FOREIGN KEY (utm_campaign_id) REFERENCES utm_campaign(id) ON DELETE RESTRICT
 marketing_campaign_pkey                                         | marketing_campaign                                            | PRIMARY KEY (id)
 marketing_campaign_write_uid_fkey                               | marketing_campaign                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 marketing_campaign_create_uid_fkey                              | marketing_campaign                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 marketing_campaign_mailing_filter_id_fkey                       | marketing_campaign                                            | FOREIGN KEY (mailing_filter_id) REFERENCES mailing_filter(id) ON DELETE SET NULL
 marketing_campaign_model_id_fkey                                | marketing_campaign                                            | FOREIGN KEY (model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 marketing_campaign_test_create_uid_fkey                         | marketing_campaign_test                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 marketing_campaign_test_pkey                                    | marketing_campaign_test                                       | PRIMARY KEY (id)
 marketing_campaign_test_campaign_id_fkey                        | marketing_campaign_test                                       | FOREIGN KEY (campaign_id) REFERENCES marketing_campaign(id) ON DELETE CASCADE
 marketing_campaign_test_write_uid_fkey                          | marketing_campaign_test                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 marketing_participant_campaign_id_fkey                          | marketing_participant                                         | FOREIGN KEY (campaign_id) REFERENCES marketing_campaign(id) ON DELETE CASCADE
 marketing_participant_model_id_fkey                             | marketing_participant                                         | FOREIGN KEY (model_id) REFERENCES ir_model(id) ON DELETE SET NULL
 marketing_participant_write_uid_fkey                            | marketing_participant                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 marketing_participant_create_uid_fkey                           | marketing_participant                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 marketing_participant_pkey                                      | marketing_participant                                         | PRIMARY KEY (id)
 marketing_trace_parent_id_fkey                                  | marketing_trace                                               | FOREIGN KEY (parent_id) REFERENCES marketing_trace(id) ON DELETE CASCADE
 marketing_trace_whatsapp_message_id_fkey                        | marketing_trace                                               | FOREIGN KEY (whatsapp_message_id) REFERENCES whatsapp_message(id) ON DELETE SET NULL
 marketing_trace_write_uid_fkey                                  | marketing_trace                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 marketing_trace_create_uid_fkey                                 | marketing_trace                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 marketing_trace_pkey                                            | marketing_trace                                               | PRIMARY KEY (id)
 marketing_trace_activity_id_fkey                                | marketing_trace                                               | FOREIGN KEY (activity_id) REFERENCES marketing_activity(id) ON DELETE CASCADE
 marketing_trace_participant_id_fkey                             | marketing_trace                                               | FOREIGN KEY (participant_id) REFERENCES marketing_participant(id) ON DELETE CASCADE
 mass_mailing_ir_attachments_rel_pkey                            | mass_mailing_ir_attachments_rel                               | PRIMARY KEY (mass_mailing_id, attachment_id)
 mass_mailing_ir_attachments_rel_mass_mailing_id_fkey            | mass_mailing_ir_attachments_rel                               | FOREIGN KEY (mass_mailing_id) REFERENCES mailing_mailing(id) ON DELETE CASCADE
 mass_mailing_ir_attachments_rel_attachment_id_fkey              | mass_mailing_ir_attachments_rel                               | FOREIGN KEY (attachment_id) REFERENCES ir_attachment(id) ON DELETE CASCADE
 meeting_category_rel_pkey                                       | meeting_category_rel                                          | PRIMARY KEY (event_id, type_id)
 meeting_category_rel_type_id_fkey                               | meeting_category_rel                                          | FOREIGN KEY (type_id) REFERENCES calendar_event_type(id) ON DELETE CASCADE
 meeting_category_rel_event_id_fkey                              | meeting_category_rel                                          | FOREIGN KEY (event_id) REFERENCES calendar_event(id) ON DELETE CASCADE
 merge_opportunity_rel_merge_id_fkey                             | merge_opportunity_rel                                         | FOREIGN KEY (merge_id) REFERENCES crm_merge_opportunity(id) ON DELETE CASCADE
 merge_opportunity_rel_pkey                                      | merge_opportunity_rel                                         | PRIMARY KEY (merge_id, opportunity_id)
 merge_opportunity_rel_opportunity_id_fkey                       | merge_opportunity_rel                                         | FOREIGN KEY (opportunity_id) REFERENCES crm_lead(id) ON DELETE CASCADE
 message_attachment_rel_pkey                                     | message_attachment_rel                                        | PRIMARY KEY (message_id, attachment_id)
 message_attachment_rel_message_id_fkey                          | message_attachment_rel                                        | FOREIGN KEY (message_id) REFERENCES mail_message(id) ON DELETE CASCADE
 message_attachment_rel_attachment_id_fkey                       | message_attachment_rel                                        | FOREIGN KEY (attachment_id) REFERENCES ir_attachment(id) ON DELETE CASCADE
 module_country_module_id_fkey                                   | module_country                                                | FOREIGN KEY (module_id) REFERENCES ir_module_module(id) ON DELETE CASCADE
 module_country_country_id_fkey                                  | module_country                                                | FOREIGN KEY (country_id) REFERENCES res_country(id) ON DELETE CASCADE
 module_country_pkey                                             | module_country                                                | PRIMARY KEY (module_id, country_id)
 mrp_account_wip_accounting_create_uid_fkey                      | mrp_account_wip_accounting                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_account_wip_accounting_journal_id_fkey                      | mrp_account_wip_accounting                                    | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE CASCADE
 mrp_account_wip_accounting_write_uid_fkey                       | mrp_account_wip_accounting                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_account_wip_accounting_pkey                                 | mrp_account_wip_accounting                                    | PRIMARY KEY (id)
 mrp_account_wip_accounting_line_write_uid_fkey                  | mrp_account_wip_accounting_line                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_account_wip_accounting_line_create_uid_fkey                 | mrp_account_wip_accounting_line                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_account_wip_accounting_line_wip_accounting_id_fkey          | mrp_account_wip_accounting_line                               | FOREIGN KEY (wip_accounting_id) REFERENCES mrp_account_wip_accounting(id) ON DELETE SET NULL
 mrp_account_wip_accounting_line_currency_id_fkey                | mrp_account_wip_accounting_line                               | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 mrp_account_wip_accounting_line_account_id_fkey                 | mrp_account_wip_accounting_line                               | FOREIGN KEY (account_id) REFERENCES account_account(id) ON DELETE SET NULL
 mrp_account_wip_accounting_line_pkey                            | mrp_account_wip_accounting_line                               | PRIMARY KEY (id)
 mrp_account_wip_accounting_line_check_debit_credit              | mrp_account_wip_accounting_line                               | CHECK (((debit = (0)::numeric) OR (credit = (0)::numeric)))
 mrp_account_wip_accounting_mrp_production_rel_pkey              | mrp_account_wip_accounting_mrp_production_rel                 | PRIMARY KEY (mrp_account_wip_accounting_id, mrp_production_id)
 mrp_account_wip_accounting_mr_mrp_account_wip_accounting_i_fkey | mrp_account_wip_accounting_mrp_production_rel                 | FOREIGN KEY (mrp_account_wip_accounting_id) REFERENCES mrp_account_wip_accounting(id) ON DELETE CASCADE
 mrp_account_wip_accounting_mrp_productio_mrp_production_id_fkey | mrp_account_wip_accounting_mrp_production_rel                 | FOREIGN KEY (mrp_production_id) REFERENCES mrp_production(id) ON DELETE CASCADE
 mrp_batch_produce_production_id_fkey                            | mrp_batch_produce                                             | FOREIGN KEY (production_id) REFERENCES mrp_production(id) ON DELETE SET NULL
 mrp_batch_produce_pkey                                          | mrp_batch_produce                                             | PRIMARY KEY (id)
 mrp_batch_produce_create_uid_fkey                               | mrp_batch_produce                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_batch_produce_write_uid_fkey                                | mrp_batch_produce                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_bom_create_uid_fkey                                         | mrp_bom                                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_bom_product_tmpl_id_fkey                                    | mrp_bom                                                       | FOREIGN KEY (product_tmpl_id) REFERENCES product_template(id) ON DELETE RESTRICT
 mrp_bom_product_id_fkey                                         | mrp_bom                                                       | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE SET NULL
 mrp_bom_qty_positive                                            | mrp_bom                                                       | CHECK ((product_qty > (0)::numeric))
 mrp_bom_pkey                                                    | mrp_bom                                                       | PRIMARY KEY (id)
 mrp_bom_product_uom_id_fkey                                     | mrp_bom                                                       | FOREIGN KEY (product_uom_id) REFERENCES uom_uom(id) ON DELETE RESTRICT
 mrp_bom_picking_type_id_fkey                                    | mrp_bom                                                       | FOREIGN KEY (picking_type_id) REFERENCES stock_picking_type(id) ON DELETE SET NULL
 mrp_bom_company_id_fkey                                         | mrp_bom                                                       | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 mrp_bom_write_uid_fkey                                          | mrp_bom                                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_bom_previous_bom_id_fkey                                    | mrp_bom                                                       | FOREIGN KEY (previous_bom_id) REFERENCES mrp_bom(id) ON DELETE SET NULL
 mrp_bom_project_id_fkey                                         | mrp_bom                                                       | FOREIGN KEY (project_id) REFERENCES project_project(id) ON DELETE SET NULL
 mrp_bom_byproduct_bom_id_fkey                                   | mrp_bom_byproduct                                             | FOREIGN KEY (bom_id) REFERENCES mrp_bom(id) ON DELETE CASCADE
 mrp_bom_byproduct_operation_id_fkey                             | mrp_bom_byproduct                                             | FOREIGN KEY (operation_id) REFERENCES mrp_routing_workcenter(id) ON DELETE SET NULL
 mrp_bom_byproduct_pkey                                          | mrp_bom_byproduct                                             | PRIMARY KEY (id)
 mrp_bom_byproduct_product_id_fkey                               | mrp_bom_byproduct                                             | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE RESTRICT
 mrp_bom_byproduct_product_uom_id_fkey                           | mrp_bom_byproduct                                             | FOREIGN KEY (product_uom_id) REFERENCES uom_uom(id) ON DELETE RESTRICT
 mrp_bom_byproduct_write_uid_fkey                                | mrp_bom_byproduct                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_bom_byproduct_create_uid_fkey                               | mrp_bom_byproduct                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_bom_byproduct_company_id_fkey                               | mrp_bom_byproduct                                             | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 mrp_bom_byproduct_product_template_attribute_value_rel_pkey     | mrp_bom_byproduct_product_template_attribute_value_rel        | PRIMARY KEY (mrp_bom_byproduct_id, product_template_attribute_value_id)
 mrp_bom_byproduct_product_template_at_mrp_bom_byproduct_id_fkey | mrp_bom_byproduct_product_template_attribute_value_rel        | FOREIGN KEY (mrp_bom_byproduct_id) REFERENCES mrp_bom_byproduct(id) ON DELETE CASCADE
 mrp_bom_byproduct_product_tem_product_template_attribute_v_fkey | mrp_bom_byproduct_product_template_attribute_value_rel        | FOREIGN KEY (product_template_attribute_value_id) REFERENCES product_template_attribute_value(id) ON DELETE RESTRICT
 mrp_bom_line_write_uid_fkey                                     | mrp_bom_line                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_bom_line_bom_qty_zero                                       | mrp_bom_line                                                  | CHECK ((product_qty >= (0)::numeric))
 mrp_bom_line_product_id_fkey                                    | mrp_bom_line                                                  | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE RESTRICT
 mrp_bom_line_product_tmpl_id_fkey                               | mrp_bom_line                                                  | FOREIGN KEY (product_tmpl_id) REFERENCES product_template(id) ON DELETE SET NULL
 mrp_bom_line_pkey                                               | mrp_bom_line                                                  | PRIMARY KEY (id)
 mrp_bom_line_company_id_fkey                                    | mrp_bom_line                                                  | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 mrp_bom_line_product_uom_id_fkey                                | mrp_bom_line                                                  | FOREIGN KEY (product_uom_id) REFERENCES uom_uom(id) ON DELETE RESTRICT
 mrp_bom_line_bom_id_fkey                                        | mrp_bom_line                                                  | FOREIGN KEY (bom_id) REFERENCES mrp_bom(id) ON DELETE CASCADE
 mrp_bom_line_operation_id_fkey                                  | mrp_bom_line                                                  | FOREIGN KEY (operation_id) REFERENCES mrp_routing_workcenter(id) ON DELETE SET NULL
 mrp_bom_line_create_uid_fkey                                    | mrp_bom_line                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_bom_line_product_template_attribute_va_mrp_bom_line_id_fkey | mrp_bom_line_product_template_attribute_value_rel             | FOREIGN KEY (mrp_bom_line_id) REFERENCES mrp_bom_line(id) ON DELETE CASCADE
 mrp_bom_line_product_template_attribute_value_rel_pkey          | mrp_bom_line_product_template_attribute_value_rel             | PRIMARY KEY (mrp_bom_line_id, product_template_attribute_value_id)
 mrp_bom_line_product_template_product_template_attribute_v_fkey | mrp_bom_line_product_template_attribute_value_rel             | FOREIGN KEY (product_template_attribute_value_id) REFERENCES product_template_attribute_value(id) ON DELETE RESTRICT
 mrp_consumption_warning_pkey                                    | mrp_consumption_warning                                       | PRIMARY KEY (id)
 mrp_consumption_warning_create_uid_fkey                         | mrp_consumption_warning                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_consumption_warning_write_uid_fkey                          | mrp_consumption_warning                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_consumption_warning_line_mrp_consumption_warning_id_fkey    | mrp_consumption_warning_line                                  | FOREIGN KEY (mrp_consumption_warning_id) REFERENCES mrp_consumption_warning(id) ON DELETE CASCADE
 mrp_consumption_warning_line_write_uid_fkey                     | mrp_consumption_warning_line                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_consumption_warning_line_pkey                               | mrp_consumption_warning_line                                  | PRIMARY KEY (id)
 mrp_consumption_warning_line_mrp_production_id_fkey             | mrp_consumption_warning_line                                  | FOREIGN KEY (mrp_production_id) REFERENCES mrp_production(id) ON DELETE CASCADE
 mrp_consumption_warning_line_create_uid_fkey                    | mrp_consumption_warning_line                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_consumption_warning_line_product_id_fkey                    | mrp_consumption_warning_line                                  | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE CASCADE
 mrp_consumption_warning_mrp_production_rel_pkey                 | mrp_consumption_warning_mrp_production_rel                    | PRIMARY KEY (mrp_consumption_warning_id, mrp_production_id)
 mrp_consumption_warning_mrp_pro_mrp_consumption_warning_id_fkey | mrp_consumption_warning_mrp_production_rel                    | FOREIGN KEY (mrp_consumption_warning_id) REFERENCES mrp_consumption_warning(id) ON DELETE CASCADE
 mrp_consumption_warning_mrp_production_r_mrp_production_id_fkey | mrp_consumption_warning_mrp_production_rel                    | FOREIGN KEY (mrp_production_id) REFERENCES mrp_production(id) ON DELETE CASCADE
 mrp_eco_write_uid_fkey                                          | mrp_eco                                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_eco_new_bom_id_fkey                                         | mrp_eco                                                       | FOREIGN KEY (new_bom_id) REFERENCES mrp_bom(id) ON DELETE SET NULL
 mrp_eco_bom_id_fkey                                             | mrp_eco                                                       | FOREIGN KEY (bom_id) REFERENCES mrp_bom(id) ON DELETE SET NULL
 mrp_eco_production_id_fkey                                      | mrp_eco                                                       | FOREIGN KEY (production_id) REFERENCES mrp_production(id) ON DELETE SET NULL
 mrp_eco_product_tmpl_id_fkey                                    | mrp_eco                                                       | FOREIGN KEY (product_tmpl_id) REFERENCES product_template(id) ON DELETE SET NULL
 mrp_eco_company_id_fkey                                         | mrp_eco                                                       | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 mrp_eco_stage_id_fkey                                           | mrp_eco                                                       | FOREIGN KEY (stage_id) REFERENCES mrp_eco_stage(id) ON DELETE RESTRICT
 mrp_eco_type_id_fkey                                            | mrp_eco                                                       | FOREIGN KEY (type_id) REFERENCES mrp_eco_type(id) ON DELETE RESTRICT
 mrp_eco_user_id_fkey                                            | mrp_eco                                                       | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_eco_current_bom_id_fkey                                     | mrp_eco                                                       | FOREIGN KEY (current_bom_id) REFERENCES mrp_bom(id) ON DELETE SET NULL
 mrp_eco_create_uid_fkey                                         | mrp_eco                                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_eco_displayed_image_id_fkey                                 | mrp_eco                                                       | FOREIGN KEY (displayed_image_id) REFERENCES product_document(id) ON DELETE SET NULL
 mrp_eco_pkey                                                    | mrp_eco                                                       | PRIMARY KEY (id)
 mrp_eco_approval_pkey                                           | mrp_eco_approval                                              | PRIMARY KEY (id)
 mrp_eco_approval_eco_stage_id_fkey                              | mrp_eco_approval                                              | FOREIGN KEY (eco_stage_id) REFERENCES mrp_eco_stage(id) ON DELETE SET NULL
 mrp_eco_approval_template_stage_id_fkey1                        | mrp_eco_approval                                              | FOREIGN KEY (template_stage_id) REFERENCES mrp_eco_stage(id) ON DELETE SET NULL
 mrp_eco_approval_user_id_fkey                                   | mrp_eco_approval                                              | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_eco_approval_approval_template_id_fkey                      | mrp_eco_approval                                              | FOREIGN KEY (approval_template_id) REFERENCES mrp_eco_approval_template(id) ON DELETE CASCADE
 mrp_eco_approval_eco_id_fkey                                    | mrp_eco_approval                                              | FOREIGN KEY (eco_id) REFERENCES mrp_eco(id) ON DELETE CASCADE
 mrp_eco_approval_write_uid_fkey                                 | mrp_eco_approval                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_eco_approval_create_uid_fkey                                | mrp_eco_approval                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_eco_approval_template_pkey                                  | mrp_eco_approval_template                                     | PRIMARY KEY (id)
 mrp_eco_approval_template_write_uid_fkey                        | mrp_eco_approval_template                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_eco_approval_template_create_uid_fkey                       | mrp_eco_approval_template                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_eco_approval_template_stage_id_fkey                         | mrp_eco_approval_template                                     | FOREIGN KEY (stage_id) REFERENCES mrp_eco_stage(id) ON DELETE RESTRICT
 mrp_eco_approval_template_res_users_rel_res_users_id_fkey       | mrp_eco_approval_template_res_users_rel                       | FOREIGN KEY (res_users_id) REFERENCES res_users(id) ON DELETE CASCADE
 mrp_eco_approval_template_res_mrp_eco_approval_template_id_fkey | mrp_eco_approval_template_res_users_rel                       | FOREIGN KEY (mrp_eco_approval_template_id) REFERENCES mrp_eco_approval_template(id) ON DELETE CASCADE
 mrp_eco_approval_template_res_users_rel_pkey                    | mrp_eco_approval_template_res_users_rel                       | PRIMARY KEY (mrp_eco_approval_template_id, res_users_id)
 mrp_eco_bom_change_eco_rebase_id_fkey                           | mrp_eco_bom_change                                            | FOREIGN KEY (eco_rebase_id) REFERENCES mrp_eco(id) ON DELETE CASCADE
 mrp_eco_bom_change_pkey                                         | mrp_eco_bom_change                                            | PRIMARY KEY (id)
 mrp_eco_bom_change_write_uid_fkey                               | mrp_eco_bom_change                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_eco_bom_change_create_uid_fkey                              | mrp_eco_bom_change                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_eco_bom_change_byproduct_id_fkey                            | mrp_eco_bom_change                                            | FOREIGN KEY (byproduct_id) REFERENCES mrp_bom_byproduct(id) ON DELETE SET NULL
 mrp_eco_bom_change_bom_line_id_fkey                             | mrp_eco_bom_change                                            | FOREIGN KEY (bom_line_id) REFERENCES mrp_bom_line(id) ON DELETE SET NULL
 mrp_eco_bom_change_new_operation_id_fkey                        | mrp_eco_bom_change                                            | FOREIGN KEY (new_operation_id) REFERENCES mrp_routing_workcenter(id) ON DELETE SET NULL
 mrp_eco_bom_change_old_operation_id_fkey                        | mrp_eco_bom_change                                            | FOREIGN KEY (old_operation_id) REFERENCES mrp_routing_workcenter(id) ON DELETE SET NULL
 mrp_eco_bom_change_new_uom_id_fkey                              | mrp_eco_bom_change                                            | FOREIGN KEY (new_uom_id) REFERENCES uom_uom(id) ON DELETE SET NULL
 mrp_eco_bom_change_old_uom_id_fkey                              | mrp_eco_bom_change                                            | FOREIGN KEY (old_uom_id) REFERENCES uom_uom(id) ON DELETE SET NULL
 mrp_eco_bom_change_product_id_fkey                              | mrp_eco_bom_change                                            | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE RESTRICT
 mrp_eco_bom_change_rebase_id_fkey                               | mrp_eco_bom_change                                            | FOREIGN KEY (rebase_id) REFERENCES mrp_eco(id) ON DELETE CASCADE
 mrp_eco_bom_change_eco_id_fkey                                  | mrp_eco_bom_change                                            | FOREIGN KEY (eco_id) REFERENCES mrp_eco(id) ON DELETE CASCADE
 mrp_eco_mrp_eco_tag_rel_pkey                                    | mrp_eco_mrp_eco_tag_rel                                       | PRIMARY KEY (mrp_eco_id, mrp_eco_tag_id)
 mrp_eco_mrp_eco_tag_rel_mrp_eco_tag_id_fkey                     | mrp_eco_mrp_eco_tag_rel                                       | FOREIGN KEY (mrp_eco_tag_id) REFERENCES mrp_eco_tag(id) ON DELETE CASCADE
 mrp_eco_mrp_eco_tag_rel_mrp_eco_id_fkey                         | mrp_eco_mrp_eco_tag_rel                                       | FOREIGN KEY (mrp_eco_id) REFERENCES mrp_eco(id) ON DELETE CASCADE
 mrp_eco_routing_change_eco_id_fkey                              | mrp_eco_routing_change                                        | FOREIGN KEY (eco_id) REFERENCES mrp_eco(id) ON DELETE CASCADE
 mrp_eco_routing_change_pkey                                     | mrp_eco_routing_change                                        | PRIMARY KEY (id)
 mrp_eco_routing_change_quality_point_id_fkey                    | mrp_eco_routing_change                                        | FOREIGN KEY (quality_point_id) REFERENCES quality_point(id) ON DELETE SET NULL
 mrp_eco_routing_change_write_uid_fkey                           | mrp_eco_routing_change                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_eco_routing_change_create_uid_fkey                          | mrp_eco_routing_change                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_eco_routing_change_operation_id_fkey                        | mrp_eco_routing_change                                        | FOREIGN KEY (operation_id) REFERENCES mrp_routing_workcenter(id) ON DELETE SET NULL
 mrp_eco_routing_change_workcenter_id_fkey                       | mrp_eco_routing_change                                        | FOREIGN KEY (workcenter_id) REFERENCES mrp_workcenter(id) ON DELETE SET NULL
 mrp_eco_stage_pkey                                              | mrp_eco_stage                                                 | PRIMARY KEY (id)
 mrp_eco_stage_create_uid_fkey                                   | mrp_eco_stage                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_eco_stage_write_uid_fkey                                    | mrp_eco_stage                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_eco_stage_type_rel_type_id_fkey                             | mrp_eco_stage_type_rel                                        | FOREIGN KEY (type_id) REFERENCES mrp_eco_type(id) ON DELETE CASCADE
 mrp_eco_stage_type_rel_stage_id_fkey                            | mrp_eco_stage_type_rel                                        | FOREIGN KEY (stage_id) REFERENCES mrp_eco_stage(id) ON DELETE CASCADE
 mrp_eco_stage_type_rel_pkey                                     | mrp_eco_stage_type_rel                                        | PRIMARY KEY (type_id, stage_id)
 mrp_eco_tag_name_uniq                                           | mrp_eco_tag                                                   | UNIQUE (name)
 mrp_eco_tag_write_uid_fkey                                      | mrp_eco_tag                                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_eco_tag_create_uid_fkey                                     | mrp_eco_tag                                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_eco_tag_pkey                                                | mrp_eco_tag                                                   | PRIMARY KEY (id)
 mrp_eco_type_create_uid_fkey                                    | mrp_eco_type                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_eco_type_write_uid_fkey                                     | mrp_eco_type                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_eco_type_pkey                                               | mrp_eco_type                                                  | PRIMARY KEY (id)
 mrp_eco_type_alias_id_fkey                                      | mrp_eco_type                                                  | FOREIGN KEY (alias_id) REFERENCES mail_alias(id) ON DELETE RESTRICT
 mrp_production_lot_producing_id_fkey                            | mrp_production                                                | FOREIGN KEY (lot_producing_id) REFERENCES stock_lot(id) ON DELETE SET NULL
 mrp_production_pkey                                             | mrp_production                                                | PRIMARY KEY (id)
 mrp_production_sale_line_id_fkey                                | mrp_production                                                | FOREIGN KEY (sale_line_id) REFERENCES sale_order_line(id) ON DELETE SET NULL
 mrp_production_write_uid_fkey                                   | mrp_production                                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_production_project_id_fkey                                  | mrp_production                                                | FOREIGN KEY (project_id) REFERENCES project_project(id) ON DELETE SET NULL
 mrp_production_create_uid_fkey                                  | mrp_production                                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_production_production_location_id_fkey                      | mrp_production                                                | FOREIGN KEY (production_location_id) REFERENCES stock_location(id) ON DELETE SET NULL
 mrp_production_orderpoint_id_fkey                               | mrp_production                                                | FOREIGN KEY (orderpoint_id) REFERENCES stock_warehouse_orderpoint(id) ON DELETE SET NULL
 mrp_production_procurement_group_id_fkey                        | mrp_production                                                | FOREIGN KEY (procurement_group_id) REFERENCES procurement_group(id) ON DELETE SET NULL
 mrp_production_company_id_fkey                                  | mrp_production                                                | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 mrp_production_user_id_fkey                                     | mrp_production                                                | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_production_bom_id_fkey                                      | mrp_production                                                | FOREIGN KEY (bom_id) REFERENCES mrp_bom(id) ON DELETE SET NULL
 mrp_production_location_final_id_fkey                           | mrp_production                                                | FOREIGN KEY (location_final_id) REFERENCES stock_location(id) ON DELETE SET NULL
 mrp_production_location_dest_id_fkey                            | mrp_production                                                | FOREIGN KEY (location_dest_id) REFERENCES stock_location(id) ON DELETE RESTRICT
 mrp_production_location_src_id_fkey                             | mrp_production                                                | FOREIGN KEY (location_src_id) REFERENCES stock_location(id) ON DELETE RESTRICT
 mrp_production_picking_type_id_fkey                             | mrp_production                                                | FOREIGN KEY (picking_type_id) REFERENCES stock_picking_type(id) ON DELETE RESTRICT
 mrp_production_product_uom_id_fkey                              | mrp_production                                                | FOREIGN KEY (product_uom_id) REFERENCES uom_uom(id) ON DELETE RESTRICT
 mrp_production_product_id_fkey                                  | mrp_production                                                | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE RESTRICT
 mrp_production_qty_positive                                     | mrp_production                                                | CHECK ((product_qty > (0)::numeric))
 mrp_production_name_uniq                                        | mrp_production                                                | UNIQUE (name, company_id)
 mrp_production_additional_workorder_production_id_fkey          | mrp_production_additional_workorder                           | FOREIGN KEY (production_id) REFERENCES mrp_production(id) ON DELETE CASCADE
 mrp_production_additional_workorder_pkey                        | mrp_production_additional_workorder                           | PRIMARY KEY (id)
 mrp_production_additional_workorde_blocked_by_workorder_id_fkey | mrp_production_additional_workorder                           | FOREIGN KEY (blocked_by_workorder_id) REFERENCES mrp_workorder(id) ON DELETE SET NULL
 mrp_production_additional_workorder_workcenter_id_fkey          | mrp_production_additional_workorder                           | FOREIGN KEY (workcenter_id) REFERENCES mrp_workcenter(id) ON DELETE CASCADE
 mrp_production_additional_workorder_create_uid_fkey             | mrp_production_additional_workorder                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_production_additional_workorder_write_uid_fkey              | mrp_production_additional_workorder                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_production_backorder_create_uid_fkey                        | mrp_production_backorder                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_production_backorder_write_uid_fkey                         | mrp_production_backorder                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_production_backorder_pkey                                   | mrp_production_backorder                                      | PRIMARY KEY (id)
 mrp_production_backorder_line_pkey                              | mrp_production_backorder_line                                 | PRIMARY KEY (id)
 mrp_production_backorder_line_mrp_production_backorder_id_fkey  | mrp_production_backorder_line                                 | FOREIGN KEY (mrp_production_backorder_id) REFERENCES mrp_production_backorder(id) ON DELETE CASCADE
 mrp_production_backorder_line_mrp_production_id_fkey            | mrp_production_backorder_line                                 | FOREIGN KEY (mrp_production_id) REFERENCES mrp_production(id) ON DELETE CASCADE
 mrp_production_backorder_line_create_uid_fkey                   | mrp_production_backorder_line                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_production_backorder_line_write_uid_fkey                    | mrp_production_backorder_line                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_production_mrp_production_backorder_rel_pkey                | mrp_production_mrp_production_backorder_rel                   | PRIMARY KEY (mrp_production_backorder_id, mrp_production_id)
 mrp_production_mrp_production__mrp_production_backorder_id_fkey | mrp_production_mrp_production_backorder_rel                   | FOREIGN KEY (mrp_production_backorder_id) REFERENCES mrp_production_backorder(id) ON DELETE CASCADE
 mrp_production_mrp_production_backorder__mrp_production_id_fkey | mrp_production_mrp_production_backorder_rel                   | FOREIGN KEY (mrp_production_id) REFERENCES mrp_production(id) ON DELETE CASCADE
 mrp_production_picking_label_type_rel_pkey                      | mrp_production_picking_label_type_rel                         | PRIMARY KEY (picking_label_type_id, mrp_production_id)
 mrp_production_picking_label_type_re_picking_label_type_id_fkey | mrp_production_picking_label_type_rel                         | FOREIGN KEY (picking_label_type_id) REFERENCES picking_label_type(id) ON DELETE CASCADE
 mrp_production_picking_label_type_rel_mrp_production_id_fkey    | mrp_production_picking_label_type_rel                         | FOREIGN KEY (mrp_production_id) REFERENCES mrp_production(id) ON DELETE CASCADE
 mrp_production_split_write_uid_fkey                             | mrp_production_split                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_production_split_pkey                                       | mrp_production_split                                          | PRIMARY KEY (id)
 mrp_production_split_create_uid_fkey                            | mrp_production_split                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_production_split_production_split_multi_id_fkey             | mrp_production_split                                          | FOREIGN KEY (production_split_multi_id) REFERENCES mrp_production_split_multi(id) ON DELETE SET NULL
 mrp_production_split_production_id_fkey                         | mrp_production_split                                          | FOREIGN KEY (production_id) REFERENCES mrp_production(id) ON DELETE SET NULL
 mrp_production_split_line_user_id_fkey                          | mrp_production_split_line                                     | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_production_split_line_mrp_production_split_id_fkey          | mrp_production_split_line                                     | FOREIGN KEY (mrp_production_split_id) REFERENCES mrp_production_split(id) ON DELETE CASCADE
 mrp_production_split_line_create_uid_fkey                       | mrp_production_split_line                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_production_split_line_write_uid_fkey                        | mrp_production_split_line                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_production_split_line_pkey                                  | mrp_production_split_line                                     | PRIMARY KEY (id)
 mrp_production_split_multi_pkey                                 | mrp_production_split_multi                                    | PRIMARY KEY (id)
 mrp_production_split_multi_write_uid_fkey                       | mrp_production_split_multi                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_production_split_multi_create_uid_fkey                      | mrp_production_split_multi                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_routing_workcenter_pkey                                     | mrp_routing_workcenter                                        | PRIMARY KEY (id)
 mrp_routing_workcenter_create_uid_fkey                          | mrp_routing_workcenter                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_routing_workcenter_workcenter_id_fkey                       | mrp_routing_workcenter                                        | FOREIGN KEY (workcenter_id) REFERENCES mrp_workcenter(id) ON DELETE RESTRICT
 mrp_routing_workcenter_write_uid_fkey                           | mrp_routing_workcenter                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_routing_workcenter_bom_id_fkey                              | mrp_routing_workcenter                                        | FOREIGN KEY (bom_id) REFERENCES mrp_bom(id) ON DELETE CASCADE
 mrp_routing_workcenter_dependencies_rel_pkey                    | mrp_routing_workcenter_dependencies_rel                       | PRIMARY KEY (operation_id, blocked_by_id)
 mrp_routing_workcenter_dependencies_rel_blocked_by_id_fkey      | mrp_routing_workcenter_dependencies_rel                       | FOREIGN KEY (blocked_by_id) REFERENCES mrp_routing_workcenter(id) ON DELETE CASCADE
 mrp_routing_workcenter_dependencies_rel_operation_id_fkey       | mrp_routing_workcenter_dependencies_rel                       | FOREIGN KEY (operation_id) REFERENCES mrp_routing_workcenter(id) ON DELETE CASCADE
 mrp_routing_workcenter_product_template_attribute_value_re_pkey | mrp_routing_workcenter_product_template_attribute_value_rel   | PRIMARY KEY (mrp_routing_workcenter_id, product_template_attribute_value_id)
 mrp_routing_workcenter_product_t_mrp_routing_workcenter_id_fkey | mrp_routing_workcenter_product_template_attribute_value_rel   | FOREIGN KEY (mrp_routing_workcenter_id) REFERENCES mrp_routing_workcenter(id) ON DELETE CASCADE
 mrp_routing_workcenter_produc_product_template_attribute_v_fkey | mrp_routing_workcenter_product_template_attribute_value_rel   | FOREIGN KEY (product_template_attribute_value_id) REFERENCES product_template_attribute_value(id) ON DELETE RESTRICT
 mrp_unbuild_bom_id_fkey                                         | mrp_unbuild                                                   | FOREIGN KEY (bom_id) REFERENCES mrp_bom(id) ON DELETE SET NULL
 mrp_unbuild_location_id_fkey                                    | mrp_unbuild                                                   | FOREIGN KEY (location_id) REFERENCES stock_location(id) ON DELETE RESTRICT
 mrp_unbuild_location_dest_id_fkey                               | mrp_unbuild                                                   | FOREIGN KEY (location_dest_id) REFERENCES stock_location(id) ON DELETE RESTRICT
 mrp_unbuild_create_uid_fkey                                     | mrp_unbuild                                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_unbuild_pkey                                                | mrp_unbuild                                                   | PRIMARY KEY (id)
 mrp_unbuild_product_id_fkey                                     | mrp_unbuild                                                   | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE RESTRICT
 mrp_unbuild_company_id_fkey                                     | mrp_unbuild                                                   | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 mrp_unbuild_product_uom_id_fkey                                 | mrp_unbuild                                                   | FOREIGN KEY (product_uom_id) REFERENCES uom_uom(id) ON DELETE RESTRICT
 mrp_unbuild_mo_id_fkey                                          | mrp_unbuild                                                   | FOREIGN KEY (mo_id) REFERENCES mrp_production(id) ON DELETE SET NULL
 mrp_unbuild_qty_positive                                        | mrp_unbuild                                                   | CHECK ((product_qty > (0)::numeric))
 mrp_unbuild_write_uid_fkey                                      | mrp_unbuild                                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_unbuild_lot_id_fkey                                         | mrp_unbuild                                                   | FOREIGN KEY (lot_id) REFERENCES stock_lot(id) ON DELETE SET NULL
 mrp_workcenter_company_id_fkey                                  | mrp_workcenter                                                | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 mrp_workcenter_resource_calendar_id_fkey                        | mrp_workcenter                                                | FOREIGN KEY (resource_calendar_id) REFERENCES resource_calendar(id) ON DELETE SET NULL
 mrp_workcenter_create_uid_fkey                                  | mrp_workcenter                                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_workcenter_pkey                                             | mrp_workcenter                                                | PRIMARY KEY (id)
 mrp_workcenter_write_uid_fkey                                   | mrp_workcenter                                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_workcenter_resource_id_fkey                                 | mrp_workcenter                                                | FOREIGN KEY (resource_id) REFERENCES resource_resource(id) ON DELETE RESTRICT
 mrp_workcenter_expense_account_id_fkey                          | mrp_workcenter                                                | FOREIGN KEY (expense_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 mrp_workcenter_alternative_rel_pkey                             | mrp_workcenter_alternative_rel                                | PRIMARY KEY (workcenter_id, alternative_workcenter_id)
 mrp_workcenter_alternative_rel_alternative_workcenter_id_fkey   | mrp_workcenter_alternative_rel                                | FOREIGN KEY (alternative_workcenter_id) REFERENCES mrp_workcenter(id) ON DELETE CASCADE
 mrp_workcenter_alternative_rel_workcenter_id_fkey               | mrp_workcenter_alternative_rel                                | FOREIGN KEY (workcenter_id) REFERENCES mrp_workcenter(id) ON DELETE CASCADE
 mrp_workcenter_capacity_positive_capacity                       | mrp_workcenter_capacity                                       | CHECK ((capacity > (0)::double precision))
 mrp_workcenter_capacity_pkey                                    | mrp_workcenter_capacity                                       | PRIMARY KEY (id)
 mrp_workcenter_capacity_write_uid_fkey                          | mrp_workcenter_capacity                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_workcenter_capacity_create_uid_fkey                         | mrp_workcenter_capacity                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_workcenter_capacity_product_id_fkey                         | mrp_workcenter_capacity                                       | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE RESTRICT
 mrp_workcenter_capacity_workcenter_id_fkey                      | mrp_workcenter_capacity                                       | FOREIGN KEY (workcenter_id) REFERENCES mrp_workcenter(id) ON DELETE RESTRICT
 mrp_workcenter_capacity_unique_product                          | mrp_workcenter_capacity                                       | UNIQUE (workcenter_id, product_id)
 mrp_workcenter_mrp_workcenter_tag_rel_pkey                      | mrp_workcenter_mrp_workcenter_tag_rel                         | PRIMARY KEY (mrp_workcenter_id, mrp_workcenter_tag_id)
 mrp_workcenter_mrp_workcenter_tag_rel_mrp_workcenter_id_fkey    | mrp_workcenter_mrp_workcenter_tag_rel                         | FOREIGN KEY (mrp_workcenter_id) REFERENCES mrp_workcenter(id) ON DELETE CASCADE
 mrp_workcenter_mrp_workcenter_tag_re_mrp_workcenter_tag_id_fkey | mrp_workcenter_mrp_workcenter_tag_rel                         | FOREIGN KEY (mrp_workcenter_tag_id) REFERENCES mrp_workcenter_tag(id) ON DELETE CASCADE
 mrp_workcenter_productivity_employee_id_fkey                    | mrp_workcenter_productivity                                   | FOREIGN KEY (employee_id) REFERENCES hr_employee(id) ON DELETE SET NULL
 mrp_workcenter_productivity_create_uid_fkey                     | mrp_workcenter_productivity                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_workcenter_productivity_write_uid_fkey                      | mrp_workcenter_productivity                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_workcenter_productivity_workorder_id_fkey                   | mrp_workcenter_productivity                                   | FOREIGN KEY (workorder_id) REFERENCES mrp_workorder(id) ON DELETE SET NULL
 mrp_workcenter_productivity_user_id_fkey                        | mrp_workcenter_productivity                                   | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_workcenter_productivity_pkey                                | mrp_workcenter_productivity                                   | PRIMARY KEY (id)
 mrp_workcenter_productivity_account_move_line_id_fkey           | mrp_workcenter_productivity                                   | FOREIGN KEY (account_move_line_id) REFERENCES account_move_line(id) ON DELETE SET NULL
 mrp_workcenter_productivity_company_id_fkey                     | mrp_workcenter_productivity                                   | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 mrp_workcenter_productivity_workcenter_id_fkey                  | mrp_workcenter_productivity                                   | FOREIGN KEY (workcenter_id) REFERENCES mrp_workcenter(id) ON DELETE RESTRICT
 mrp_workcenter_productivity_loss_id_fkey                        | mrp_workcenter_productivity                                   | FOREIGN KEY (loss_id) REFERENCES mrp_workcenter_productivity_loss(id) ON DELETE RESTRICT
 mrp_workcenter_productivity_loss_write_uid_fkey                 | mrp_workcenter_productivity_loss                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_workcenter_productivity_loss_pkey                           | mrp_workcenter_productivity_loss                              | PRIMARY KEY (id)
 mrp_workcenter_productivity_loss_create_uid_fkey                | mrp_workcenter_productivity_loss                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_workcenter_productivity_loss_loss_id_fkey                   | mrp_workcenter_productivity_loss                              | FOREIGN KEY (loss_id) REFERENCES mrp_workcenter_productivity_loss_type(id) ON DELETE SET NULL
 mrp_workcenter_productivity_loss_type_create_uid_fkey           | mrp_workcenter_productivity_loss_type                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_workcenter_productivity_loss_type_write_uid_fkey            | mrp_workcenter_productivity_loss_type                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_workcenter_productivity_loss_type_pkey                      | mrp_workcenter_productivity_loss_type                         | PRIMARY KEY (id)
 mrp_workcenter_tag_write_uid_fkey                               | mrp_workcenter_tag                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_workcenter_tag_tag_name_unique                              | mrp_workcenter_tag                                            | UNIQUE (name)
 mrp_workcenter_tag_pkey                                         | mrp_workcenter_tag                                            | PRIMARY KEY (id)
 mrp_workcenter_tag_create_uid_fkey                              | mrp_workcenter_tag                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_workorder_product_id_fkey                                   | mrp_workorder                                                 | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE SET NULL
 mrp_workorder_product_uom_id_fkey                               | mrp_workorder                                                 | FOREIGN KEY (product_uom_id) REFERENCES uom_uom(id) ON DELETE RESTRICT
 mrp_workorder_production_id_fkey                                | mrp_workorder                                                 | FOREIGN KEY (production_id) REFERENCES mrp_production(id) ON DELETE RESTRICT
 mrp_workorder_current_quality_check_id_fkey                     | mrp_workorder                                                 | FOREIGN KEY (current_quality_check_id) REFERENCES quality_check(id) ON DELETE SET NULL
 mrp_workorder_write_uid_fkey                                    | mrp_workorder                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_workorder_operation_id_fkey                                 | mrp_workorder                                                 | FOREIGN KEY (operation_id) REFERENCES mrp_routing_workcenter(id) ON DELETE SET NULL
 mrp_workorder_create_uid_fkey                                   | mrp_workorder                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 mrp_workorder_leave_id_fkey                                     | mrp_workorder                                                 | FOREIGN KEY (leave_id) REFERENCES resource_calendar_leaves(id) ON DELETE SET NULL
 mrp_workorder_pkey                                              | mrp_workorder                                                 | PRIMARY KEY (id)
 mrp_workorder_workcenter_id_fkey                                | mrp_workorder                                                 | FOREIGN KEY (workcenter_id) REFERENCES mrp_workcenter(id) ON DELETE RESTRICT
 mrp_workorder_additional_employee_assigned_pkey                 | mrp_workorder_additional_employee_assigned                    | PRIMARY KEY (additional_workorder_id, employee_id)
 mrp_workorder_additional_employee_assigned_employee_id_fkey     | mrp_workorder_additional_employee_assigned                    | FOREIGN KEY (employee_id) REFERENCES hr_employee(id) ON DELETE CASCADE
 mrp_workorder_additional_employee__additional_workorder_id_fkey | mrp_workorder_additional_employee_assigned                    | FOREIGN KEY (additional_workorder_id) REFERENCES mrp_production_additional_workorder(id) ON DELETE CASCADE
 mrp_workorder_dependencies_rel_workorder_id_fkey                | mrp_workorder_dependencies_rel                                | FOREIGN KEY (workorder_id) REFERENCES mrp_workorder(id) ON DELETE CASCADE
 mrp_workorder_dependencies_rel_pkey                             | mrp_workorder_dependencies_rel                                | PRIMARY KEY (workorder_id, blocked_by_id)
 mrp_workorder_dependencies_rel_blocked_by_id_fkey               | mrp_workorder_dependencies_rel                                | FOREIGN KEY (blocked_by_id) REFERENCES mrp_workorder(id) ON DELETE CASCADE
 mrp_workorder_employee_assigned_employee_id_fkey                | mrp_workorder_employee_assigned                               | FOREIGN KEY (employee_id) REFERENCES hr_employee(id) ON DELETE CASCADE
 mrp_workorder_employee_assigned_pkey                            | mrp_workorder_employee_assigned                               | PRIMARY KEY (workorder_id, employee_id)
 mrp_workorder_employee_assigned_workorder_id_fkey               | mrp_workorder_employee_assigned                               | FOREIGN KEY (workorder_id) REFERENCES mrp_workorder(id) ON DELETE CASCADE
 mrp_workorder_mo_analytic_rel_pkey                              | mrp_workorder_mo_analytic_rel                                 | PRIMARY KEY (mrp_workorder_id, account_analytic_line_id)
 mrp_workorder_mo_analytic_rel_account_analytic_line_id_fkey     | mrp_workorder_mo_analytic_rel                                 | FOREIGN KEY (account_analytic_line_id) REFERENCES account_analytic_line(id) ON DELETE CASCADE
 mrp_workorder_mo_analytic_rel_mrp_workorder_id_fkey             | mrp_workorder_mo_analytic_rel                                 | FOREIGN KEY (mrp_workorder_id) REFERENCES mrp_workorder(id) ON DELETE CASCADE
 mrp_workorder_quality_point_rel_mrp_workorder_id_fkey           | mrp_workorder_quality_point_rel                               | FOREIGN KEY (mrp_workorder_id) REFERENCES mrp_workorder(id) ON DELETE CASCADE
 mrp_workorder_quality_point_rel_quality_point_id_fkey           | mrp_workorder_quality_point_rel                               | FOREIGN KEY (quality_point_id) REFERENCES quality_point(id) ON DELETE CASCADE
 mrp_workorder_quality_point_rel_pkey                            | mrp_workorder_quality_point_rel                               | PRIMARY KEY (mrp_workorder_id, quality_point_id)
 mrp_workorder_wc_analytic_rel_account_analytic_line_id_fkey     | mrp_workorder_wc_analytic_rel                                 | FOREIGN KEY (account_analytic_line_id) REFERENCES account_analytic_line(id) ON DELETE CASCADE
 mrp_workorder_wc_analytic_rel_mrp_workorder_id_fkey             | mrp_workorder_wc_analytic_rel                                 | FOREIGN KEY (mrp_workorder_id) REFERENCES mrp_workorder(id) ON DELETE CASCADE
 mrp_workorder_wc_analytic_rel_pkey                              | mrp_workorder_wc_analytic_rel                                 | PRIMARY KEY (mrp_workorder_id, account_analytic_line_id)
 onboarding_onboarding_pkey                                      | onboarding_onboarding                                         | PRIMARY KEY (id)
 onboarding_onboarding_write_uid_fkey                            | onboarding_onboarding                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 onboarding_onboarding_route_name_uniq                           | onboarding_onboarding                                         | UNIQUE (route_name)
 onboarding_onboarding_create_uid_fkey                           | onboarding_onboarding                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 onboarding_onboarding_onboarding__onboarding_onboarding_id_fkey | onboarding_onboarding_onboarding_onboarding_step_rel          | FOREIGN KEY (onboarding_onboarding_id) REFERENCES onboarding_onboarding(id) ON DELETE CASCADE
 onboarding_onboarding_onboard_onboarding_onboarding_step_i_fkey | onboarding_onboarding_onboarding_onboarding_step_rel          | FOREIGN KEY (onboarding_onboarding_step_id) REFERENCES onboarding_onboarding_step(id) ON DELETE CASCADE
 onboarding_onboarding_onboarding_onboarding_step_rel_pkey       | onboarding_onboarding_onboarding_onboarding_step_rel          | PRIMARY KEY (onboarding_onboarding_id, onboarding_onboarding_step_id)
 onboarding_onboarding_step_create_uid_fkey                      | onboarding_onboarding_step                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 onboarding_onboarding_step_pkey                                 | onboarding_onboarding_step                                    | PRIMARY KEY (id)
 onboarding_onboarding_step_write_uid_fkey                       | onboarding_onboarding_step                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 onboarding_progress_company_id_fkey                             | onboarding_progress                                           | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE CASCADE
 onboarding_progress_pkey                                        | onboarding_progress                                           | PRIMARY KEY (id)
 onboarding_progress_write_uid_fkey                              | onboarding_progress                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 onboarding_progress_create_uid_fkey                             | onboarding_progress                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 onboarding_progress_onboarding_id_fkey                          | onboarding_progress                                           | FOREIGN KEY (onboarding_id) REFERENCES onboarding_onboarding(id) ON DELETE CASCADE
 onboarding_progress_onboarding_prog_onboarding_progress_id_fkey | onboarding_progress_onboarding_progress_step_rel              | FOREIGN KEY (onboarding_progress_id) REFERENCES onboarding_progress(id) ON DELETE CASCADE
 onboarding_progress_onboarding_onboarding_progress_step_id_fkey | onboarding_progress_onboarding_progress_step_rel              | FOREIGN KEY (onboarding_progress_step_id) REFERENCES onboarding_progress_step(id) ON DELETE CASCADE
 onboarding_progress_onboarding_progress_step_rel_pkey           | onboarding_progress_onboarding_progress_step_rel              | PRIMARY KEY (onboarding_progress_id, onboarding_progress_step_id)
 onboarding_progress_step_company_id_fkey                        | onboarding_progress_step                                      | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE CASCADE
 onboarding_progress_step_pkey                                   | onboarding_progress_step                                      | PRIMARY KEY (id)
 onboarding_progress_step_write_uid_fkey                         | onboarding_progress_step                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 onboarding_progress_step_step_id_fkey                           | onboarding_progress_step                                      | FOREIGN KEY (step_id) REFERENCES onboarding_onboarding_step(id) ON DELETE CASCADE
 onboarding_progress_step_create_uid_fkey                        | onboarding_progress_step                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 payment_capture_wizard_write_uid_fkey                           | payment_capture_wizard                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 payment_capture_wizard_pkey                                     | payment_capture_wizard                                        | PRIMARY KEY (id)
 payment_capture_wizard_create_uid_fkey                          | payment_capture_wizard                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 payment_capture_wizard_payment_transaction_rel_pkey             | payment_capture_wizard_payment_transaction_rel                | PRIMARY KEY (payment_capture_wizard_id, payment_transaction_id)
 payment_capture_wizard_payment_t_payment_capture_wizard_id_fkey | payment_capture_wizard_payment_transaction_rel                | FOREIGN KEY (payment_capture_wizard_id) REFERENCES payment_capture_wizard(id) ON DELETE CASCADE
 payment_capture_wizard_payment_tran_payment_transaction_id_fkey | payment_capture_wizard_payment_transaction_rel                | FOREIGN KEY (payment_transaction_id) REFERENCES payment_transaction(id) ON DELETE CASCADE
 payment_country_rel_payment_id_fkey                             | payment_country_rel                                           | FOREIGN KEY (payment_id) REFERENCES payment_provider(id) ON DELETE CASCADE
 payment_country_rel_country_id_fkey                             | payment_country_rel                                           | FOREIGN KEY (country_id) REFERENCES res_country(id) ON DELETE CASCADE
 payment_country_rel_pkey                                        | payment_country_rel                                           | PRIMARY KEY (payment_id, country_id)
 payment_currency_rel_pkey                                       | payment_currency_rel                                          | PRIMARY KEY (payment_provider_id, currency_id)
 payment_currency_rel_payment_provider_id_fkey                   | payment_currency_rel                                          | FOREIGN KEY (payment_provider_id) REFERENCES payment_provider(id) ON DELETE CASCADE
 payment_currency_rel_currency_id_fkey                           | payment_currency_rel                                          | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE CASCADE
 payment_link_wizard_currency_id_fkey                            | payment_link_wizard                                           | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 payment_link_wizard_pkey                                        | payment_link_wizard                                           | PRIMARY KEY (id)
 payment_link_wizard_partner_id_fkey                             | payment_link_wizard                                           | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 payment_link_wizard_create_uid_fkey                             | payment_link_wizard                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 payment_link_wizard_write_uid_fkey                              | payment_link_wizard                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 payment_method_create_uid_fkey                                  | payment_method                                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 payment_method_primary_payment_method_id_fkey                   | payment_method                                                | FOREIGN KEY (primary_payment_method_id) REFERENCES payment_method(id) ON DELETE SET NULL
 payment_method_pkey                                             | payment_method                                                | PRIMARY KEY (id)
 payment_method_write_uid_fkey                                   | payment_method                                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 payment_method_payment_provider_rel_pkey                        | payment_method_payment_provider_rel                           | PRIMARY KEY (payment_method_id, payment_provider_id)
 payment_method_payment_provider_rel_payment_method_id_fkey      | payment_method_payment_provider_rel                           | FOREIGN KEY (payment_method_id) REFERENCES payment_method(id) ON DELETE CASCADE
 payment_method_payment_provider_rel_payment_provider_id_fkey    | payment_method_payment_provider_rel                           | FOREIGN KEY (payment_provider_id) REFERENCES payment_provider(id) ON DELETE CASCADE
 payment_method_res_country_rel_res_country_id_fkey              | payment_method_res_country_rel                                | FOREIGN KEY (res_country_id) REFERENCES res_country(id) ON DELETE CASCADE
 payment_method_res_country_rel_pkey                             | payment_method_res_country_rel                                | PRIMARY KEY (payment_method_id, res_country_id)
 payment_method_res_country_rel_payment_method_id_fkey           | payment_method_res_country_rel                                | FOREIGN KEY (payment_method_id) REFERENCES payment_method(id) ON DELETE CASCADE
 payment_method_res_currency_rel_pkey                            | payment_method_res_currency_rel                               | PRIMARY KEY (payment_method_id, res_currency_id)
 payment_method_res_currency_rel_payment_method_id_fkey          | payment_method_res_currency_rel                               | FOREIGN KEY (payment_method_id) REFERENCES payment_method(id) ON DELETE CASCADE
 payment_method_res_currency_rel_res_currency_id_fkey            | payment_method_res_currency_rel                               | FOREIGN KEY (res_currency_id) REFERENCES res_currency(id) ON DELETE CASCADE
 payment_provider_company_id_fkey                                | payment_provider                                              | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 payment_provider_redirect_form_view_id_fkey                     | payment_provider                                              | FOREIGN KEY (redirect_form_view_id) REFERENCES ir_ui_view(id) ON DELETE RESTRICT
 payment_provider_inline_form_view_id_fkey                       | payment_provider                                              | FOREIGN KEY (inline_form_view_id) REFERENCES ir_ui_view(id) ON DELETE RESTRICT
 payment_provider_token_inline_form_view_id_fkey                 | payment_provider                                              | FOREIGN KEY (token_inline_form_view_id) REFERENCES ir_ui_view(id) ON DELETE RESTRICT
 payment_provider_express_checkout_form_view_id_fkey             | payment_provider                                              | FOREIGN KEY (express_checkout_form_view_id) REFERENCES ir_ui_view(id) ON DELETE RESTRICT
 payment_provider_module_id_fkey                                 | payment_provider                                              | FOREIGN KEY (module_id) REFERENCES ir_module_module(id) ON DELETE SET NULL
 payment_provider_website_id_fkey                                | payment_provider                                              | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE RESTRICT
 payment_provider_pkey                                           | payment_provider                                              | PRIMARY KEY (id)
 payment_provider_create_uid_fkey                                | payment_provider                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 payment_provider_write_uid_fkey                                 | payment_provider                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 payment_provider_onboarding_wizard_create_uid_fkey              | payment_provider_onboarding_wizard                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 payment_provider_onboarding_wizard_write_uid_fkey               | payment_provider_onboarding_wizard                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 payment_provider_onboarding_wizard_pkey                         | payment_provider_onboarding_wizard                            | PRIMARY KEY (id)
 payment_refund_wizard_write_uid_fkey                            | payment_refund_wizard                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 payment_refund_wizard_payment_id_fkey                           | payment_refund_wizard                                         | FOREIGN KEY (payment_id) REFERENCES account_payment(id) ON DELETE SET NULL
 payment_refund_wizard_create_uid_fkey                           | payment_refund_wizard                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 payment_refund_wizard_pkey                                      | payment_refund_wizard                                         | PRIMARY KEY (id)
 payment_token_create_uid_fkey                                   | payment_token                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 payment_token_payment_method_id_fkey                            | payment_token                                                 | FOREIGN KEY (payment_method_id) REFERENCES payment_method(id) ON DELETE RESTRICT
 payment_token_provider_id_fkey                                  | payment_token                                                 | FOREIGN KEY (provider_id) REFERENCES payment_provider(id) ON DELETE RESTRICT
 payment_token_company_id_fkey                                   | payment_token                                                 | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 payment_token_pkey                                              | payment_token                                                 | PRIMARY KEY (id)
 payment_token_write_uid_fkey                                    | payment_token                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 payment_token_partner_id_fkey                                   | payment_token                                                 | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE RESTRICT
 payment_transaction_partner_id_fkey                             | payment_transaction                                           | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE RESTRICT
 payment_transaction_write_uid_fkey                              | payment_transaction                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 payment_transaction_create_uid_fkey                             | payment_transaction                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 payment_transaction_partner_country_id_fkey                     | payment_transaction                                           | FOREIGN KEY (partner_country_id) REFERENCES res_country(id) ON DELETE SET NULL
 payment_transaction_partner_state_id_fkey                       | payment_transaction                                           | FOREIGN KEY (partner_state_id) REFERENCES res_country_state(id) ON DELETE SET NULL
 payment_transaction_source_transaction_id_fkey                  | payment_transaction                                           | FOREIGN KEY (source_transaction_id) REFERENCES payment_transaction(id) ON DELETE SET NULL
 payment_transaction_token_id_fkey                               | payment_transaction                                           | FOREIGN KEY (token_id) REFERENCES payment_token(id) ON DELETE RESTRICT
 payment_transaction_currency_id_fkey                            | payment_transaction                                           | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE RESTRICT
 payment_transaction_payment_method_id_fkey                      | payment_transaction                                           | FOREIGN KEY (payment_method_id) REFERENCES payment_method(id) ON DELETE RESTRICT
 payment_transaction_company_id_fkey                             | payment_transaction                                           | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 payment_transaction_provider_id_fkey                            | payment_transaction                                           | FOREIGN KEY (provider_id) REFERENCES payment_provider(id) ON DELETE RESTRICT
 payment_transaction_reference_uniq                              | payment_transaction                                           | UNIQUE (reference)
 payment_transaction_pkey                                        | payment_transaction                                           | PRIMARY KEY (id)
 payment_transaction_payment_id_fkey                             | payment_transaction                                           | FOREIGN KEY (payment_id) REFERENCES account_payment(id) ON DELETE SET NULL
 pg_aggregate_fnoid_index                                        | pg_aggregate                                                  | PRIMARY KEY (aggfnoid)
 pg_am_name_index                                                | pg_am                                                         | UNIQUE (amname)
 pg_am_oid_index                                                 | pg_am                                                         | PRIMARY KEY (oid)
 pg_amop_fam_strat_index                                         | pg_amop                                                       | UNIQUE (amopfamily, amoplefttype, amoprighttype, amopstrategy)
 pg_amop_opr_fam_index                                           | pg_amop                                                       | UNIQUE (amopopr, amoppurpose, amopfamily)
 pg_amop_oid_index                                               | pg_amop                                                       | PRIMARY KEY (oid)
 pg_amproc_fam_proc_index                                        | pg_amproc                                                     | UNIQUE (amprocfamily, amproclefttype, amprocrighttype, amprocnum)
 pg_amproc_oid_index                                             | pg_amproc                                                     | PRIMARY KEY (oid)
 pg_attrdef_adrelid_adnum_index                                  | pg_attrdef                                                    | UNIQUE (adrelid, adnum)
 pg_attrdef_oid_index                                            | pg_attrdef                                                    | PRIMARY KEY (oid)
 pg_attribute_relid_attnam_index                                 | pg_attribute                                                  | UNIQUE (attrelid, attname)
 pg_attribute_relid_attnum_index                                 | pg_attribute                                                  | PRIMARY KEY (attrelid, attnum)
 pg_auth_members_member_role_index                               | pg_auth_members                                               | UNIQUE (member, roleid, grantor)
 pg_auth_members_oid_index                                       | pg_auth_members                                               | PRIMARY KEY (oid)
 pg_auth_members_role_member_index                               | pg_auth_members                                               | UNIQUE (roleid, member, grantor)
 pg_authid_oid_index                                             | pg_authid                                                     | PRIMARY KEY (oid)
 pg_authid_rolname_index                                         | pg_authid                                                     | UNIQUE (rolname)
 pg_cast_source_target_index                                     | pg_cast                                                       | UNIQUE (castsource, casttarget)
 pg_cast_oid_index                                               | pg_cast                                                       | PRIMARY KEY (oid)
 pg_class_relname_nsp_index                                      | pg_class                                                      | UNIQUE (relname, relnamespace)
 pg_class_oid_index                                              | pg_class                                                      | PRIMARY KEY (oid)
 pg_collation_name_enc_nsp_index                                 | pg_collation                                                  | UNIQUE (collname, collencoding, collnamespace)
 pg_collation_oid_index                                          | pg_collation                                                  | PRIMARY KEY (oid)
 pg_constraint_oid_index                                         | pg_constraint                                                 | PRIMARY KEY (oid)
 pg_constraint_conrelid_contypid_conname_index                   | pg_constraint                                                 | UNIQUE (conrelid, contypid, conname)
 pg_conversion_oid_index                                         | pg_conversion                                                 | PRIMARY KEY (oid)
 pg_conversion_default_index                                     | pg_conversion                                                 | UNIQUE (connamespace, conforencoding, contoencoding, oid)
 pg_conversion_name_nsp_index                                    | pg_conversion                                                 | UNIQUE (conname, connamespace)
 pg_database_datname_index                                       | pg_database                                                   | UNIQUE (datname)
 pg_database_oid_index                                           | pg_database                                                   | PRIMARY KEY (oid)
 pg_db_role_setting_databaseid_rol_index                         | pg_db_role_setting                                            | PRIMARY KEY (setdatabase, setrole)
 pg_default_acl_oid_index                                        | pg_default_acl                                                | PRIMARY KEY (oid)
 pg_default_acl_role_nsp_obj_index                               | pg_default_acl                                                | UNIQUE (defaclrole, defaclnamespace, defaclobjtype)
 pg_description_o_c_o_index                                      | pg_description                                                | PRIMARY KEY (objoid, classoid, objsubid)
 pg_enum_oid_index                                               | pg_enum                                                       | PRIMARY KEY (oid)
 pg_enum_typid_label_index                                       | pg_enum                                                       | UNIQUE (enumtypid, enumlabel)
 pg_enum_typid_sortorder_index                                   | pg_enum                                                       | UNIQUE (enumtypid, enumsortorder)
 pg_event_trigger_evtname_index                                  | pg_event_trigger                                              | UNIQUE (evtname)
 pg_event_trigger_oid_index                                      | pg_event_trigger                                              | PRIMARY KEY (oid)
 pg_extension_oid_index                                          | pg_extension                                                  | PRIMARY KEY (oid)
 pg_extension_name_index                                         | pg_extension                                                  | UNIQUE (extname)
 pg_foreign_data_wrapper_name_index                              | pg_foreign_data_wrapper                                       | UNIQUE (fdwname)
 pg_foreign_data_wrapper_oid_index                               | pg_foreign_data_wrapper                                       | PRIMARY KEY (oid)
 pg_foreign_server_name_index                                    | pg_foreign_server                                             | UNIQUE (srvname)
 pg_foreign_server_oid_index                                     | pg_foreign_server                                             | PRIMARY KEY (oid)
 pg_foreign_table_relid_index                                    | pg_foreign_table                                              | PRIMARY KEY (ftrelid)
 pg_index_indexrelid_index                                       | pg_index                                                      | PRIMARY KEY (indexrelid)
 pg_inherits_relid_seqno_index                                   | pg_inherits                                                   | PRIMARY KEY (inhrelid, inhseqno)
 pg_init_privs_o_c_o_index                                       | pg_init_privs                                                 | PRIMARY KEY (objoid, classoid, objsubid)
 pg_language_name_index                                          | pg_language                                                   | UNIQUE (lanname)
 pg_language_oid_index                                           | pg_language                                                   | PRIMARY KEY (oid)
 pg_largeobject_loid_pn_index                                    | pg_largeobject                                                | PRIMARY KEY (loid, pageno)
 pg_largeobject_metadata_oid_index                               | pg_largeobject_metadata                                       | PRIMARY KEY (oid)
 pg_namespace_oid_index                                          | pg_namespace                                                  | PRIMARY KEY (oid)
 pg_namespace_nspname_index                                      | pg_namespace                                                  | UNIQUE (nspname)
 pg_opclass_oid_index                                            | pg_opclass                                                    | PRIMARY KEY (oid)
 pg_opclass_am_name_nsp_index                                    | pg_opclass                                                    | UNIQUE (opcmethod, opcname, opcnamespace)
 pg_operator_oprname_l_r_n_index                                 | pg_operator                                                   | UNIQUE (oprname, oprleft, oprright, oprnamespace)
 pg_operator_oid_index                                           | pg_operator                                                   | PRIMARY KEY (oid)
 pg_opfamily_am_name_nsp_index                                   | pg_opfamily                                                   | UNIQUE (opfmethod, opfname, opfnamespace)
 pg_opfamily_oid_index                                           | pg_opfamily                                                   | PRIMARY KEY (oid)
 pg_parameter_acl_parname_index                                  | pg_parameter_acl                                              | UNIQUE (parname)
 pg_parameter_acl_oid_index                                      | pg_parameter_acl                                              | PRIMARY KEY (oid)
 pg_partitioned_table_partrelid_index                            | pg_partitioned_table                                          | PRIMARY KEY (partrelid)
 pg_policy_oid_index                                             | pg_policy                                                     | PRIMARY KEY (oid)
 pg_policy_polrelid_polname_index                                | pg_policy                                                     | UNIQUE (polrelid, polname)
 pg_proc_oid_index                                               | pg_proc                                                       | PRIMARY KEY (oid)
 pg_proc_proname_args_nsp_index                                  | pg_proc                                                       | UNIQUE (proname, proargtypes, pronamespace)
 pg_publication_oid_index                                        | pg_publication                                                | PRIMARY KEY (oid)
 pg_publication_pubname_index                                    | pg_publication                                                | UNIQUE (pubname)
 pg_publication_namespace_pnnspid_pnpubid_index                  | pg_publication_namespace                                      | UNIQUE (pnnspid, pnpubid)
 pg_publication_namespace_oid_index                              | pg_publication_namespace                                      | PRIMARY KEY (oid)
 pg_publication_rel_oid_index                                    | pg_publication_rel                                            | PRIMARY KEY (oid)
 pg_publication_rel_prrelid_prpubid_index                        | pg_publication_rel                                            | UNIQUE (prrelid, prpubid)
 pg_range_rngmultitypid_index                                    | pg_range                                                      | UNIQUE (rngmultitypid)
 pg_range_rngtypid_index                                         | pg_range                                                      | PRIMARY KEY (rngtypid)
 pg_replication_origin_roiident_index                            | pg_replication_origin                                         | PRIMARY KEY (roident)
 pg_replication_origin_roname_index                              | pg_replication_origin                                         | UNIQUE (roname)
 pg_rewrite_oid_index                                            | pg_rewrite                                                    | PRIMARY KEY (oid)
 pg_rewrite_rel_rulename_index                                   | pg_rewrite                                                    | UNIQUE (ev_class, rulename)
 pg_seclabel_object_index                                        | pg_seclabel                                                   | PRIMARY KEY (objoid, classoid, objsubid, provider)
 pg_sequence_seqrelid_index                                      | pg_sequence                                                   | PRIMARY KEY (seqrelid)
 pg_shdescription_o_c_index                                      | pg_shdescription                                              | PRIMARY KEY (objoid, classoid)
 pg_shseclabel_object_index                                      | pg_shseclabel                                                 | PRIMARY KEY (objoid, classoid, provider)
 pg_statistic_relid_att_inh_index                                | pg_statistic                                                  | PRIMARY KEY (starelid, staattnum, stainherit)
 pg_statistic_ext_oid_index                                      | pg_statistic_ext                                              | PRIMARY KEY (oid)
 pg_statistic_ext_name_index                                     | pg_statistic_ext                                              | UNIQUE (stxname, stxnamespace)
 pg_statistic_ext_data_stxoid_inh_index                          | pg_statistic_ext_data                                         | PRIMARY KEY (stxoid, stxdinherit)
 pg_subscription_subname_index                                   | pg_subscription                                               | UNIQUE (subdbid, subname)
 pg_subscription_oid_index                                       | pg_subscription                                               | PRIMARY KEY (oid)
 pg_subscription_rel_srrelid_srsubid_index                       | pg_subscription_rel                                           | PRIMARY KEY (srrelid, srsubid)
 pg_tablespace_spcname_index                                     | pg_tablespace                                                 | UNIQUE (spcname)
 pg_tablespace_oid_index                                         | pg_tablespace                                                 | PRIMARY KEY (oid)
 pg_transform_type_lang_index                                    | pg_transform                                                  | UNIQUE (trftype, trflang)
 pg_transform_oid_index                                          | pg_transform                                                  | PRIMARY KEY (oid)
 pg_trigger_tgrelid_tgname_index                                 | pg_trigger                                                    | UNIQUE (tgrelid, tgname)
 pg_trigger_oid_index                                            | pg_trigger                                                    | PRIMARY KEY (oid)
 pg_ts_config_cfgname_index                                      | pg_ts_config                                                  | UNIQUE (cfgname, cfgnamespace)
 pg_ts_config_oid_index                                          | pg_ts_config                                                  | PRIMARY KEY (oid)
 pg_ts_config_map_index                                          | pg_ts_config_map                                              | PRIMARY KEY (mapcfg, maptokentype, mapseqno)
 pg_ts_dict_oid_index                                            | pg_ts_dict                                                    | PRIMARY KEY (oid)
 pg_ts_dict_dictname_index                                       | pg_ts_dict                                                    | UNIQUE (dictname, dictnamespace)
 pg_ts_parser_oid_index                                          | pg_ts_parser                                                  | PRIMARY KEY (oid)
 pg_ts_parser_prsname_index                                      | pg_ts_parser                                                  | UNIQUE (prsname, prsnamespace)
 pg_ts_template_tmplname_index                                   | pg_ts_template                                                | UNIQUE (tmplname, tmplnamespace)
 pg_ts_template_oid_index                                        | pg_ts_template                                                | PRIMARY KEY (oid)
 pg_type_oid_index                                               | pg_type                                                       | PRIMARY KEY (oid)
 pg_type_typname_nsp_index                                       | pg_type                                                       | UNIQUE (typname, typnamespace)
 pg_user_mapping_oid_index                                       | pg_user_mapping                                               | PRIMARY KEY (oid)
 pg_user_mapping_user_server_index                               | pg_user_mapping                                               | UNIQUE (umuser, umserver)
 phone_blacklist_pkey                                            | phone_blacklist                                               | PRIMARY KEY (id)
 phone_blacklist_unique_number                                   | phone_blacklist                                               | UNIQUE (number)
 phone_blacklist_create_uid_fkey                                 | phone_blacklist                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 phone_blacklist_write_uid_fkey                                  | phone_blacklist                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 phone_blacklist_remove_pkey                                     | phone_blacklist_remove                                        | PRIMARY KEY (id)
 phone_blacklist_remove_create_uid_fkey                          | phone_blacklist_remove                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 phone_blacklist_remove_write_uid_fkey                           | phone_blacklist_remove                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 picking_label_type_pkey                                         | picking_label_type                                            | PRIMARY KEY (id)
 picking_label_type_create_uid_fkey                              | picking_label_type                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 picking_label_type_write_uid_fkey                               | picking_label_type                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 picking_label_type_stock_picking_rel_pkey                       | picking_label_type_stock_picking_rel                          | PRIMARY KEY (picking_label_type_id, stock_picking_id)
 picking_label_type_stock_picking_rel_picking_label_type_id_fkey | picking_label_type_stock_picking_rel                          | FOREIGN KEY (picking_label_type_id) REFERENCES picking_label_type(id) ON DELETE CASCADE
 picking_label_type_stock_picking_rel_stock_picking_id_fkey      | picking_label_type_stock_picking_rel                          | FOREIGN KEY (stock_picking_id) REFERENCES stock_picking(id) ON DELETE CASCADE
 picking_type_favorite_user_rel_user_id_fkey                     | picking_type_favorite_user_rel                                | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 picking_type_favorite_user_rel_picking_type_id_fkey             | picking_type_favorite_user_rel                                | FOREIGN KEY (picking_type_id) REFERENCES stock_picking_type(id) ON DELETE CASCADE
 picking_type_favorite_user_rel_pkey                             | picking_type_favorite_user_rel                                | PRIMARY KEY (picking_type_id, user_id)
 portal_share_create_uid_fkey                                    | portal_share                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 portal_share_pkey                                               | portal_share                                                  | PRIMARY KEY (id)
 portal_share_write_uid_fkey                                     | portal_share                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 portal_share_res_partner_rel_portal_share_id_fkey               | portal_share_res_partner_rel                                  | FOREIGN KEY (portal_share_id) REFERENCES portal_share(id) ON DELETE CASCADE
 portal_share_res_partner_rel_pkey                               | portal_share_res_partner_rel                                  | PRIMARY KEY (portal_share_id, res_partner_id)
 portal_share_res_partner_rel_res_partner_id_fkey                | portal_share_res_partner_rel                                  | FOREIGN KEY (res_partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 portal_wizard_pkey                                              | portal_wizard                                                 | PRIMARY KEY (id)
 portal_wizard_create_uid_fkey                                   | portal_wizard                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 portal_wizard_write_uid_fkey                                    | portal_wizard                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 portal_wizard_res_partner_rel_pkey                              | portal_wizard_res_partner_rel                                 | PRIMARY KEY (portal_wizard_id, res_partner_id)
 portal_wizard_res_partner_rel_portal_wizard_id_fkey             | portal_wizard_res_partner_rel                                 | FOREIGN KEY (portal_wizard_id) REFERENCES portal_wizard(id) ON DELETE CASCADE
 portal_wizard_res_partner_rel_res_partner_id_fkey               | portal_wizard_res_partner_rel                                 | FOREIGN KEY (res_partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 portal_wizard_user_wizard_id_fkey                               | portal_wizard_user                                            | FOREIGN KEY (wizard_id) REFERENCES portal_wizard(id) ON DELETE CASCADE
 portal_wizard_user_pkey                                         | portal_wizard_user                                            | PRIMARY KEY (id)
 portal_wizard_user_partner_id_fkey                              | portal_wizard_user                                            | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 portal_wizard_user_create_uid_fkey                              | portal_wizard_user                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 portal_wizard_user_write_uid_fkey                               | portal_wizard_user                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 premafirm_ai_correction_user_id_fkey                            | premafirm_ai_correction                                       | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE RESTRICT
 premafirm_ai_correction_create_uid_fkey                         | premafirm_ai_correction                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 premafirm_ai_correction_pkey                                    | premafirm_ai_correction                                       | PRIMARY KEY (id)
 premafirm_ai_correction_new_load_id_fkey                        | premafirm_ai_correction                                       | FOREIGN KEY (new_load_id) REFERENCES premafirm_load(id) ON DELETE SET NULL
 premafirm_ai_correction_lead_id_fkey                            | premafirm_ai_correction                                       | FOREIGN KEY (lead_id) REFERENCES crm_lead(id) ON DELETE CASCADE
 premafirm_ai_correction_old_load_id_fkey                        | premafirm_ai_correction                                       | FOREIGN KEY (old_load_id) REFERENCES premafirm_load(id) ON DELETE SET NULL
 premafirm_ai_correction_write_uid_fkey                          | premafirm_ai_correction                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 premafirm_ai_correction_stop_id_fkey                            | premafirm_ai_correction                                       | FOREIGN KEY (stop_id) REFERENCES premafirm_dispatch_stop(id) ON DELETE CASCADE
 premafirm_ai_log_lead_id_fkey                                   | premafirm_ai_log                                              | FOREIGN KEY (lead_id) REFERENCES crm_lead(id) ON DELETE CASCADE
 premafirm_ai_log_create_uid_fkey                                | premafirm_ai_log                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 premafirm_ai_log_write_uid_fkey                                 | premafirm_ai_log                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 premafirm_ai_log_pkey                                           | premafirm_ai_log                                              | PRIMARY KEY (id)
 premafirm_booking_create_uid_fkey                               | premafirm_booking                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 premafirm_booking_pkey                                          | premafirm_booking                                             | PRIMARY KEY (id)
 premafirm_booking_lead_id_fkey                                  | premafirm_booking                                             | FOREIGN KEY (lead_id) REFERENCES crm_lead(id) ON DELETE CASCADE
 premafirm_booking_vehicle_id_fkey                               | premafirm_booking                                             | FOREIGN KEY (vehicle_id) REFERENCES fleet_vehicle(id) ON DELETE RESTRICT
 premafirm_booking_driver_id_fkey                                | premafirm_booking                                             | FOREIGN KEY (driver_id) REFERENCES hr_employee(id) ON DELETE SET NULL
 premafirm_booking_write_uid_fkey                                | premafirm_booking                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 premafirm_dispatch_run_create_uid_fkey                          | premafirm_dispatch_run                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 premafirm_dispatch_run_vehicle_id_fkey                          | premafirm_dispatch_run                                        | FOREIGN KEY (vehicle_id) REFERENCES fleet_vehicle(id) ON DELETE RESTRICT
 premafirm_dispatch_run_pkey                                     | premafirm_dispatch_run                                        | PRIMARY KEY (id)
 premafirm_dispatch_run_calendar_event_id_fkey                   | premafirm_dispatch_run                                        | FOREIGN KEY (calendar_event_id) REFERENCES calendar_event(id) ON DELETE SET NULL
 premafirm_dispatch_run_currency_id_fkey                         | premafirm_dispatch_run                                        | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 premafirm_dispatch_run_write_uid_fkey                           | premafirm_dispatch_run                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 premafirm_dispatch_stop_premafirm_stop_unique_sequence          | premafirm_dispatch_stop                                       | UNIQUE (lead_id, sequence)
 premafirm_dispatch_stop_create_uid_fkey                         | premafirm_dispatch_stop                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 premafirm_dispatch_stop_lead_id_fkey                            | premafirm_dispatch_stop                                       | FOREIGN KEY (lead_id) REFERENCES crm_lead(id) ON DELETE CASCADE
 premafirm_dispatch_stop_pkey                                    | premafirm_dispatch_stop                                       | PRIMARY KEY (id)
 premafirm_dispatch_stop_product_id_fkey                         | premafirm_dispatch_stop                                       | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE SET NULL
 premafirm_dispatch_stop_freight_product_id_fkey                 | premafirm_dispatch_stop                                       | FOREIGN KEY (freight_product_id) REFERENCES product_product(id) ON DELETE SET NULL
 premafirm_dispatch_stop_run_id_fkey                             | premafirm_dispatch_stop                                       | FOREIGN KEY (run_id) REFERENCES premafirm_dispatch_run(id) ON DELETE SET NULL
 premafirm_dispatch_stop_sale_order_id_fkey                      | premafirm_dispatch_stop                                       | FOREIGN KEY (sale_order_id) REFERENCES sale_order(id) ON DELETE CASCADE
 premafirm_dispatch_stop_load_id_fkey                            | premafirm_dispatch_stop                                       | FOREIGN KEY (load_id) REFERENCES premafirm_load(id) ON DELETE SET NULL
 premafirm_dispatch_stop_write_uid_fkey                          | premafirm_dispatch_stop                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 premafirm_load_lead_id_fkey                                     | premafirm_load                                                | FOREIGN KEY (lead_id) REFERENCES crm_lead(id) ON DELETE CASCADE
 premafirm_load_write_uid_fkey                                   | premafirm_load                                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 premafirm_load_create_uid_fkey                                  | premafirm_load                                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 premafirm_load_currency_id_fkey                                 | premafirm_load                                                | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 premafirm_load_driver_id_fkey                                   | premafirm_load                                                | FOREIGN KEY (driver_id) REFERENCES res_partner(id) ON DELETE SET NULL
 premafirm_load_vehicle_id_fkey                                  | premafirm_load                                                | FOREIGN KEY (vehicle_id) REFERENCES fleet_vehicle(id) ON DELETE SET NULL
 premafirm_load_sale_order_id_fkey                               | premafirm_load                                                | FOREIGN KEY (sale_order_id) REFERENCES sale_order(id) ON DELETE CASCADE
 premafirm_load_pkey                                             | premafirm_load                                                | PRIMARY KEY (id)
 premafirm_load_company_id_fkey                                  | premafirm_load                                                | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 premafirm_mapbox_cache_create_uid_fkey                          | premafirm_mapbox_cache                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 premafirm_mapbox_cache_origin_destination_departure_idx         | premafirm_mapbox_cache                                        | UNIQUE (origin, destination, waypoint_hash, departure_hour)
 premafirm_mapbox_cache_pkey                                     | premafirm_mapbox_cache                                        | PRIMARY KEY (id)
 premafirm_mapbox_cache_write_uid_fkey                           | premafirm_mapbox_cache                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 premafirm_pricing_history_pkey                                  | premafirm_pricing_history                                     | PRIMARY KEY (id)
 premafirm_pricing_history_write_uid_fkey                        | premafirm_pricing_history                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 premafirm_pricing_history_create_uid_fkey                       | premafirm_pricing_history                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 premafirm_pricing_history_currency_id_fkey                      | premafirm_pricing_history                                     | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE RESTRICT
 premafirm_pricing_history_customer_id_fkey                      | premafirm_pricing_history                                     | FOREIGN KEY (customer_id) REFERENCES res_partner(id) ON DELETE SET NULL
 premafirm_pricing_history_lead_id_fkey                          | premafirm_pricing_history                                     | FOREIGN KEY (lead_id) REFERENCES crm_lead(id) ON DELETE CASCADE
 privacy_log_pkey                                                | privacy_log                                                   | PRIMARY KEY (id)
 privacy_log_user_id_fkey                                        | privacy_log                                                   | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE RESTRICT
 privacy_log_create_uid_fkey                                     | privacy_log                                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 privacy_log_write_uid_fkey                                      | privacy_log                                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 privacy_lookup_wizard_pkey                                      | privacy_lookup_wizard                                         | PRIMARY KEY (id)
 privacy_lookup_wizard_write_uid_fkey                            | privacy_lookup_wizard                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 privacy_lookup_wizard_create_uid_fkey                           | privacy_lookup_wizard                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 privacy_lookup_wizard_log_id_fkey                               | privacy_lookup_wizard                                         | FOREIGN KEY (log_id) REFERENCES privacy_log(id) ON DELETE SET NULL
 privacy_lookup_wizard_line_pkey                                 | privacy_lookup_wizard_line                                    | PRIMARY KEY (id)
 privacy_lookup_wizard_line_write_uid_fkey                       | privacy_lookup_wizard_line                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 privacy_lookup_wizard_line_create_uid_fkey                      | privacy_lookup_wizard_line                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 privacy_lookup_wizard_line_wizard_id_fkey                       | privacy_lookup_wizard_line                                    | FOREIGN KEY (wizard_id) REFERENCES privacy_lookup_wizard(id) ON DELETE SET NULL
 privacy_lookup_wizard_line_res_model_id_fkey                    | privacy_lookup_wizard_line                                    | FOREIGN KEY (res_model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 procurement_group_write_uid_fkey                                | procurement_group                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 procurement_group_pkey                                          | procurement_group                                             | PRIMARY KEY (id)
 procurement_group_partner_id_fkey                               | procurement_group                                             | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 procurement_group_create_uid_fkey                               | procurement_group                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 procurement_group_sale_id_fkey                                  | procurement_group                                             | FOREIGN KEY (sale_id) REFERENCES sale_order(id) ON DELETE SET NULL
 product_attr_exclusion_value__product_template_attribute_v_fkey | product_attr_exclusion_value_ids_rel                          | FOREIGN KEY (product_template_attribute_value_id) REFERENCES product_template_attribute_value(id) ON DELETE CASCADE
 product_attr_exclusion_value__product_template_attribute_e_fkey | product_attr_exclusion_value_ids_rel                          | FOREIGN KEY (product_template_attribute_exclusion_id) REFERENCES product_template_attribute_exclusion(id) ON DELETE CASCADE
 product_attr_exclusion_value_ids_rel_pkey                       | product_attr_exclusion_value_ids_rel                          | PRIMARY KEY (product_template_attribute_exclusion_id, product_template_attribute_value_id)
 product_attribute_check_multi_checkbox_no_variant               | product_attribute                                             | CHECK ((((display_type)::text <> 'multi'::text) OR ((create_variant)::text = 'no_variant'::text)))
 product_attribute_pkey                                          | product_attribute                                             | PRIMARY KEY (id)
 product_attribute_create_uid_fkey                               | product_attribute                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_attribute_write_uid_fkey                                | product_attribute                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_attribute_custom_value_create_uid_fkey                  | product_attribute_custom_value                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_attribute_custom_value_sol_custom_value_unique          | product_attribute_custom_value                                | UNIQUE (custom_product_template_attribute_value_id, sale_order_line_id)
 product_attribute_custom_value_pkey                             | product_attribute_custom_value                                | PRIMARY KEY (id)
 product_attribute_custom_valu_custom_product_template_attr_fkey | product_attribute_custom_value                                | FOREIGN KEY (custom_product_template_attribute_value_id) REFERENCES product_template_attribute_value(id) ON DELETE RESTRICT
 product_attribute_custom_value_write_uid_fkey                   | product_attribute_custom_value                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_attribute_custom_value_sale_order_line_id_fkey          | product_attribute_custom_value                                | FOREIGN KEY (sale_order_line_id) REFERENCES sale_order_line(id) ON DELETE CASCADE
 product_attribute_product_template_rel_pkey                     | product_attribute_product_template_rel                        | PRIMARY KEY (product_attribute_id, product_template_id)
 product_attribute_product_template_re_product_attribute_id_fkey | product_attribute_product_template_rel                        | FOREIGN KEY (product_attribute_id) REFERENCES product_attribute(id) ON DELETE CASCADE
 product_attribute_product_template_rel_product_template_id_fkey | product_attribute_product_template_rel                        | FOREIGN KEY (product_template_id) REFERENCES product_template(id) ON DELETE CASCADE
 product_attribute_value_attribute_id_fkey                       | product_attribute_value                                       | FOREIGN KEY (attribute_id) REFERENCES product_attribute(id) ON DELETE CASCADE
 product_attribute_value_pkey                                    | product_attribute_value                                       | PRIMARY KEY (id)
 product_attribute_value_create_uid_fkey                         | product_attribute_value                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_attribute_value_write_uid_fkey                          | product_attribute_value                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_attribute_value_product_template_attribute_line_re_pkey | product_attribute_value_product_template_attribute_line_rel   | PRIMARY KEY (product_attribute_value_id, product_template_attribute_line_id)
 product_attribute_value_product_product_attribute_value_id_fkey | product_attribute_value_product_template_attribute_line_rel   | FOREIGN KEY (product_attribute_value_id) REFERENCES product_attribute_value(id) ON DELETE RESTRICT
 product_attribute_value_produ_product_template_attribute_l_fkey | product_attribute_value_product_template_attribute_line_rel   | FOREIGN KEY (product_template_attribute_line_id) REFERENCES product_template_attribute_line(id) ON DELETE CASCADE
 product_avatax_category_pkey                                    | product_avatax_category                                       | PRIMARY KEY (id)
 product_avatax_category_create_uid_fkey                         | product_avatax_category                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_avatax_category_write_uid_fkey                          | product_avatax_category                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_category_create_uid_fkey                                | product_category                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_category_pkey                                           | product_category                                              | PRIMARY KEY (id)
 product_category_parent_id_fkey                                 | product_category                                              | FOREIGN KEY (parent_id) REFERENCES product_category(id) ON DELETE CASCADE
 product_category_write_uid_fkey                                 | product_category                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_category_avatax_category_id_fkey                        | product_category                                              | FOREIGN KEY (avatax_category_id) REFERENCES product_avatax_category(id) ON DELETE SET NULL
 product_category_removal_strategy_id_fkey                       | product_category                                              | FOREIGN KEY (removal_strategy_id) REFERENCES product_removal(id) ON DELETE SET NULL
 product_category_quality_point_rel_pkey                         | product_category_quality_point_rel                            | PRIMARY KEY (quality_point_id, product_category_id)
 product_category_quality_point_rel_product_category_id_fkey     | product_category_quality_point_rel                            | FOREIGN KEY (product_category_id) REFERENCES product_category(id) ON DELETE CASCADE
 product_category_quality_point_rel_quality_point_id_fkey        | product_category_quality_point_rel                            | FOREIGN KEY (quality_point_id) REFERENCES quality_point(id) ON DELETE CASCADE
 product_category_stock_picking_type_rel_pkey                    | product_category_stock_picking_type_rel                       | PRIMARY KEY (stock_picking_type_id, product_category_id)
 product_category_stock_picking_type__stock_picking_type_id_fkey | product_category_stock_picking_type_rel                       | FOREIGN KEY (stock_picking_type_id) REFERENCES stock_picking_type(id) ON DELETE CASCADE
 product_category_stock_picking_type_re_product_category_id_fkey | product_category_stock_picking_type_rel                       | FOREIGN KEY (product_category_id) REFERENCES product_category(id) ON DELETE CASCADE
 product_combo_create_uid_fkey                                   | product_combo                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_combo_company_id_fkey                                   | product_combo                                                 | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 product_combo_write_uid_fkey                                    | product_combo                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_combo_pkey                                              | product_combo                                                 | PRIMARY KEY (id)
 product_combo_item_create_uid_fkey                              | product_combo_item                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_combo_item_write_uid_fkey                               | product_combo_item                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_combo_item_company_id_fkey                              | product_combo_item                                            | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 product_combo_item_pkey                                         | product_combo_item                                            | PRIMARY KEY (id)
 product_combo_item_combo_id_fkey                                | product_combo_item                                            | FOREIGN KEY (combo_id) REFERENCES product_combo(id) ON DELETE CASCADE
 product_combo_item_product_id_fkey                              | product_combo_item                                            | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE RESTRICT
 product_combo_product_template_rel_product_template_id_fkey     | product_combo_product_template_rel                            | FOREIGN KEY (product_template_id) REFERENCES product_template(id) ON DELETE CASCADE
 product_combo_product_template_rel_pkey                         | product_combo_product_template_rel                            | PRIMARY KEY (product_template_id, product_combo_id)
 product_combo_product_template_rel_product_combo_id_fkey        | product_combo_product_template_rel                            | FOREIGN KEY (product_combo_id) REFERENCES product_combo(id) ON DELETE CASCADE
 product_document_write_uid_fkey                                 | product_document                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_document_ir_attachment_id_fkey                          | product_document                                              | FOREIGN KEY (ir_attachment_id) REFERENCES ir_attachment(id) ON DELETE CASCADE
 product_document_create_uid_fkey                                | product_document                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_document_origin_attachment_id_fkey                      | product_document                                              | FOREIGN KEY (origin_attachment_id) REFERENCES ir_attachment(id) ON DELETE SET NULL
 product_document_pkey                                           | product_document                                              | PRIMARY KEY (id)
 product_document_sale_pdf_form_fiel_sale_pdf_form_field_id_fkey | product_document_sale_pdf_form_field_rel                      | FOREIGN KEY (sale_pdf_form_field_id) REFERENCES sale_pdf_form_field(id) ON DELETE CASCADE
 product_document_sale_pdf_form_field_rel_pkey                   | product_document_sale_pdf_form_field_rel                      | PRIMARY KEY (product_document_id, sale_pdf_form_field_id)
 product_document_sale_pdf_form_field_r_product_document_id_fkey | product_document_sale_pdf_form_field_rel                      | FOREIGN KEY (product_document_id) REFERENCES product_document(id) ON DELETE CASCADE
 product_label_layout_pricelist_id_fkey                          | product_label_layout                                          | FOREIGN KEY (pricelist_id) REFERENCES product_pricelist(id) ON DELETE SET NULL
 product_label_layout_pkey                                       | product_label_layout                                          | PRIMARY KEY (id)
 product_label_layout_create_uid_fkey                            | product_label_layout                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_label_layout_write_uid_fkey                             | product_label_layout                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_label_layout_product_product_re_product_product_id_fkey | product_label_layout_product_product_rel                      | FOREIGN KEY (product_product_id) REFERENCES product_product(id) ON DELETE CASCADE
 product_label_layout_product_produ_product_label_layout_id_fkey | product_label_layout_product_product_rel                      | FOREIGN KEY (product_label_layout_id) REFERENCES product_label_layout(id) ON DELETE CASCADE
 product_label_layout_product_product_rel_pkey                   | product_label_layout_product_product_rel                      | PRIMARY KEY (product_label_layout_id, product_product_id)
 product_label_layout_product_template__product_template_id_fkey | product_label_layout_product_template_rel                     | FOREIGN KEY (product_template_id) REFERENCES product_template(id) ON DELETE CASCADE
 product_label_layout_product_templ_product_label_layout_id_fkey | product_label_layout_product_template_rel                     | FOREIGN KEY (product_label_layout_id) REFERENCES product_label_layout(id) ON DELETE CASCADE
 product_label_layout_product_template_rel_pkey                  | product_label_layout_product_template_rel                     | PRIMARY KEY (product_label_layout_id, product_template_id)
 product_label_layout_stock_move_re_product_label_layout_id_fkey | product_label_layout_stock_move_rel                           | FOREIGN KEY (product_label_layout_id) REFERENCES product_label_layout(id) ON DELETE CASCADE
 product_label_layout_stock_move_rel_pkey                        | product_label_layout_stock_move_rel                           | PRIMARY KEY (product_label_layout_id, stock_move_id)
 product_label_layout_stock_move_rel_stock_move_id_fkey          | product_label_layout_stock_move_rel                           | FOREIGN KEY (stock_move_id) REFERENCES stock_move(id) ON DELETE CASCADE
 product_optional_rel_dest_id_fkey                               | product_optional_rel                                          | FOREIGN KEY (dest_id) REFERENCES product_template(id) ON DELETE CASCADE
 product_optional_rel_pkey                                       | product_optional_rel                                          | PRIMARY KEY (src_id, dest_id)
 product_optional_rel_src_id_fkey                                | product_optional_rel                                          | FOREIGN KEY (src_id) REFERENCES product_template(id) ON DELETE CASCADE
 product_packaging_positive_qty                                  | product_packaging                                             | CHECK ((qty > (0)::numeric))
 product_packaging_company_id_fkey                               | product_packaging                                             | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 product_packaging_product_id_fkey                               | product_packaging                                             | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE CASCADE
 product_packaging_barcode_uniq                                  | product_packaging                                             | UNIQUE (barcode)
 product_packaging_pkey                                          | product_packaging                                             | PRIMARY KEY (id)
 product_packaging_package_type_id_fkey                          | product_packaging                                             | FOREIGN KEY (package_type_id) REFERENCES stock_package_type(id) ON DELETE SET NULL
 product_packaging_write_uid_fkey                                | product_packaging                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_packaging_create_uid_fkey                               | product_packaging                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_pricelist_write_uid_fkey                                | product_pricelist                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_pricelist_pkey                                          | product_pricelist                                             | PRIMARY KEY (id)
 product_pricelist_create_uid_fkey                               | product_pricelist                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_pricelist_company_id_fkey                               | product_pricelist                                             | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 product_pricelist_currency_id_fkey                              | product_pricelist                                             | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE RESTRICT
 product_pricelist_item_product_tmpl_id_fkey                     | product_pricelist_item                                        | FOREIGN KEY (product_tmpl_id) REFERENCES product_template(id) ON DELETE CASCADE
 product_pricelist_item_categ_id_fkey                            | product_pricelist_item                                        | FOREIGN KEY (categ_id) REFERENCES product_category(id) ON DELETE CASCADE
 product_pricelist_item_currency_id_fkey                         | product_pricelist_item                                        | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 product_pricelist_item_pkey                                     | product_pricelist_item                                        | PRIMARY KEY (id)
 product_pricelist_item_pricelist_id_fkey                        | product_pricelist_item                                        | FOREIGN KEY (pricelist_id) REFERENCES product_pricelist(id) ON DELETE CASCADE
 product_pricelist_item_company_id_fkey                          | product_pricelist_item                                        | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 product_pricelist_item_write_uid_fkey                           | product_pricelist_item                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_pricelist_item_create_uid_fkey                          | product_pricelist_item                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_pricelist_item_base_pricelist_id_fkey                   | product_pricelist_item                                        | FOREIGN KEY (base_pricelist_id) REFERENCES product_pricelist(id) ON DELETE SET NULL
 product_pricelist_item_product_id_fkey                          | product_pricelist_item                                        | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE CASCADE
 product_product_create_uid_fkey                                 | product_product                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_product_write_uid_fkey                                  | product_product                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_product_pkey                                            | product_product                                               | PRIMARY KEY (id)
 product_product_product_tmpl_id_fkey                            | product_product                                               | FOREIGN KEY (product_tmpl_id) REFERENCES product_template(id) ON DELETE CASCADE
 product_product_avatax_category_id_fkey                         | product_product                                               | FOREIGN KEY (avatax_category_id) REFERENCES product_avatax_category(id) ON DELETE SET NULL
 product_product_quality_point_rel_product_product_id_fkey       | product_product_quality_point_rel                             | FOREIGN KEY (product_product_id) REFERENCES product_product(id) ON DELETE CASCADE
 product_product_quality_point_rel_quality_point_id_fkey         | product_product_quality_point_rel                             | FOREIGN KEY (quality_point_id) REFERENCES quality_point(id) ON DELETE CASCADE
 product_product_quality_point_rel_pkey                          | product_product_quality_point_rel                             | PRIMARY KEY (quality_point_id, product_product_id)
 product_product_stock_track_confirmation_rel_pkey               | product_product_stock_track_confirmation_rel                  | PRIMARY KEY (stock_track_confirmation_id, product_product_id)
 product_product_stock_track_confirmatio_product_product_id_fkey | product_product_stock_track_confirmation_rel                  | FOREIGN KEY (product_product_id) REFERENCES product_product(id) ON DELETE CASCADE
 product_product_stock_track_co_stock_track_confirmation_id_fkey | product_product_stock_track_confirmation_rel                  | FOREIGN KEY (stock_track_confirmation_id) REFERENCES stock_track_confirmation(id) ON DELETE CASCADE
 product_removal_write_uid_fkey                                  | product_removal                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_removal_create_uid_fkey                                 | product_removal                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_removal_pkey                                            | product_removal                                               | PRIMARY KEY (id)
 product_replenish_create_uid_fkey                               | product_replenish                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_replenish_company_id_fkey                               | product_replenish                                             | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 product_replenish_write_uid_fkey                                | product_replenish                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_replenish_warehouse_id_fkey                             | product_replenish                                             | FOREIGN KEY (warehouse_id) REFERENCES stock_warehouse(id) ON DELETE CASCADE
 product_replenish_product_uom_id_fkey                           | product_replenish                                             | FOREIGN KEY (product_uom_id) REFERENCES uom_uom(id) ON DELETE CASCADE
 product_replenish_bom_id_fkey                                   | product_replenish                                             | FOREIGN KEY (bom_id) REFERENCES mrp_bom(id) ON DELETE SET NULL
 product_replenish_pkey                                          | product_replenish                                             | PRIMARY KEY (id)
 product_replenish_product_tmpl_id_fkey                          | product_replenish                                             | FOREIGN KEY (product_tmpl_id) REFERENCES product_template(id) ON DELETE CASCADE
 product_replenish_product_id_fkey                               | product_replenish                                             | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE CASCADE
 product_replenish_route_id_fkey                                 | product_replenish                                             | FOREIGN KEY (route_id) REFERENCES stock_route(id) ON DELETE SET NULL
 product_replenish_supplier_id_fkey                              | product_replenish                                             | FOREIGN KEY (supplier_id) REFERENCES product_supplierinfo(id) ON DELETE SET NULL
 product_supplier_taxes_rel_tax_id_fkey                          | product_supplier_taxes_rel                                    | FOREIGN KEY (tax_id) REFERENCES account_tax(id) ON DELETE CASCADE
 product_supplier_taxes_rel_pkey                                 | product_supplier_taxes_rel                                    | PRIMARY KEY (prod_id, tax_id)
 product_supplier_taxes_rel_prod_id_fkey                         | product_supplier_taxes_rel                                    | FOREIGN KEY (prod_id) REFERENCES product_template(id) ON DELETE CASCADE
 product_supplierinfo_create_uid_fkey                            | product_supplierinfo                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_supplierinfo_write_uid_fkey                             | product_supplierinfo                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_supplierinfo_partner_id_fkey                            | product_supplierinfo                                          | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 product_supplierinfo_company_id_fkey                            | product_supplierinfo                                          | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 product_supplierinfo_currency_id_fkey                           | product_supplierinfo                                          | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE RESTRICT
 product_supplierinfo_product_id_fkey                            | product_supplierinfo                                          | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE SET NULL
 product_supplierinfo_pkey                                       | product_supplierinfo                                          | PRIMARY KEY (id)
 product_supplierinfo_product_tmpl_id_fkey                       | product_supplierinfo                                          | FOREIGN KEY (product_tmpl_id) REFERENCES product_template(id) ON DELETE CASCADE
 product_supplierinfo_stock_rep_stock_replenishment_info_id_fkey | product_supplierinfo_stock_replenishment_info_rel             | FOREIGN KEY (stock_replenishment_info_id) REFERENCES stock_replenishment_info(id) ON DELETE CASCADE
 product_supplierinfo_stock_replenishment_info_rel_pkey          | product_supplierinfo_stock_replenishment_info_rel             | PRIMARY KEY (stock_replenishment_info_id, product_supplierinfo_id)
 product_supplierinfo_stock_repleni_product_supplierinfo_id_fkey | product_supplierinfo_stock_replenishment_info_rel             | FOREIGN KEY (product_supplierinfo_id) REFERENCES product_supplierinfo(id) ON DELETE CASCADE
 product_tag_name_uniq                                           | product_tag                                                   | UNIQUE (name)
 product_tag_create_uid_fkey                                     | product_tag                                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_tag_pkey                                                | product_tag                                                   | PRIMARY KEY (id)
 product_tag_write_uid_fkey                                      | product_tag                                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_tag_product_product_rel_product_tag_id_fkey             | product_tag_product_product_rel                               | FOREIGN KEY (product_tag_id) REFERENCES product_tag(id) ON DELETE CASCADE
 product_tag_product_product_rel_pkey                            | product_tag_product_product_rel                               | PRIMARY KEY (product_product_id, product_tag_id)
 product_tag_product_product_rel_product_product_id_fkey         | product_tag_product_product_rel                               | FOREIGN KEY (product_product_id) REFERENCES product_product(id) ON DELETE CASCADE
 product_tag_product_template_rel_product_template_id_fkey       | product_tag_product_template_rel                              | FOREIGN KEY (product_template_id) REFERENCES product_template(id) ON DELETE CASCADE
 product_tag_product_template_rel_product_tag_id_fkey            | product_tag_product_template_rel                              | FOREIGN KEY (product_tag_id) REFERENCES product_tag(id) ON DELETE CASCADE
 product_tag_product_template_rel_pkey                           | product_tag_product_template_rel                              | PRIMARY KEY (product_template_id, product_tag_id)
 product_tags_table_res_company_id_fkey                          | product_tags_table                                            | FOREIGN KEY (res_company_id) REFERENCES res_company(id) ON DELETE CASCADE
 product_tags_table_documents_tag_id_fkey                        | product_tags_table                                            | FOREIGN KEY (documents_tag_id) REFERENCES documents_tag(id) ON DELETE CASCADE
 product_tags_table_pkey                                         | product_tags_table                                            | PRIMARY KEY (res_company_id, documents_tag_id)
 product_taxes_rel_pkey                                          | product_taxes_rel                                             | PRIMARY KEY (prod_id, tax_id)
 product_taxes_rel_prod_id_fkey                                  | product_taxes_rel                                             | FOREIGN KEY (prod_id) REFERENCES product_template(id) ON DELETE CASCADE
 product_taxes_rel_tax_id_fkey                                   | product_taxes_rel                                             | FOREIGN KEY (tax_id) REFERENCES account_tax(id) ON DELETE CASCADE
 product_template_categ_id_fkey                                  | product_template                                              | FOREIGN KEY (categ_id) REFERENCES product_category(id) ON DELETE RESTRICT
 product_template_pkey                                           | product_template                                              | PRIMARY KEY (id)
 product_template_write_uid_fkey                                 | product_template                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_template_create_uid_fkey                                | product_template                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_template_company_id_fkey                                | product_template                                              | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 product_template_uom_po_id_fkey                                 | product_template                                              | FOREIGN KEY (uom_po_id) REFERENCES uom_uom(id) ON DELETE RESTRICT
 product_template_uom_id_fkey                                    | product_template                                              | FOREIGN KEY (uom_id) REFERENCES uom_uom(id) ON DELETE RESTRICT
 product_template_avatax_category_id_fkey                        | product_template                                              | FOREIGN KEY (avatax_category_id) REFERENCES product_avatax_category(id) ON DELETE SET NULL
 product_template_attribute_exclusion_create_uid_fkey            | product_template_attribute_exclusion                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_template_attribute_ex_product_template_attribute_v_fkey | product_template_attribute_exclusion                          | FOREIGN KEY (product_template_attribute_value_id) REFERENCES product_template_attribute_value(id) ON DELETE CASCADE
 product_template_attribute_exclusion_pkey                       | product_template_attribute_exclusion                          | PRIMARY KEY (id)
 product_template_attribute_exclusion_write_uid_fkey             | product_template_attribute_exclusion                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_template_attribute_exclusion_product_tmpl_id_fkey       | product_template_attribute_exclusion                          | FOREIGN KEY (product_tmpl_id) REFERENCES product_template(id) ON DELETE CASCADE
 product_template_attribute_line_pkey                            | product_template_attribute_line                               | PRIMARY KEY (id)
 product_template_attribute_line_create_uid_fkey                 | product_template_attribute_line                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_template_attribute_line_write_uid_fkey                  | product_template_attribute_line                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_template_attribute_line_product_tmpl_id_fkey            | product_template_attribute_line                               | FOREIGN KEY (product_tmpl_id) REFERENCES product_template(id) ON DELETE CASCADE
 product_template_attribute_line_attribute_id_fkey               | product_template_attribute_line                               | FOREIGN KEY (attribute_id) REFERENCES product_attribute(id) ON DELETE RESTRICT
 product_template_attribute_valu_product_attribute_value_id_fkey | product_template_attribute_value                              | FOREIGN KEY (product_attribute_value_id) REFERENCES product_attribute_value(id) ON DELETE CASCADE
 product_template_attribute_value_create_uid_fkey                | product_template_attribute_value                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_template_attribute_value_attribute_id_fkey              | product_template_attribute_value                              | FOREIGN KEY (attribute_id) REFERENCES product_attribute(id) ON DELETE SET NULL
 product_template_attribute_value_product_tmpl_id_fkey           | product_template_attribute_value                              | FOREIGN KEY (product_tmpl_id) REFERENCES product_template(id) ON DELETE SET NULL
 product_template_attribute_value_attribute_line_id_fkey         | product_template_attribute_value                              | FOREIGN KEY (attribute_line_id) REFERENCES product_template_attribute_line(id) ON DELETE CASCADE
 product_template_attribute_value_write_uid_fkey                 | product_template_attribute_value                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 product_template_attribute_value_pkey                           | product_template_attribute_value                              | PRIMARY KEY (id)
 product_template_attribute_value_attribute_value_unique         | product_template_attribute_value                              | UNIQUE (attribute_line_id, product_attribute_value_id)
 product_template_attribute_value_pu_purchase_order_line_id_fkey | product_template_attribute_value_purchase_order_line_rel      | FOREIGN KEY (purchase_order_line_id) REFERENCES purchase_order_line(id) ON DELETE CASCADE
 product_template_attribute_va_product_template_attribute_v_fkey | product_template_attribute_value_purchase_order_line_rel      | FOREIGN KEY (product_template_attribute_value_id) REFERENCES product_template_attribute_value(id) ON DELETE RESTRICT
 product_template_attribute_value_purchase_order_line_rel_pkey   | product_template_attribute_value_purchase_order_line_rel      | PRIMARY KEY (purchase_order_line_id, product_template_attribute_value_id)
 product_template_attribute_value_sale_order_line_rel_pkey       | product_template_attribute_value_sale_order_line_rel          | PRIMARY KEY (sale_order_line_id, product_template_attribute_value_id)
 product_template_attribute_v_product_template_attribute_v_fkey1 | product_template_attribute_value_sale_order_line_rel          | FOREIGN KEY (product_template_attribute_value_id) REFERENCES product_template_attribute_value(id) ON DELETE RESTRICT
 product_template_attribute_value_sale_o_sale_order_line_id_fkey | product_template_attribute_value_sale_order_line_rel          | FOREIGN KEY (sale_order_line_id) REFERENCES sale_order_line(id) ON DELETE CASCADE
 product_variant_combination_pkey                                | product_variant_combination                                   | PRIMARY KEY (product_product_id, product_template_attribute_value_id)
 product_variant_combination_product_template_attribute_val_fkey | product_variant_combination                                   | FOREIGN KEY (product_template_attribute_value_id) REFERENCES product_template_attribute_value(id) ON DELETE RESTRICT
 product_variant_combination_product_product_id_fkey             | product_variant_combination                                   | FOREIGN KEY (product_product_id) REFERENCES product_product(id) ON DELETE CASCADE
 project_collaborator_unique_collaborator                        | project_collaborator                                          | UNIQUE (project_id, partner_id)
 project_collaborator_create_uid_fkey                            | project_collaborator                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_collaborator_partner_id_fkey                            | project_collaborator                                          | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE RESTRICT
 project_collaborator_project_id_fkey                            | project_collaborator                                          | FOREIGN KEY (project_id) REFERENCES project_project(id) ON DELETE RESTRICT
 project_collaborator_pkey                                       | project_collaborator                                          | PRIMARY KEY (id)
 project_collaborator_write_uid_fkey                             | project_collaborator                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_create_invoice_write_uid_fkey                           | project_create_invoice                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_create_invoice_pkey                                     | project_create_invoice                                        | PRIMARY KEY (id)
 project_create_invoice_project_id_fkey                          | project_create_invoice                                        | FOREIGN KEY (project_id) REFERENCES project_project(id) ON DELETE CASCADE
 project_create_invoice_sale_order_id_fkey                       | project_create_invoice                                        | FOREIGN KEY (sale_order_id) REFERENCES sale_order(id) ON DELETE CASCADE
 project_create_invoice_create_uid_fkey                          | project_create_invoice                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_documents_tag_rel_documents_tag_id_fkey                 | project_documents_tag_rel                                     | FOREIGN KEY (documents_tag_id) REFERENCES documents_tag(id) ON DELETE CASCADE
 project_documents_tag_rel_pkey                                  | project_documents_tag_rel                                     | PRIMARY KEY (project_project_id, documents_tag_id)
 project_documents_tag_rel_project_project_id_fkey               | project_documents_tag_rel                                     | FOREIGN KEY (project_project_id) REFERENCES project_project(id) ON DELETE CASCADE
 project_favorite_user_rel_project_id_fkey                       | project_favorite_user_rel                                     | FOREIGN KEY (project_id) REFERENCES project_project(id) ON DELETE CASCADE
 project_favorite_user_rel_user_id_fkey                          | project_favorite_user_rel                                     | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 project_favorite_user_rel_pkey                                  | project_favorite_user_rel                                     | PRIMARY KEY (project_id, user_id)
 project_milestone_write_uid_fkey                                | project_milestone                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_milestone_pkey                                          | project_milestone                                             | PRIMARY KEY (id)
 project_milestone_sale_line_id_fkey                             | project_milestone                                             | FOREIGN KEY (sale_line_id) REFERENCES sale_order_line(id) ON DELETE SET NULL
 project_milestone_project_id_fkey                               | project_milestone                                             | FOREIGN KEY (project_id) REFERENCES project_project(id) ON DELETE CASCADE
 project_milestone_create_uid_fkey                               | project_milestone                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_project_create_uid_fkey                                 | project_project                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_project_last_update_id_fkey                             | project_project                                               | FOREIGN KEY (last_update_id) REFERENCES project_update(id) ON DELETE SET NULL
 project_project_stage_id_fkey                                   | project_project                                               | FOREIGN KEY (stage_id) REFERENCES project_project_stage(id) ON DELETE RESTRICT
 project_project_user_id_fkey                                    | project_project                                               | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 project_project_project_date_greater                            | project_project                                               | CHECK ((date >= date_start))
 project_project_timesheet_product_id_fkey                       | project_project                                               | FOREIGN KEY (timesheet_product_id) REFERENCES product_product(id) ON DELETE SET NULL
 project_project_alias_id_fkey                                   | project_project                                               | FOREIGN KEY (alias_id) REFERENCES mail_alias(id) ON DELETE RESTRICT
 project_project_partner_id_fkey                                 | project_project                                               | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 project_project_company_id_fkey                                 | project_project                                               | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 project_project_x_plan2_id_fkey                                 | project_project                                               | FOREIGN KEY (x_plan2_id) REFERENCES account_analytic_account(id) ON DELETE RESTRICT
 project_project_documents_folder_id_fkey                        | project_project                                               | FOREIGN KEY (documents_folder_id) REFERENCES documents_document(id) ON DELETE SET NULL
 project_project_write_uid_fkey                                  | project_project                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_project_account_id_fkey                                 | project_project                                               | FOREIGN KEY (account_id) REFERENCES account_analytic_account(id) ON DELETE SET NULL
 project_project_x_plan4_id_fkey                                 | project_project                                               | FOREIGN KEY (x_plan4_id) REFERENCES account_analytic_account(id) ON DELETE RESTRICT
 project_project_pkey                                            | project_project                                               | PRIMARY KEY (id)
 project_project_sale_line_id_fkey                               | project_project                                               | FOREIGN KEY (sale_line_id) REFERENCES sale_order_line(id) ON DELETE SET NULL
 project_project_reinvoiced_sale_order_id_fkey                   | project_project                                               | FOREIGN KEY (reinvoiced_sale_order_id) REFERENCES sale_order(id) ON DELETE SET NULL
 project_project_project_tags_rel_pkey                           | project_project_project_tags_rel                              | PRIMARY KEY (project_project_id, project_tags_id)
 project_project_project_tags_rel_project_tags_id_fkey           | project_project_project_tags_rel                              | FOREIGN KEY (project_tags_id) REFERENCES project_tags(id) ON DELETE CASCADE
 project_project_project_tags_rel_project_project_id_fkey        | project_project_project_tags_rel                              | FOREIGN KEY (project_project_id) REFERENCES project_project(id) ON DELETE CASCADE
 project_project_project_task__project_task_type_delete_wiz_fkey | project_project_project_task_type_delete_wizard_rel           | FOREIGN KEY (project_task_type_delete_wizard_id) REFERENCES project_task_type_delete_wizard(id) ON DELETE CASCADE
 project_project_project_task_type_delet_project_project_id_fkey | project_project_project_task_type_delete_wizard_rel           | FOREIGN KEY (project_project_id) REFERENCES project_project(id) ON DELETE CASCADE
 project_project_project_task_type_delete_wizard_rel_pkey        | project_project_project_task_type_delete_wizard_rel           | PRIMARY KEY (project_task_type_delete_wizard_id, project_project_id)
 project_project_stage_company_id_fkey                           | project_project_stage                                         | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 project_project_stage_pkey                                      | project_project_stage                                         | PRIMARY KEY (id)
 project_project_stage_mail_template_id_fkey                     | project_project_stage                                         | FOREIGN KEY (mail_template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 project_project_stage_create_uid_fkey                           | project_project_stage                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_project_stage_write_uid_fkey                            | project_project_stage                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_project_stage_sms_template_id_fkey                      | project_project_stage                                         | FOREIGN KEY (sms_template_id) REFERENCES sms_template(id) ON DELETE SET NULL
 project_project_stage_delete_wizard_create_uid_fkey             | project_project_stage_delete_wizard                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_project_stage_delete_wizard_write_uid_fkey              | project_project_stage_delete_wizard                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_project_stage_delete_wizard_pkey                        | project_project_stage_delete_wizard                           | PRIMARY KEY (id)
 project_project_stage_project_project_project_stage_delete_fkey | project_project_stage_project_project_stage_delete_wizard_rel | FOREIGN KEY (project_project_stage_delete_wizard_id) REFERENCES project_project_stage_delete_wizard(id) ON DELETE CASCADE
 project_project_stage_project_pro_project_project_stage_id_fkey | project_project_stage_project_project_stage_delete_wizard_rel | FOREIGN KEY (project_project_stage_id) REFERENCES project_project_stage(id) ON DELETE CASCADE
 project_project_stage_project_project_stage_delete_wizard__pkey | project_project_stage_project_project_stage_delete_wizard_rel | PRIMARY KEY (project_project_stage_delete_wizard_id, project_project_stage_id)
 project_sale_line_employee_map_project_id_fkey                  | project_sale_line_employee_map                                | FOREIGN KEY (project_id) REFERENCES project_project(id) ON DELETE RESTRICT
 project_sale_line_employee_map_pkey                             | project_sale_line_employee_map                                | PRIMARY KEY (id)
 project_sale_line_employee_map_uniqueness_employee              | project_sale_line_employee_map                                | UNIQUE (project_id, employee_id)
 project_sale_line_employee_map_employee_id_fkey                 | project_sale_line_employee_map                                | FOREIGN KEY (employee_id) REFERENCES hr_employee(id) ON DELETE RESTRICT
 project_sale_line_employee_map_sale_line_id_fkey                | project_sale_line_employee_map                                | FOREIGN KEY (sale_line_id) REFERENCES sale_order_line(id) ON DELETE SET NULL
 project_sale_line_employee_map_currency_id_fkey                 | project_sale_line_employee_map                                | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 project_sale_line_employee_map_create_uid_fkey                  | project_sale_line_employee_map                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_sale_line_employee_map_write_uid_fkey                   | project_sale_line_employee_map                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_share_collaborator_wizard_pkey                          | project_share_collaborator_wizard                             | PRIMARY KEY (id)
 project_share_collaborator_wizard_parent_wizard_id_fkey         | project_share_collaborator_wizard                             | FOREIGN KEY (parent_wizard_id) REFERENCES project_share_wizard(id) ON DELETE SET NULL
 project_share_collaborator_wizard_create_uid_fkey               | project_share_collaborator_wizard                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_share_collaborator_wizard_partner_id_fkey               | project_share_collaborator_wizard                             | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 project_share_collaborator_wizard_write_uid_fkey                | project_share_collaborator_wizard                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_share_wizard_pkey                                       | project_share_wizard                                          | PRIMARY KEY (id)
 project_share_wizard_create_uid_fkey                            | project_share_wizard                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_share_wizard_write_uid_fkey                             | project_share_wizard                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_share_wizard_res_partner_rel_pkey                       | project_share_wizard_res_partner_rel                          | PRIMARY KEY (project_share_wizard_id, res_partner_id)
 project_share_wizard_res_partner_rel_res_partner_id_fkey        | project_share_wizard_res_partner_rel                          | FOREIGN KEY (res_partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 project_share_wizard_res_partner_r_project_share_wizard_id_fkey | project_share_wizard_res_partner_rel                          | FOREIGN KEY (project_share_wizard_id) REFERENCES project_share_wizard(id) ON DELETE CASCADE
 project_tags_pkey                                               | project_tags                                                  | PRIMARY KEY (id)
 project_tags_name_uniq                                          | project_tags                                                  | UNIQUE (name)
 project_tags_create_uid_fkey                                    | project_tags                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_tags_write_uid_fkey                                     | project_tags                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_tags_project_task_rel_project_task_id_fkey              | project_tags_project_task_rel                                 | FOREIGN KEY (project_task_id) REFERENCES project_task(id) ON DELETE CASCADE
 project_tags_project_task_rel_project_tags_id_fkey              | project_tags_project_task_rel                                 | FOREIGN KEY (project_tags_id) REFERENCES project_tags(id) ON DELETE CASCADE
 project_tags_project_task_rel_pkey                              | project_tags_project_task_rel                                 | PRIMARY KEY (project_task_id, project_tags_id)
 project_task_x_studio_many2one_field_5r5_1jf79j1gg_fkey         | project_task                                                  | FOREIGN KEY (x_studio_pickup_location) REFERENCES res_partner(id) ON DELETE SET NULL
 project_task_x_studio_many2one_field_19b_1jf52o32v_fkey         | project_task                                                  | FOREIGN KEY (x_studio_trip) REFERENCES project_task(id) ON DELETE SET NULL
 project_task_project_id_fkey                                    | project_task                                                  | FOREIGN KEY (project_id) REFERENCES project_project(id) ON DELETE SET NULL
 project_task_x_studio_currency_id_fkey                          | project_task                                                  | FOREIGN KEY (x_studio_currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 project_task_x_studio_many2one_field_8lo_1jf51jbb7_fkey         | project_task                                                  | FOREIGN KEY (x_studio_driver) REFERENCES res_partner(id) ON DELETE SET NULL
 project_task_x_studio_many2one_field_3dc_1jf519hq7_fkey         | project_task                                                  | FOREIGN KEY (x_studio_vehicle) REFERENCES fleet_vehicle(id) ON DELETE SET NULL
 project_task_partner_id_fkey                                    | project_task                                                  | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 project_task_company_id_fkey                                    | project_task                                                  | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 project_task_x_studio_many2one_field_8hb_1jf79kjs8_fkey         | project_task                                                  | FOREIGN KEY (x_studio_delivery_location) REFERENCES res_partner(id) ON DELETE SET NULL
 project_task_x_studio_many2one_field_4jq_1jf7cm2o1_fkey         | project_task                                                  | FOREIGN KEY (x_studio_location) REFERENCES res_partner(id) ON DELETE SET NULL
 project_task_planned_dates_check                                | project_task                                                  | CHECK ((planned_date_begin <= date_deadline))
 project_task_displayed_image_id_fkey                            | project_task                                                  | FOREIGN KEY (displayed_image_id) REFERENCES ir_attachment(id) ON DELETE SET NULL
 project_task_milestone_id_fkey                                  | project_task                                                  | FOREIGN KEY (milestone_id) REFERENCES project_milestone(id) ON DELETE SET NULL
 project_task_recurrence_id_fkey                                 | project_task                                                  | FOREIGN KEY (recurrence_id) REFERENCES project_task_recurrence(id) ON DELETE SET NULL
 project_task_x_studio_parent_trip_id_fkey                       | project_task                                                  | FOREIGN KEY (x_studio_parent_trip_id) REFERENCES project_task(id) ON DELETE SET NULL
 project_task_sale_order_id_fkey                                 | project_task                                                  | FOREIGN KEY (sale_order_id) REFERENCES sale_order(id) ON DELETE SET NULL
 project_task_write_uid_fkey                                     | project_task                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_task_create_uid_fkey                                    | project_task                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_task_sale_line_id_fkey                                  | project_task                                                  | FOREIGN KEY (sale_line_id) REFERENCES sale_order_line(id) ON DELETE SET NULL
 project_task_recurring_task_has_no_parent                       | project_task                                                  | CHECK ((NOT ((recurring_task IS TRUE) AND (parent_id IS NOT NULL))))
 project_task_private_task_has_no_parent                         | project_task                                                  | CHECK ((NOT ((project_id IS NULL) AND (parent_id IS NOT NULL))))
 project_task_pkey                                               | project_task                                                  | PRIMARY KEY (id)
 project_task_parent_id_fkey                                     | project_task                                                  | FOREIGN KEY (parent_id) REFERENCES project_task(id) ON DELETE SET NULL
 project_task_stage_id_fkey                                      | project_task                                                  | FOREIGN KEY (stage_id) REFERENCES project_task_type(id) ON DELETE RESTRICT
 project_task_convert_wizard_write_uid_fkey                      | project_task_convert_wizard                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_task_convert_wizard_stage_id_fkey                       | project_task_convert_wizard                                   | FOREIGN KEY (stage_id) REFERENCES helpdesk_stage(id) ON DELETE CASCADE
 project_task_convert_wizard_team_id_fkey                        | project_task_convert_wizard                                   | FOREIGN KEY (team_id) REFERENCES helpdesk_team(id) ON DELETE SET NULL
 project_task_convert_wizard_pkey                                | project_task_convert_wizard                                   | PRIMARY KEY (id)
 project_task_convert_wizard_create_uid_fkey                     | project_task_convert_wizard                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_task_create_timesheet_time_positive                     | project_task_create_timesheet                                 | CHECK ((time_spent > (0)::double precision))
 project_task_create_timesheet_pkey                              | project_task_create_timesheet                                 | PRIMARY KEY (id)
 project_task_create_timesheet_write_uid_fkey                    | project_task_create_timesheet                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_task_create_timesheet_create_uid_fkey                   | project_task_create_timesheet                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_task_create_timesheet_task_id_fkey                      | project_task_create_timesheet                                 | FOREIGN KEY (task_id) REFERENCES project_task(id) ON DELETE CASCADE
 project_task_recurrence_pkey                                    | project_task_recurrence                                       | PRIMARY KEY (id)
 project_task_recurrence_create_uid_fkey                         | project_task_recurrence                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_task_recurrence_write_uid_fkey                          | project_task_recurrence                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_task_type_sms_template_id_fkey                          | project_task_type                                             | FOREIGN KEY (sms_template_id) REFERENCES sms_template(id) ON DELETE SET NULL
 project_task_type_write_uid_fkey                                | project_task_type                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_task_type_create_uid_fkey                               | project_task_type                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_task_type_user_id_fkey                                  | project_task_type                                             | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 project_task_type_rating_template_id_fkey                       | project_task_type                                             | FOREIGN KEY (rating_template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 project_task_type_mail_template_id_fkey                         | project_task_type                                             | FOREIGN KEY (mail_template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 project_task_type_pkey                                          | project_task_type                                             | PRIMARY KEY (id)
 project_task_type_delete_wizard_pkey                            | project_task_type_delete_wizard                               | PRIMARY KEY (id)
 project_task_type_delete_wizard_write_uid_fkey                  | project_task_type_delete_wizard                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_task_type_delete_wizard_create_uid_fkey                 | project_task_type_delete_wizard                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_task_type_project_tas_project_task_type_delete_wiz_fkey | project_task_type_project_task_type_delete_wizard_rel         | FOREIGN KEY (project_task_type_delete_wizard_id) REFERENCES project_task_type_delete_wizard(id) ON DELETE CASCADE
 project_task_type_project_task_type_d_project_task_type_id_fkey | project_task_type_project_task_type_delete_wizard_rel         | FOREIGN KEY (project_task_type_id) REFERENCES project_task_type(id) ON DELETE CASCADE
 project_task_type_project_task_type_delete_wizard_rel_pkey      | project_task_type_project_task_type_delete_wizard_rel         | PRIMARY KEY (project_task_type_delete_wizard_id, project_task_type_id)
 project_task_type_rel_pkey                                      | project_task_type_rel                                         | PRIMARY KEY (project_id, type_id)
 project_task_type_rel_type_id_fkey                              | project_task_type_rel                                         | FOREIGN KEY (type_id) REFERENCES project_task_type(id) ON DELETE CASCADE
 project_task_type_rel_project_id_fkey                           | project_task_type_rel                                         | FOREIGN KEY (project_id) REFERENCES project_project(id) ON DELETE CASCADE
 project_task_user_rel_write_uid_fkey                            | project_task_user_rel                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_task_user_rel_stage_id_fkey                             | project_task_user_rel                                         | FOREIGN KEY (stage_id) REFERENCES project_task_type(id) ON DELETE RESTRICT
 project_task_user_rel_create_uid_fkey                           | project_task_user_rel                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_task_user_rel_project_personal_stage_unique             | project_task_user_rel                                         | UNIQUE (task_id, user_id)
 project_task_user_rel_user_id_fkey                              | project_task_user_rel                                         | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 project_task_user_rel_pkey                                      | project_task_user_rel                                         | PRIMARY KEY (id)
 project_task_user_rel_task_id_fkey                              | project_task_user_rel                                         | FOREIGN KEY (task_id) REFERENCES project_task(id) ON DELETE CASCADE
 project_update_create_uid_fkey                                  | project_update                                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_update_write_uid_fkey                                   | project_update                                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 project_update_pkey                                             | project_update                                                | PRIMARY KEY (id)
 project_update_uom_id_fkey                                      | project_update                                                | FOREIGN KEY (uom_id) REFERENCES uom_uom(id) ON DELETE SET NULL
 project_update_user_id_fkey                                     | project_update                                                | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE RESTRICT
 project_update_project_id_fkey                                  | project_update                                                | FOREIGN KEY (project_id) REFERENCES project_project(id) ON DELETE RESTRICT
 propose_change_write_uid_fkey                                   | propose_change                                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 propose_change_step_id_fkey                                     | propose_change                                                | FOREIGN KEY (step_id) REFERENCES quality_check(id) ON DELETE SET NULL
 propose_change_workorder_id_fkey                                | propose_change                                                | FOREIGN KEY (workorder_id) REFERENCES mrp_workorder(id) ON DELETE CASCADE
 propose_change_pkey                                             | propose_change                                                | PRIMARY KEY (id)
 propose_change_create_uid_fkey                                  | propose_change                                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 purchase_order_picking_type_id_fkey                             | purchase_order                                                | FOREIGN KEY (picking_type_id) REFERENCES stock_picking_type(id) ON DELETE RESTRICT
 purchase_order_project_id_fkey                                  | purchase_order                                                | FOREIGN KEY (project_id) REFERENCES project_project(id) ON DELETE SET NULL
 purchase_order_dest_address_id_fkey                             | purchase_order                                                | FOREIGN KEY (dest_address_id) REFERENCES res_partner(id) ON DELETE SET NULL
 purchase_order_write_uid_fkey                                   | purchase_order                                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 purchase_order_create_uid_fkey                                  | purchase_order                                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 purchase_order_company_id_fkey                                  | purchase_order                                                | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 purchase_order_user_id_fkey                                     | purchase_order                                                | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 purchase_order_incoterm_id_fkey                                 | purchase_order                                                | FOREIGN KEY (incoterm_id) REFERENCES account_incoterms(id) ON DELETE SET NULL
 purchase_order_payment_term_id_fkey                             | purchase_order                                                | FOREIGN KEY (payment_term_id) REFERENCES account_payment_term(id) ON DELETE SET NULL
 purchase_order_fiscal_position_id_fkey                          | purchase_order                                                | FOREIGN KEY (fiscal_position_id) REFERENCES account_fiscal_position(id) ON DELETE SET NULL
 purchase_order_currency_id_fkey                                 | purchase_order                                                | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE RESTRICT
 purchase_order_group_id_fkey                                    | purchase_order                                                | FOREIGN KEY (group_id) REFERENCES procurement_group(id) ON DELETE SET NULL
 purchase_order_partner_id_fkey                                  | purchase_order                                                | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE RESTRICT
 purchase_order_pkey                                             | purchase_order                                                | PRIMARY KEY (id)
 purchase_order_line_create_uid_fkey                             | purchase_order_line                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 purchase_order_line_currency_id_fkey                            | purchase_order_line                                           | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 purchase_order_line_sale_order_id_fkey                          | purchase_order_line                                           | FOREIGN KEY (sale_order_id) REFERENCES sale_order(id) ON DELETE SET NULL
 purchase_order_line_group_id_fkey                               | purchase_order_line                                           | FOREIGN KEY (group_id) REFERENCES procurement_group(id) ON DELETE SET NULL
 purchase_order_line_location_final_id_fkey                      | purchase_order_line                                           | FOREIGN KEY (location_final_id) REFERENCES stock_location(id) ON DELETE SET NULL
 purchase_order_line_orderpoint_id_fkey                          | purchase_order_line                                           | FOREIGN KEY (orderpoint_id) REFERENCES stock_warehouse_orderpoint(id) ON DELETE SET NULL
 purchase_order_line_partner_id_fkey                             | purchase_order_line                                           | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 purchase_order_line_company_id_fkey                             | purchase_order_line                                           | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 purchase_order_line_order_id_fkey                               | purchase_order_line                                           | FOREIGN KEY (order_id) REFERENCES purchase_order(id) ON DELETE CASCADE
 purchase_order_line_product_id_fkey                             | purchase_order_line                                           | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE RESTRICT
 purchase_order_line_product_uom_fkey                            | purchase_order_line                                           | FOREIGN KEY (product_uom) REFERENCES uom_uom(id) ON DELETE SET NULL
 purchase_order_line_sale_line_id_fkey                           | purchase_order_line                                           | FOREIGN KEY (sale_line_id) REFERENCES sale_order_line(id) ON DELETE SET NULL
 purchase_order_line_write_uid_fkey                              | purchase_order_line                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 purchase_order_line_product_packaging_id_fkey                   | purchase_order_line                                           | FOREIGN KEY (product_packaging_id) REFERENCES product_packaging(id) ON DELETE SET NULL
 purchase_order_line_non_accountable_null_fields                 | purchase_order_line                                           | CHECK (((display_type IS NULL) OR ((product_id IS NULL) AND (price_unit = (0)::numeric) AND (product_uom_qty = (0)::double precision) AND (product_uom IS NULL) AND (date_planned IS NULL))))
 purchase_order_line_accountable_required_fields                 | purchase_order_line                                           | CHECK (((display_type IS NOT NULL) OR is_downpayment OR ((product_id IS NOT NULL) AND (product_uom IS NOT NULL) AND (date_planned IS NOT NULL))))
 purchase_order_line_pkey                                        | purchase_order_line                                           | PRIMARY KEY (id)
 purchase_order_stock_picking_rel_pkey                           | purchase_order_stock_picking_rel                              | PRIMARY KEY (purchase_order_id, stock_picking_id)
 purchase_order_stock_picking_rel_stock_picking_id_fkey          | purchase_order_stock_picking_rel                              | FOREIGN KEY (stock_picking_id) REFERENCES stock_picking(id) ON DELETE CASCADE
 purchase_order_stock_picking_rel_purchase_order_id_fkey         | purchase_order_stock_picking_rel                              | FOREIGN KEY (purchase_order_id) REFERENCES purchase_order(id) ON DELETE CASCADE
 quality_alert_picking_id_fkey                                   | quality_alert                                                 | FOREIGN KEY (picking_id) REFERENCES stock_picking(id) ON DELETE SET NULL
 quality_alert_user_id_fkey                                      | quality_alert                                                 | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 quality_alert_team_id_fkey                                      | quality_alert                                                 | FOREIGN KEY (team_id) REFERENCES quality_alert_team(id) ON DELETE RESTRICT
 quality_alert_partner_id_fkey                                   | quality_alert                                                 | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 quality_alert_check_id_fkey                                     | quality_alert                                                 | FOREIGN KEY (check_id) REFERENCES quality_check(id) ON DELETE SET NULL
 quality_alert_product_tmpl_id_fkey                              | quality_alert                                                 | FOREIGN KEY (product_tmpl_id) REFERENCES product_template(id) ON DELETE SET NULL
 quality_alert_product_id_fkey                                   | quality_alert                                                 | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE SET NULL
 quality_alert_lot_id_fkey                                       | quality_alert                                                 | FOREIGN KEY (lot_id) REFERENCES stock_lot(id) ON DELETE SET NULL
 quality_alert_write_uid_fkey                                    | quality_alert                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 quality_alert_create_uid_fkey                                   | quality_alert                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 quality_alert_pkey                                              | quality_alert                                                 | PRIMARY KEY (id)
 quality_alert_production_id_fkey                                | quality_alert                                                 | FOREIGN KEY (production_id) REFERENCES mrp_production(id) ON DELETE SET NULL
 quality_alert_workcenter_id_fkey                                | quality_alert                                                 | FOREIGN KEY (workcenter_id) REFERENCES mrp_workcenter(id) ON DELETE SET NULL
 quality_alert_workorder_id_fkey                                 | quality_alert                                                 | FOREIGN KEY (workorder_id) REFERENCES mrp_workorder(id) ON DELETE SET NULL
 quality_alert_stage_id_fkey                                     | quality_alert                                                 | FOREIGN KEY (stage_id) REFERENCES quality_alert_stage(id) ON DELETE RESTRICT
 quality_alert_company_id_fkey                                   | quality_alert                                                 | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 quality_alert_reason_id_fkey                                    | quality_alert                                                 | FOREIGN KEY (reason_id) REFERENCES quality_reason(id) ON DELETE SET NULL
 quality_alert_quality_tag_rel_pkey                              | quality_alert_quality_tag_rel                                 | PRIMARY KEY (quality_alert_id, quality_tag_id)
 quality_alert_quality_tag_rel_quality_tag_id_fkey               | quality_alert_quality_tag_rel                                 | FOREIGN KEY (quality_tag_id) REFERENCES quality_tag(id) ON DELETE CASCADE
 quality_alert_quality_tag_rel_quality_alert_id_fkey             | quality_alert_quality_tag_rel                                 | FOREIGN KEY (quality_alert_id) REFERENCES quality_alert(id) ON DELETE CASCADE
 quality_alert_stage_create_uid_fkey                             | quality_alert_stage                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 quality_alert_stage_pkey                                        | quality_alert_stage                                           | PRIMARY KEY (id)
 quality_alert_stage_write_uid_fkey                              | quality_alert_stage                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 quality_alert_stage_quality_alert_team_rel_pkey                 | quality_alert_stage_quality_alert_team_rel                    | PRIMARY KEY (quality_alert_stage_id, quality_alert_team_id)
 quality_alert_stage_quality_alert_te_quality_alert_team_id_fkey | quality_alert_stage_quality_alert_team_rel                    | FOREIGN KEY (quality_alert_team_id) REFERENCES quality_alert_team(id) ON DELETE CASCADE
 quality_alert_stage_quality_alert_t_quality_alert_stage_id_fkey | quality_alert_stage_quality_alert_team_rel                    | FOREIGN KEY (quality_alert_stage_id) REFERENCES quality_alert_stage(id) ON DELETE CASCADE
 quality_alert_team_write_uid_fkey                               | quality_alert_team                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 quality_alert_team_pkey                                         | quality_alert_team                                            | PRIMARY KEY (id)
 quality_alert_team_alias_id_fkey                                | quality_alert_team                                            | FOREIGN KEY (alias_id) REFERENCES mail_alias(id) ON DELETE RESTRICT
 quality_alert_team_company_id_fkey                              | quality_alert_team                                            | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 quality_alert_team_create_uid_fkey                              | quality_alert_team                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 quality_check_company_id_fkey                                   | quality_check                                                 | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 quality_check_team_id_fkey                                      | quality_check                                                 | FOREIGN KEY (team_id) REFERENCES quality_alert_team(id) ON DELETE RESTRICT
 quality_check_write_uid_fkey                                    | quality_check                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 quality_check_create_uid_fkey                                   | quality_check                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 quality_check_test_type_id_fkey                                 | quality_check                                                 | FOREIGN KEY (test_type_id) REFERENCES quality_point_test_type(id) ON DELETE RESTRICT
 quality_check_workorder_id_fkey                                 | quality_check                                                 | FOREIGN KEY (workorder_id) REFERENCES mrp_workorder(id) ON DELETE SET NULL
 quality_check_workcenter_id_fkey                                | quality_check                                                 | FOREIGN KEY (workcenter_id) REFERENCES mrp_workcenter(id) ON DELETE SET NULL
 quality_check_production_id_fkey                                | quality_check                                                 | FOREIGN KEY (production_id) REFERENCES mrp_production(id) ON DELETE SET NULL
 quality_check_next_check_id_fkey                                | quality_check                                                 | FOREIGN KEY (next_check_id) REFERENCES quality_check(id) ON DELETE SET NULL
 quality_check_previous_check_id_fkey                            | quality_check                                                 | FOREIGN KEY (previous_check_id) REFERENCES quality_check(id) ON DELETE SET NULL
 quality_check_move_id_fkey                                      | quality_check                                                 | FOREIGN KEY (move_id) REFERENCES stock_move(id) ON DELETE SET NULL
 quality_check_point_id_fkey                                     | quality_check                                                 | FOREIGN KEY (point_id) REFERENCES quality_point(id) ON DELETE SET NULL
 quality_check_product_id_fkey                                   | quality_check                                                 | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE SET NULL
 quality_check_move_line_id_fkey                                 | quality_check                                                 | FOREIGN KEY (move_line_id) REFERENCES stock_move_line(id) ON DELETE SET NULL
 quality_check_picking_id_fkey                                   | quality_check                                                 | FOREIGN KEY (picking_id) REFERENCES stock_picking(id) ON DELETE SET NULL
 quality_check_pkey                                              | quality_check                                                 | PRIMARY KEY (id)
 quality_check_component_id_fkey                                 | quality_check                                                 | FOREIGN KEY (component_id) REFERENCES product_product(id) ON DELETE SET NULL
 quality_check_finished_lot_id_fkey                              | quality_check                                                 | FOREIGN KEY (finished_lot_id) REFERENCES stock_lot(id) ON DELETE SET NULL
 quality_check_employee_id_fkey                                  | quality_check                                                 | FOREIGN KEY (employee_id) REFERENCES hr_employee(id) ON DELETE SET NULL
 quality_check_lot_id_fkey                                       | quality_check                                                 | FOREIGN KEY (lot_id) REFERENCES stock_lot(id) ON DELETE SET NULL
 quality_check_user_id_fkey                                      | quality_check                                                 | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 quality_point_pkey                                              | quality_point                                                 | PRIMARY KEY (id)
 quality_point_operation_id_fkey                                 | quality_point                                                 | FOREIGN KEY (operation_id) REFERENCES mrp_routing_workcenter(id) ON DELETE SET NULL
 quality_point_component_id_fkey                                 | quality_point                                                 | FOREIGN KEY (component_id) REFERENCES product_product(id) ON DELETE SET NULL
 quality_point_test_type_id_fkey                                 | quality_point                                                 | FOREIGN KEY (test_type_id) REFERENCES quality_point_test_type(id) ON DELETE RESTRICT
 quality_point_create_uid_fkey                                   | quality_point                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 quality_point_company_id_fkey                                   | quality_point                                                 | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 quality_point_write_uid_fkey                                    | quality_point                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 quality_point_team_id_fkey                                      | quality_point                                                 | FOREIGN KEY (team_id) REFERENCES quality_alert_team(id) ON DELETE RESTRICT
 quality_point_user_id_fkey                                      | quality_point                                                 | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 quality_point_stock_picking_type_rel_quality_point_id_fkey      | quality_point_stock_picking_type_rel                          | FOREIGN KEY (quality_point_id) REFERENCES quality_point(id) ON DELETE CASCADE
 quality_point_stock_picking_type_rel_pkey                       | quality_point_stock_picking_type_rel                          | PRIMARY KEY (quality_point_id, stock_picking_type_id)
 quality_point_stock_picking_type_rel_stock_picking_type_id_fkey | quality_point_stock_picking_type_rel                          | FOREIGN KEY (stock_picking_type_id) REFERENCES stock_picking_type(id) ON DELETE CASCADE
 quality_point_test_type_create_uid_fkey                         | quality_point_test_type                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 quality_point_test_type_write_uid_fkey                          | quality_point_test_type                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 quality_point_test_type_pkey                                    | quality_point_test_type                                       | PRIMARY KEY (id)
 quality_reason_create_uid_fkey                                  | quality_reason                                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 quality_reason_write_uid_fkey                                   | quality_reason                                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 quality_reason_pkey                                             | quality_reason                                                | PRIMARY KEY (id)
 quality_tag_write_uid_fkey                                      | quality_tag                                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 quality_tag_create_uid_fkey                                     | quality_tag                                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 quality_tag_pkey                                                | quality_tag                                                   | PRIMARY KEY (id)
 quotation_document_write_uid_fkey                               | quotation_document                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 quotation_document_pkey                                         | quotation_document                                            | PRIMARY KEY (id)
 quotation_document_ir_attachment_id_fkey                        | quotation_document                                            | FOREIGN KEY (ir_attachment_id) REFERENCES ir_attachment(id) ON DELETE CASCADE
 quotation_document_create_uid_fkey                              | quotation_document                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 quotation_document_sale_order_rel_quotation_document_id_fkey    | quotation_document_sale_order_rel                             | FOREIGN KEY (quotation_document_id) REFERENCES quotation_document(id) ON DELETE CASCADE
 quotation_document_sale_order_rel_pkey                          | quotation_document_sale_order_rel                             | PRIMARY KEY (sale_order_id, quotation_document_id)
 quotation_document_sale_order_rel_sale_order_id_fkey            | quotation_document_sale_order_rel                             | FOREIGN KEY (sale_order_id) REFERENCES sale_order(id) ON DELETE CASCADE
 quotation_document_sale_pdf_form_fie_quotation_document_id_fkey | quotation_document_sale_pdf_form_field_rel                    | FOREIGN KEY (quotation_document_id) REFERENCES quotation_document(id) ON DELETE CASCADE
 quotation_document_sale_pdf_form_field_rel_pkey                 | quotation_document_sale_pdf_form_field_rel                    | PRIMARY KEY (quotation_document_id, sale_pdf_form_field_id)
 quotation_document_sale_pdf_form_fi_sale_pdf_form_field_id_fkey | quotation_document_sale_pdf_form_field_rel                    | FOREIGN KEY (sale_pdf_form_field_id) REFERENCES sale_pdf_form_field(id) ON DELETE CASCADE
 rating_rating_parent_res_model_id_fkey                          | rating_rating                                                 | FOREIGN KEY (parent_res_model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 rating_rating_pkey                                              | rating_rating                                                 | PRIMARY KEY (id)
 rating_rating_rating_range                                      | rating_rating                                                 | CHECK (((rating >= (0)::double precision) AND (rating <= (5)::double precision)))
 rating_rating_res_model_id_fkey                                 | rating_rating                                                 | FOREIGN KEY (res_model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 rating_rating_rated_partner_id_fkey                             | rating_rating                                                 | FOREIGN KEY (rated_partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 rating_rating_partner_id_fkey                                   | rating_rating                                                 | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 rating_rating_message_id_fkey                                   | rating_rating                                                 | FOREIGN KEY (message_id) REFERENCES mail_message(id) ON DELETE CASCADE
 rating_rating_publisher_id_fkey                                 | rating_rating                                                 | FOREIGN KEY (publisher_id) REFERENCES res_partner(id) ON DELETE SET NULL
 rating_rating_write_uid_fkey                                    | rating_rating                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 rating_rating_create_uid_fkey                                   | rating_rating                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 recruitment_tags_rel_pkey                                       | recruitment_tags_rel                                          | PRIMARY KEY (res_company_id, documents_tag_id)
 recruitment_tags_rel_documents_tag_id_fkey                      | recruitment_tags_rel                                          | FOREIGN KEY (documents_tag_id) REFERENCES documents_tag(id) ON DELETE CASCADE
 recruitment_tags_rel_res_company_id_fkey                        | recruitment_tags_rel                                          | FOREIGN KEY (res_company_id) REFERENCES res_company(id) ON DELETE CASCADE
 rel_followup_manual_reminder__account_followup_manual_remi_fkey | rel_followup_manual_reminder_res_partner                      | FOREIGN KEY (account_followup_manual_reminder_id) REFERENCES account_followup_manual_reminder(id) ON DELETE CASCADE
 rel_followup_manual_reminder_res_partner_res_partner_id_fkey    | rel_followup_manual_reminder_res_partner                      | FOREIGN KEY (res_partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 rel_followup_manual_reminder_res_partner_pkey                   | rel_followup_manual_reminder_res_partner                      | PRIMARY KEY (account_followup_manual_reminder_id, res_partner_id)
 rel_modules_langexport_pkey                                     | rel_modules_langexport                                        | PRIMARY KEY (wiz_id, module_id)
 rel_modules_langexport_wiz_id_fkey                              | rel_modules_langexport                                        | FOREIGN KEY (wiz_id) REFERENCES base_language_export(id) ON DELETE CASCADE
 rel_modules_langexport_module_id_fkey                           | rel_modules_langexport                                        | FOREIGN KEY (module_id) REFERENCES ir_module_module(id) ON DELETE CASCADE
 rel_server_actions_server_id_fkey                               | rel_server_actions                                            | FOREIGN KEY (server_id) REFERENCES ir_act_server(id) ON DELETE CASCADE
 rel_server_actions_action_id_fkey                               | rel_server_actions                                            | FOREIGN KEY (action_id) REFERENCES ir_act_server(id) ON DELETE CASCADE
 rel_server_actions_pkey                                         | rel_server_actions                                            | PRIMARY KEY (server_id, action_id)
 rel_studio_export_wizard_data_studio_export_wizard_data_id_fkey | rel_studio_export_wizard_data                                 | FOREIGN KEY (studio_export_wizard_data_id) REFERENCES studio_export_wizard_data(id) ON DELETE CASCADE
 rel_studio_export_wizard_data_studio_export_wizard_id_fkey      | rel_studio_export_wizard_data                                 | FOREIGN KEY (studio_export_wizard_id) REFERENCES studio_export_wizard(id) ON DELETE CASCADE
 rel_studio_export_wizard_data_pkey                              | rel_studio_export_wizard_data                                 | PRIMARY KEY (studio_export_wizard_id, studio_export_wizard_data_id)
 report_layout_pkey                                              | report_layout                                                 | PRIMARY KEY (id)
 report_layout_write_uid_fkey                                    | report_layout                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 report_layout_create_uid_fkey                                   | report_layout                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 report_layout_view_id_fkey                                      | report_layout                                                 | FOREIGN KEY (view_id) REFERENCES ir_ui_view(id) ON DELETE RESTRICT
 report_paperformat_create_uid_fkey                              | report_paperformat                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 report_paperformat_write_uid_fkey                               | report_paperformat                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 report_paperformat_pkey                                         | report_paperformat                                            | PRIMARY KEY (id)
 res_bank_state_fkey                                             | res_bank                                                      | FOREIGN KEY (state) REFERENCES res_country_state(id) ON DELETE SET NULL
 res_bank_create_uid_fkey                                        | res_bank                                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_bank_write_uid_fkey                                         | res_bank                                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_bank_pkey                                                   | res_bank                                                      | PRIMARY KEY (id)
 res_bank_country_fkey                                           | res_bank                                                      | FOREIGN KEY (country) REFERENCES res_country(id) ON DELETE SET NULL
 res_company_currency_id_fkey                                    | res_company                                                   | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE RESTRICT
 res_company_paperformat_id_fkey                                 | res_company                                                   | FOREIGN KEY (paperformat_id) REFERENCES report_paperformat(id) ON DELETE SET NULL
 res_company_external_report_layout_id_fkey                      | res_company                                                   | FOREIGN KEY (external_report_layout_id) REFERENCES ir_ui_view(id) ON DELETE SET NULL
 res_company_create_uid_fkey                                     | res_company                                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_company_write_uid_fkey                                      | res_company                                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_company_documents_fleet_folder_fkey                         | res_company                                                   | FOREIGN KEY (documents_fleet_folder) REFERENCES documents_document(id) ON DELETE SET NULL
 res_company_resource_calendar_id_fkey                           | res_company                                                   | FOREIGN KEY (resource_calendar_id) REFERENCES resource_calendar(id) ON DELETE RESTRICT
 res_company_alias_domain_id_fkey                                | res_company                                                   | FOREIGN KEY (alias_domain_id) REFERENCES mail_alias_domain(id) ON DELETE SET NULL
 res_company_internal_project_id_fkey                            | res_company                                                   | FOREIGN KEY (internal_project_id) REFERENCES project_project(id) ON DELETE SET NULL
 res_company_timesheet_encode_uom_id_fkey                        | res_company                                                   | FOREIGN KEY (timesheet_encode_uom_id) REFERENCES uom_uom(id) ON DELETE SET NULL
 res_company_project_time_mode_id_fkey                           | res_company                                                   | FOREIGN KEY (project_time_mode_id) REFERENCES uom_uom(id) ON DELETE SET NULL
 res_company_website_id_fkey                                     | res_company                                                   | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE SET NULL
 res_company_expense_journal_id_fkey                             | res_company                                                   | FOREIGN KEY (expense_journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 res_company_account_production_wip_account_id_fkey              | res_company                                                   | FOREIGN KEY (account_production_wip_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_account_production_wip_overhead_account_id_fkey     | res_company                                                   | FOREIGN KEY (account_production_wip_overhead_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_sale_discount_product_id_fkey                       | res_company                                                   | FOREIGN KEY (sale_discount_product_id) REFERENCES product_product(id) ON DELETE SET NULL
 res_company_stock_mail_confirmation_template_id_fkey            | res_company                                                   | FOREIGN KEY (stock_mail_confirmation_template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 res_company_internal_transit_location_id_fkey                   | res_company                                                   | FOREIGN KEY (internal_transit_location_id) REFERENCES stock_location(id) ON DELETE RESTRICT
 res_company_stock_sms_confirmation_template_id_fkey             | res_company                                                   | FOREIGN KEY (stock_sms_confirmation_template_id) REFERENCES sms_template(id) ON DELETE SET NULL
 res_company_account_folder_id_fkey                              | res_company                                                   | FOREIGN KEY (account_folder_id) REFERENCES documents_document(id) ON DELETE SET NULL
 res_company_name_uniq                                           | res_company                                                   | UNIQUE (name)
 res_company_pkey                                                | res_company                                                   | PRIMARY KEY (id)
 res_company_loss_account_id_fkey                                | res_company                                                   | FOREIGN KEY (loss_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_gain_account_id_fkey                                | res_company                                                   | FOREIGN KEY (gain_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_account_representative_id_fkey                      | res_company                                                   | FOREIGN KEY (account_representative_id) REFERENCES res_partner(id) ON DELETE SET NULL
 res_company_account_revaluation_income_provision_account_i_fkey | res_company                                                   | FOREIGN KEY (account_revaluation_income_provision_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_account_revaluation_expense_provision_account__fkey | res_company                                                   | FOREIGN KEY (account_revaluation_expense_provision_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_account_revaluation_journal_id_fkey                 | res_company                                                   | FOREIGN KEY (account_revaluation_journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 res_company_account_tax_periodicity_journal_id_fkey             | res_company                                                   | FOREIGN KEY (account_tax_periodicity_journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 res_company_recruitment_folder_id_fkey                          | res_company                                                   | FOREIGN KEY (recruitment_folder_id) REFERENCES documents_document(id) ON DELETE SET NULL
 res_company_deferred_revenue_account_id_fkey                    | res_company                                                   | FOREIGN KEY (deferred_revenue_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_deferred_revenue_journal_id_fkey                    | res_company                                                   | FOREIGN KEY (deferred_revenue_journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 res_company_deferred_expense_account_id_fkey                    | res_company                                                   | FOREIGN KEY (deferred_expense_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_deferred_expense_journal_id_fkey                    | res_company                                                   | FOREIGN KEY (deferred_expense_journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 res_company_signing_user_fkey                                   | res_company                                                   | FOREIGN KEY (signing_user) REFERENCES res_users(id) ON DELETE SET NULL
 res_company_sale_order_template_id_fkey                         | res_company                                                   | FOREIGN KEY (sale_order_template_id) REFERENCES sale_order_template(id) ON DELETE SET NULL
 res_company_account_discount_expense_allocation_id_fkey         | res_company                                                   | FOREIGN KEY (account_discount_expense_allocation_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_account_discount_income_allocation_id_fkey          | res_company                                                   | FOREIGN KEY (account_discount_income_allocation_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_account_cash_basis_base_account_id_fkey             | res_company                                                   | FOREIGN KEY (account_cash_basis_base_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_tax_cash_basis_journal_id_fkey                      | res_company                                                   | FOREIGN KEY (tax_cash_basis_journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 res_company_account_fiscal_country_id_fkey                      | res_company                                                   | FOREIGN KEY (account_fiscal_country_id) REFERENCES res_country(id) ON DELETE SET NULL
 res_company_automatic_entry_default_journal_id_fkey             | res_company                                                   | FOREIGN KEY (automatic_entry_default_journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 res_company_revenue_accrual_account_id_fkey                     | res_company                                                   | FOREIGN KEY (revenue_accrual_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_expense_accrual_account_id_fkey                     | res_company                                                   | FOREIGN KEY (expense_accrual_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_account_default_pos_receivable_account_id_fkey      | res_company                                                   | FOREIGN KEY (account_default_pos_receivable_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_account_opening_move_id_fkey                        | res_company                                                   | FOREIGN KEY (account_opening_move_id) REFERENCES account_move(id) ON DELETE SET NULL
 res_company_batch_payment_sequence_id_fkey                      | res_company                                                   | FOREIGN KEY (batch_payment_sequence_id) REFERENCES ir_sequence(id) ON DELETE SET NULL
 res_company_incoterm_id_fkey                                    | res_company                                                   | FOREIGN KEY (incoterm_id) REFERENCES account_incoterms(id) ON DELETE SET NULL
 res_company_expense_currency_exchange_account_id_fkey           | res_company                                                   | FOREIGN KEY (expense_currency_exchange_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_income_currency_exchange_account_id_fkey            | res_company                                                   | FOREIGN KEY (income_currency_exchange_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_currency_exchange_journal_id_fkey                   | res_company                                                   | FOREIGN KEY (currency_exchange_journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 res_company_account_purchase_tax_id_fkey                        | res_company                                                   | FOREIGN KEY (account_purchase_tax_id) REFERENCES account_tax(id) ON DELETE SET NULL
 res_company_account_sale_tax_id_fkey                            | res_company                                                   | FOREIGN KEY (account_sale_tax_id) REFERENCES account_tax(id) ON DELETE SET NULL
 res_company_account_journal_early_pay_discount_loss_accoun_fkey | res_company                                                   | FOREIGN KEY (account_journal_early_pay_discount_loss_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_account_journal_early_pay_discount_gain_accoun_fkey | res_company                                                   | FOREIGN KEY (account_journal_early_pay_discount_gain_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_account_journal_suspense_account_id_fkey            | res_company                                                   | FOREIGN KEY (account_journal_suspense_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_default_cash_difference_expense_account_id_fkey     | res_company                                                   | FOREIGN KEY (default_cash_difference_expense_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_default_cash_difference_income_account_id_fkey      | res_company                                                   | FOREIGN KEY (default_cash_difference_income_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_transfer_account_id_fkey                            | res_company                                                   | FOREIGN KEY (transfer_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_expense_outstanding_account_id_fkey                 | res_company                                                   | FOREIGN KEY (expense_outstanding_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 res_company_documents_hr_folder_fkey                            | res_company                                                   | FOREIGN KEY (documents_hr_folder) REFERENCES documents_document(id) ON DELETE SET NULL
 res_company_product_folder_id_fkey                              | res_company                                                   | FOREIGN KEY (product_folder_id) REFERENCES documents_document(id) ON DELETE SET NULL
 res_company_nomenclature_id_fkey                                | res_company                                                   | FOREIGN KEY (nomenclature_id) REFERENCES barcode_nomenclature(id) ON DELETE SET NULL
 res_company_check_quotation_validity_days                       | res_company                                                   | CHECK ((quotation_validity_days >= 0))
 res_company_document_spreadsheet_folder_id_fkey                 | res_company                                                   | FOREIGN KEY (document_spreadsheet_folder_id) REFERENCES documents_document(id) ON DELETE SET NULL
 res_company_parent_id_fkey                                      | res_company                                                   | FOREIGN KEY (parent_id) REFERENCES res_company(id) ON DELETE RESTRICT
 res_company_partner_id_fkey                                     | res_company                                                   | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE RESTRICT
 res_company_users_rel_user_id_fkey                              | res_company_users_rel                                         | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 res_company_users_rel_pkey                                      | res_company_users_rel                                         | PRIMARY KEY (cid, user_id)
 res_company_users_rel_cid_fkey                                  | res_company_users_rel                                         | FOREIGN KEY (cid) REFERENCES res_company(id) ON DELETE CASCADE
 res_company_whatsapp_account_rel_res_company_id_fkey            | res_company_whatsapp_account_rel                              | FOREIGN KEY (res_company_id) REFERENCES res_company(id) ON DELETE CASCADE
 res_company_whatsapp_account_rel_pkey                           | res_company_whatsapp_account_rel                              | PRIMARY KEY (whatsapp_account_id, res_company_id)
 res_company_whatsapp_account_rel_whatsapp_account_id_fkey       | res_company_whatsapp_account_rel                              | FOREIGN KEY (whatsapp_account_id) REFERENCES whatsapp_account(id) ON DELETE CASCADE
 res_config_write_uid_fkey                                       | res_config                                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_config_pkey                                                 | res_config                                                    | PRIMARY KEY (id)
 res_config_create_uid_fkey                                      | res_config                                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_config_settings_invoice_mail_template_id_fkey               | res_config_settings                                           | FOREIGN KEY (invoice_mail_template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 res_config_settings_website_id_fkey                             | res_config_settings                                           | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE CASCADE
 res_config_settings_write_uid_fkey                              | res_config_settings                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_config_settings_company_id_fkey                             | res_config_settings                                           | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE CASCADE
 res_config_settings_create_uid_fkey                             | res_config_settings                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_config_settings_pkey                                        | res_config_settings                                           | PRIMARY KEY (id)
 res_config_settings_digest_id_fkey                              | res_config_settings                                           | FOREIGN KEY (digest_id) REFERENCES digest_digest(id) ON DELETE SET NULL
 res_config_settings_auth_signup_template_user_id_fkey           | res_config_settings                                           | FOREIGN KEY (auth_signup_template_user_id) REFERENCES res_users(id) ON DELETE SET NULL
 res_config_settings_mass_mailing_mail_server_id_fkey            | res_config_settings                                           | FOREIGN KEY (mass_mailing_mail_server_id) REFERENCES ir_mail_server(id) ON DELETE SET NULL
 res_config_settings_check_deletion_delay                        | res_config_settings                                           | CHECK ((deletion_delay >= 0))
 res_country_create_uid_fkey                                     | res_country                                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_country_address_view_id_fkey                                | res_country                                                   | FOREIGN KEY (address_view_id) REFERENCES ir_ui_view(id) ON DELETE SET NULL
 res_country_currency_id_fkey                                    | res_country                                                   | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 res_country_pkey                                                | res_country                                                   | PRIMARY KEY (id)
 res_country_name_uniq                                           | res_country                                                   | UNIQUE (name)
 res_country_code_uniq                                           | res_country                                                   | UNIQUE (code)
 res_country_write_uid_fkey                                      | res_country                                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_country_group_create_uid_fkey                               | res_country_group                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_country_group_pkey                                          | res_country_group                                             | PRIMARY KEY (id)
 res_country_group_write_uid_fkey                                | res_country_group                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_country_group_pricelist_rel_pkey                            | res_country_group_pricelist_rel                               | PRIMARY KEY (pricelist_id, res_country_group_id)
 res_country_group_pricelist_rel_pricelist_id_fkey               | res_country_group_pricelist_rel                               | FOREIGN KEY (pricelist_id) REFERENCES product_pricelist(id) ON DELETE CASCADE
 res_country_group_pricelist_rel_res_country_group_id_fkey       | res_country_group_pricelist_rel                               | FOREIGN KEY (res_country_group_id) REFERENCES res_country_group(id) ON DELETE CASCADE
 res_country_res_country_group_rel_res_country_id_fkey           | res_country_res_country_group_rel                             | FOREIGN KEY (res_country_id) REFERENCES res_country(id) ON DELETE CASCADE
 res_country_res_country_group_rel_res_country_group_id_fkey     | res_country_res_country_group_rel                             | FOREIGN KEY (res_country_group_id) REFERENCES res_country_group(id) ON DELETE CASCADE
 res_country_res_country_group_rel_pkey                          | res_country_res_country_group_rel                             | PRIMARY KEY (res_country_id, res_country_group_id)
 res_country_state_create_uid_fkey                               | res_country_state                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_country_state_pkey                                          | res_country_state                                             | PRIMARY KEY (id)
 res_country_state_name_code_uniq                                | res_country_state                                             | UNIQUE (country_id, code)
 res_country_state_write_uid_fkey                                | res_country_state                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_country_state_country_id_fkey                               | res_country_state                                             | FOREIGN KEY (country_id) REFERENCES res_country(id) ON DELETE RESTRICT
 res_currency_pkey                                               | res_currency                                                  | PRIMARY KEY (id)
 res_currency_write_uid_fkey                                     | res_currency                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_currency_rounding_gt_zero                                   | res_currency                                                  | CHECK ((rounding > (0)::numeric))
 res_currency_create_uid_fkey                                    | res_currency                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_currency_unique_name                                        | res_currency                                                  | UNIQUE (name)
 res_currency_rate_pkey                                          | res_currency_rate                                             | PRIMARY KEY (id)
 res_currency_rate_company_id_fkey                               | res_currency_rate                                             | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 res_currency_rate_currency_id_fkey                              | res_currency_rate                                             | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE CASCADE
 res_currency_rate_write_uid_fkey                                | res_currency_rate                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_currency_rate_currency_rate_check                           | res_currency_rate                                             | CHECK ((rate > (0)::numeric))
 res_currency_rate_unique_name_per_day                           | res_currency_rate                                             | UNIQUE (name, currency_id, company_id)
 res_currency_rate_create_uid_fkey                               | res_currency_rate                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_device_log_pkey                                             | res_device_log                                                | PRIMARY KEY (id)
 res_device_log_write_uid_fkey                                   | res_device_log                                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_device_log_create_uid_fkey                                  | res_device_log                                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_device_log_user_id_fkey                                     | res_device_log                                                | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 res_groups_check_api_key_duration                               | res_groups                                                    | CHECK ((api_key_duration >= (0)::double precision))
 res_groups_write_uid_fkey                                       | res_groups                                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_groups_create_uid_fkey                                      | res_groups                                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_groups_category_id_fkey                                     | res_groups                                                    | FOREIGN KEY (category_id) REFERENCES ir_module_category(id) ON DELETE SET NULL
 res_groups_name_uniq                                            | res_groups                                                    | UNIQUE (category_id, name)
 res_groups_pkey                                                 | res_groups                                                    | PRIMARY KEY (id)
 res_groups_implied_rel_pkey                                     | res_groups_implied_rel                                        | PRIMARY KEY (gid, hid)
 res_groups_implied_rel_hid_fkey                                 | res_groups_implied_rel                                        | FOREIGN KEY (hid) REFERENCES res_groups(id) ON DELETE CASCADE
 res_groups_implied_rel_gid_fkey                                 | res_groups_implied_rel                                        | FOREIGN KEY (gid) REFERENCES res_groups(id) ON DELETE CASCADE
 res_groups_report_rel_uid_fkey                                  | res_groups_report_rel                                         | FOREIGN KEY (uid) REFERENCES ir_act_report_xml(id) ON DELETE CASCADE
 res_groups_report_rel_pkey                                      | res_groups_report_rel                                         | PRIMARY KEY (uid, gid)
 res_groups_report_rel_gid_fkey                                  | res_groups_report_rel                                         | FOREIGN KEY (gid) REFERENCES res_groups(id) ON DELETE CASCADE
 res_groups_spreadsheet_dashboard_rel_pkey                       | res_groups_spreadsheet_dashboard_rel                          | PRIMARY KEY (spreadsheet_dashboard_id, res_groups_id)
 res_groups_spreadsheet_dashboard_rel_res_groups_id_fkey         | res_groups_spreadsheet_dashboard_rel                          | FOREIGN KEY (res_groups_id) REFERENCES res_groups(id) ON DELETE CASCADE
 res_groups_spreadsheet_dashboard__spreadsheet_dashboard_id_fkey | res_groups_spreadsheet_dashboard_rel                          | FOREIGN KEY (spreadsheet_dashboard_id) REFERENCES spreadsheet_dashboard(id) ON DELETE CASCADE
 res_groups_spreadsheet_docume_spreadsheet_document_to_dash_fkey | res_groups_spreadsheet_document_to_dashboard_rel              | FOREIGN KEY (spreadsheet_document_to_dashboard_id) REFERENCES spreadsheet_document_to_dashboard(id) ON DELETE CASCADE
 res_groups_spreadsheet_document_to_dashboard_rel_pkey           | res_groups_spreadsheet_document_to_dashboard_rel              | PRIMARY KEY (spreadsheet_document_to_dashboard_id, res_groups_id)
 res_groups_spreadsheet_document_to_dashboard_res_groups_id_fkey | res_groups_spreadsheet_document_to_dashboard_rel              | FOREIGN KEY (res_groups_id) REFERENCES res_groups(id) ON DELETE CASCADE
 res_groups_users_rel_pkey                                       | res_groups_users_rel                                          | PRIMARY KEY (gid, uid)
 res_groups_users_rel_gid_fkey                                   | res_groups_users_rel                                          | FOREIGN KEY (gid) REFERENCES res_groups(id) ON DELETE CASCADE
 res_groups_users_rel_uid_fkey                                   | res_groups_users_rel                                          | FOREIGN KEY (uid) REFERENCES res_users(id) ON DELETE CASCADE
 res_groups_website_menu_rel_res_groups_id_fkey                  | res_groups_website_menu_rel                                   | FOREIGN KEY (res_groups_id) REFERENCES res_groups(id) ON DELETE CASCADE
 res_groups_website_menu_rel_website_menu_id_fkey                | res_groups_website_menu_rel                                   | FOREIGN KEY (website_menu_id) REFERENCES website_menu(id) ON DELETE CASCADE
 res_groups_website_menu_rel_pkey                                | res_groups_website_menu_rel                                   | PRIMARY KEY (website_menu_id, res_groups_id)
 res_lang_name_uniq                                              | res_lang                                                      | UNIQUE (name)
 res_lang_code_uniq                                              | res_lang                                                      | UNIQUE (code)
 res_lang_pkey                                                   | res_lang                                                      | PRIMARY KEY (id)
 res_lang_url_code_uniq                                          | res_lang                                                      | UNIQUE (url_code)
 res_lang_write_uid_fkey                                         | res_lang                                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_lang_create_uid_fkey                                        | res_lang                                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_lang_install_rel_pkey                                       | res_lang_install_rel                                          | PRIMARY KEY (language_wizard_id, lang_id)
 res_lang_install_rel_language_wizard_id_fkey                    | res_lang_install_rel                                          | FOREIGN KEY (language_wizard_id) REFERENCES base_language_install(id) ON DELETE CASCADE
 res_lang_install_rel_lang_id_fkey                               | res_lang_install_rel                                          | FOREIGN KEY (lang_id) REFERENCES res_lang(id) ON DELETE CASCADE
 res_partner_user_id_fkey                                        | res_partner                                                   | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 res_partner_country_id_fkey                                     | res_partner                                                   | FOREIGN KEY (country_id) REFERENCES res_country(id) ON DELETE RESTRICT
 res_partner_parent_id_fkey                                      | res_partner                                                   | FOREIGN KEY (parent_id) REFERENCES res_partner(id) ON DELETE SET NULL
 res_partner_create_uid_fkey                                     | res_partner                                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_partner_invoice_template_pdf_report_id_fkey                 | res_partner                                                   | FOREIGN KEY (invoice_template_pdf_report_id) REFERENCES ir_act_report_xml(id) ON DELETE SET NULL
 res_partner_pkey                                                | res_partner                                                   | PRIMARY KEY (id)
 res_partner_state_id_fkey                                       | res_partner                                                   | FOREIGN KEY (state_id) REFERENCES res_country_state(id) ON DELETE RESTRICT
 res_partner_title_fkey                                          | res_partner                                                   | FOREIGN KEY (title) REFERENCES res_partner_title(id) ON DELETE SET NULL
 res_partner_industry_id_fkey                                    | res_partner                                                   | FOREIGN KEY (industry_id) REFERENCES res_partner_industry(id) ON DELETE SET NULL
 res_partner_company_id_fkey                                     | res_partner                                                   | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 res_partner_buyer_id_fkey                                       | res_partner                                                   | FOREIGN KEY (buyer_id) REFERENCES res_users(id) ON DELETE SET NULL
 res_partner_commercial_partner_id_fkey                          | res_partner                                                   | FOREIGN KEY (commercial_partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 res_partner_check_name                                          | res_partner                                                   | CHECK (((((type)::text = 'contact'::text) AND (name IS NOT NULL)) OR ((type)::text <> 'contact'::text)))
 res_partner_write_uid_fkey                                      | res_partner                                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_partner_website_id_fkey                                     | res_partner                                                   | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE RESTRICT
 res_partner_autocomplete_sync_pkey                              | res_partner_autocomplete_sync                                 | PRIMARY KEY (id)
 res_partner_autocomplete_sync_partner_id_fkey                   | res_partner_autocomplete_sync                                 | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 res_partner_autocomplete_sync_write_uid_fkey                    | res_partner_autocomplete_sync                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_partner_autocomplete_sync_create_uid_fkey                   | res_partner_autocomplete_sync                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_partner_bank_currency_id_fkey                               | res_partner_bank                                              | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 res_partner_bank_unique_number                                  | res_partner_bank                                              | UNIQUE (sanitized_acc_number, partner_id)
 res_partner_bank_pkey                                           | res_partner_bank                                              | PRIMARY KEY (id)
 res_partner_bank_partner_id_fkey                                | res_partner_bank                                              | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 res_partner_bank_bank_id_fkey                                   | res_partner_bank                                              | FOREIGN KEY (bank_id) REFERENCES res_bank(id) ON DELETE SET NULL
 res_partner_bank_company_id_fkey                                | res_partner_bank                                              | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 res_partner_bank_create_uid_fkey                                | res_partner_bank                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_partner_bank_write_uid_fkey                                 | res_partner_bank                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_partner_category_parent_id_fkey                             | res_partner_category                                          | FOREIGN KEY (parent_id) REFERENCES res_partner_category(id) ON DELETE CASCADE
 res_partner_category_pkey                                       | res_partner_category                                          | PRIMARY KEY (id)
 res_partner_category_create_uid_fkey                            | res_partner_category                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_partner_category_write_uid_fkey                             | res_partner_category                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_partner_industry_write_uid_fkey                             | res_partner_industry                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_partner_industry_pkey                                       | res_partner_industry                                          | PRIMARY KEY (id)
 res_partner_industry_create_uid_fkey                            | res_partner_industry                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_partner_res_partner_category_rel_category_id_fkey           | res_partner_res_partner_category_rel                          | FOREIGN KEY (category_id) REFERENCES res_partner_category(id) ON DELETE CASCADE
 res_partner_res_partner_category_rel_pkey                       | res_partner_res_partner_category_rel                          | PRIMARY KEY (category_id, partner_id)
 res_partner_res_partner_category_rel_partner_id_fkey            | res_partner_res_partner_category_rel                          | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 res_partner_title_create_uid_fkey                               | res_partner_title                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_partner_title_write_uid_fkey                                | res_partner_title                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_partner_title_pkey                                          | res_partner_title                                             | PRIMARY KEY (id)
 res_user_approval_rule_notify_rel_pkey                          | res_user_approval_rule_notify_rel                             | PRIMARY KEY (studio_approval_rule_delegate_id, res_users_id)
 res_user_approval_rule_notify_rel_res_users_id_fkey             | res_user_approval_rule_notify_rel                             | FOREIGN KEY (res_users_id) REFERENCES res_users(id) ON DELETE CASCADE
 res_user_approval_rule_notify_studio_approval_rule_delegat_fkey | res_user_approval_rule_notify_rel                             | FOREIGN KEY (studio_approval_rule_delegate_id) REFERENCES studio_approval_rule_delegate(id) ON DELETE CASCADE
 res_users_target_success_not_zero                               | res_users                                                     | CHECK ((helpdesk_target_success > (0)::double precision))
 res_users_target_rating_not_zero                                | res_users                                                     | CHECK ((helpdesk_target_rating > (0)::double precision))
 res_users_target_closed_not_zero                                | res_users                                                     | CHECK ((helpdesk_target_closed > 0))
 res_users_website_id_fkey                                       | res_users                                                     | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE SET NULL
 res_users_partner_id_fkey                                       | res_users                                                     | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE RESTRICT
 res_users_company_id_fkey                                       | res_users                                                     | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 res_users_create_uid_fkey                                       | res_users                                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_users_sale_team_id_fkey                                     | res_users                                                     | FOREIGN KEY (sale_team_id) REFERENCES crm_team(id) ON DELETE SET NULL
 res_users_notification_type                                     | res_users                                                     | CHECK ((((notification_type)::text = 'email'::text) OR (NOT share)))
 res_users_pkey                                                  | res_users                                                     | PRIMARY KEY (id)
 res_users_write_uid_fkey                                        | res_users                                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_users_login_key                                             | res_users                                                     | UNIQUE (login, website_id)
 res_users_apikeys_user_id_fkey                                  | res_users_apikeys                                             | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 res_users_apikeys_index_check                                   | res_users_apikeys                                             | CHECK ((char_length((index)::text) = 8))
 res_users_apikeys_pkey                                          | res_users_apikeys                                             | PRIMARY KEY (id)
 res_users_apikeys_description_write_uid_fkey                    | res_users_apikeys_description                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_users_apikeys_description_create_uid_fkey                   | res_users_apikeys_description                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_users_apikeys_description_pkey                              | res_users_apikeys_description                                 | PRIMARY KEY (id)
 res_users_deletion_user_id_fkey                                 | res_users_deletion                                            | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 res_users_deletion_create_uid_fkey                              | res_users_deletion                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_users_deletion_write_uid_fkey                               | res_users_deletion                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_users_deletion_pkey                                         | res_users_deletion                                            | PRIMARY KEY (id)
 res_users_identitycheck_pkey                                    | res_users_identitycheck                                       | PRIMARY KEY (id)
 res_users_identitycheck_create_uid_fkey                         | res_users_identitycheck                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_users_identitycheck_write_uid_fkey                          | res_users_identitycheck                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_users_log_pkey                                              | res_users_log                                                 | PRIMARY KEY (id)
 res_users_log_create_uid_fkey                                   | res_users_log                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_users_log_write_uid_fkey                                    | res_users_log                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_users_settings_user_id_fkey                                 | res_users_settings                                            | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 res_users_settings_unique_user_id                               | res_users_settings                                            | UNIQUE (user_id)
 res_users_settings_pkey                                         | res_users_settings                                            | PRIMARY KEY (id)
 res_users_settings_write_uid_fkey                               | res_users_settings                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_users_settings_create_uid_fkey                              | res_users_settings                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_users_settings_volumes_user_setting_id_fkey                 | res_users_settings_volumes                                    | FOREIGN KEY (user_setting_id) REFERENCES res_users_settings(id) ON DELETE CASCADE
 res_users_settings_volumes_partner_or_guest_exists              | res_users_settings_volumes                                    | CHECK ((((partner_id IS NOT NULL) AND (guest_id IS NULL)) OR ((partner_id IS NULL) AND (guest_id IS NOT NULL))))
 res_users_settings_volumes_pkey                                 | res_users_settings_volumes                                    | PRIMARY KEY (id)
 res_users_settings_volumes_guest_id_fkey                        | res_users_settings_volumes                                    | FOREIGN KEY (guest_id) REFERENCES res_partner(id) ON DELETE CASCADE
 res_users_settings_volumes_partner_id_fkey                      | res_users_settings_volumes                                    | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
 res_users_settings_volumes_write_uid_fkey                       | res_users_settings_volumes                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_users_settings_volumes_create_uid_fkey                      | res_users_settings_volumes                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 res_users_studio_approval_rule_delegate_rel_res_users_id_fkey   | res_users_studio_approval_rule_delegate_rel                   | FOREIGN KEY (res_users_id) REFERENCES res_users(id) ON DELETE CASCADE
 res_users_studio_approval_rule_delegate_rel_pkey                | res_users_studio_approval_rule_delegate_rel                   | PRIMARY KEY (studio_approval_rule_delegate_id, res_users_id)
 res_users_studio_approval_rul_studio_approval_rule_delegat_fkey | res_users_studio_approval_rule_delegate_rel                   | FOREIGN KEY (studio_approval_rule_delegate_id) REFERENCES studio_approval_rule_delegate(id) ON DELETE CASCADE
 res_users_web_tour_tour_rel_web_tour_tour_id_fkey               | res_users_web_tour_tour_rel                                   | FOREIGN KEY (web_tour_tour_id) REFERENCES web_tour_tour(id) ON DELETE CASCADE
 res_users_web_tour_tour_rel_pkey                                | res_users_web_tour_tour_rel                                   | PRIMARY KEY (web_tour_tour_id, res_users_id)
 res_users_web_tour_tour_rel_res_users_id_fkey                   | res_users_web_tour_tour_rel                                   | FOREIGN KEY (res_users_id) REFERENCES res_users(id) ON DELETE CASCADE
 res_users_whatsapp_account_rel_pkey                             | res_users_whatsapp_account_rel                                | PRIMARY KEY (whatsapp_account_id, res_users_id)
 res_users_whatsapp_account_rel_res_users_id_fkey                | res_users_whatsapp_account_rel                                | FOREIGN KEY (res_users_id) REFERENCES res_users(id) ON DELETE CASCADE
 res_users_whatsapp_account_rel_whatsapp_account_id_fkey         | res_users_whatsapp_account_rel                                | FOREIGN KEY (whatsapp_account_id) REFERENCES whatsapp_account(id) ON DELETE CASCADE
 res_users_whatsapp_template_rel_whatsapp_template_id_fkey       | res_users_whatsapp_template_rel                               | FOREIGN KEY (whatsapp_template_id) REFERENCES whatsapp_template(id) ON DELETE CASCADE
 res_users_whatsapp_template_rel_res_users_id_fkey               | res_users_whatsapp_template_rel                               | FOREIGN KEY (res_users_id) REFERENCES res_users(id) ON DELETE CASCADE
 res_users_whatsapp_template_rel_pkey                            | res_users_whatsapp_template_rel                               | PRIMARY KEY (whatsapp_template_id, res_users_id)
 reset_view_arch_wizard_write_uid_fkey                           | reset_view_arch_wizard                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 reset_view_arch_wizard_compare_view_id_fkey                     | reset_view_arch_wizard                                        | FOREIGN KEY (compare_view_id) REFERENCES ir_ui_view(id) ON DELETE SET NULL
 reset_view_arch_wizard_view_id_fkey                             | reset_view_arch_wizard                                        | FOREIGN KEY (view_id) REFERENCES ir_ui_view(id) ON DELETE SET NULL
 reset_view_arch_wizard_pkey                                     | reset_view_arch_wizard                                        | PRIMARY KEY (id)
 reset_view_arch_wizard_create_uid_fkey                          | reset_view_arch_wizard                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 resource_calendar_create_uid_fkey                               | resource_calendar                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 resource_calendar_pkey                                          | resource_calendar                                             | PRIMARY KEY (id)
 resource_calendar_write_uid_fkey                                | resource_calendar                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 resource_calendar_company_id_fkey                               | resource_calendar                                             | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 resource_calendar_attendance_pkey                               | resource_calendar_attendance                                  | PRIMARY KEY (id)
 resource_calendar_attendance_calendar_id_fkey                   | resource_calendar_attendance                                  | FOREIGN KEY (calendar_id) REFERENCES resource_calendar(id) ON DELETE CASCADE
 resource_calendar_attendance_resource_id_fkey                   | resource_calendar_attendance                                  | FOREIGN KEY (resource_id) REFERENCES resource_resource(id) ON DELETE SET NULL
 resource_calendar_attendance_create_uid_fkey                    | resource_calendar_attendance                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 resource_calendar_attendance_write_uid_fkey                     | resource_calendar_attendance                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 resource_calendar_leaves_calendar_id_fkey                       | resource_calendar_leaves                                      | FOREIGN KEY (calendar_id) REFERENCES resource_calendar(id) ON DELETE SET NULL
 resource_calendar_leaves_write_uid_fkey                         | resource_calendar_leaves                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 resource_calendar_leaves_company_id_fkey                        | resource_calendar_leaves                                      | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 resource_calendar_leaves_resource_id_fkey                       | resource_calendar_leaves                                      | FOREIGN KEY (resource_id) REFERENCES resource_resource(id) ON DELETE SET NULL
 resource_calendar_leaves_pkey                                   | resource_calendar_leaves                                      | PRIMARY KEY (id)
 resource_calendar_leaves_create_uid_fkey                        | resource_calendar_leaves                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 resource_resource_write_uid_fkey                                | resource_resource                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 resource_resource_calendar_id_fkey                              | resource_resource                                             | FOREIGN KEY (calendar_id) REFERENCES resource_calendar(id) ON DELETE SET NULL
 resource_resource_user_id_fkey                                  | resource_resource                                             | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 resource_resource_company_id_fkey                               | resource_resource                                             | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 resource_resource_check_time_efficiency                         | resource_resource                                             | CHECK ((time_efficiency > (0)::double precision))
 resource_resource_pkey                                          | resource_resource                                             | PRIMARY KEY (id)
 resource_resource_create_uid_fkey                               | resource_resource                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 rule_group_rel_group_id_fkey                                    | rule_group_rel                                                | FOREIGN KEY (group_id) REFERENCES res_groups(id) ON DELETE RESTRICT
 rule_group_rel_rule_group_id_fkey                               | rule_group_rel                                                | FOREIGN KEY (rule_group_id) REFERENCES ir_rule(id) ON DELETE CASCADE
 rule_group_rel_pkey                                             | rule_group_rel                                                | PRIMARY KEY (rule_group_id, group_id)
 sale_advance_payment_inv_create_uid_fkey                        | sale_advance_payment_inv                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_advance_payment_inv_pkey                                   | sale_advance_payment_inv                                      | PRIMARY KEY (id)
 sale_advance_payment_inv_write_uid_fkey                         | sale_advance_payment_inv                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_advance_payment_inv_company_id_fkey                        | sale_advance_payment_inv                                      | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 sale_advance_payment_inv_currency_id_fkey                       | sale_advance_payment_inv                                      | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 sale_advance_payment_inv_sale_order_rel_sale_order_id_fkey      | sale_advance_payment_inv_sale_order_rel                       | FOREIGN KEY (sale_order_id) REFERENCES sale_order(id) ON DELETE CASCADE
 sale_advance_payment_inv_sale_order_rel_pkey                    | sale_advance_payment_inv_sale_order_rel                       | PRIMARY KEY (sale_advance_payment_inv_id, sale_order_id)
 sale_advance_payment_inv_sale__sale_advance_payment_inv_id_fkey | sale_advance_payment_inv_sale_order_rel                       | FOREIGN KEY (sale_advance_payment_inv_id) REFERENCES sale_advance_payment_inv(id) ON DELETE CASCADE
 sale_mass_cancel_orders_pkey                                    | sale_mass_cancel_orders                                       | PRIMARY KEY (id)
 sale_mass_cancel_orders_create_uid_fkey                         | sale_mass_cancel_orders                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_mass_cancel_orders_write_uid_fkey                          | sale_mass_cancel_orders                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_order_payment_term_id_fkey                                 | sale_order                                                    | FOREIGN KEY (payment_term_id) REFERENCES account_payment_term(id) ON DELETE SET NULL
 sale_order_fiscal_position_id_fkey                              | sale_order                                                    | FOREIGN KEY (fiscal_position_id) REFERENCES account_fiscal_position(id) ON DELETE SET NULL
 sale_order_campaign_id_fkey                                     | sale_order                                                    | FOREIGN KEY (campaign_id) REFERENCES utm_campaign(id) ON DELETE SET NULL
 sale_order_source_id_fkey                                       | sale_order                                                    | FOREIGN KEY (source_id) REFERENCES utm_source(id) ON DELETE SET NULL
 sale_order_medium_id_fkey                                       | sale_order                                                    | FOREIGN KEY (medium_id) REFERENCES utm_medium(id) ON DELETE SET NULL
 sale_order_write_uid_fkey                                       | sale_order                                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_order_create_uid_fkey                                      | sale_order                                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_order_company_id_fkey                                      | sale_order                                                    | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 sale_order_partner_id_fkey                                      | sale_order                                                    | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE RESTRICT
 sale_order_journal_id_fkey                                      | sale_order                                                    | FOREIGN KEY (journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 sale_order_partner_invoice_id_fkey                              | sale_order                                                    | FOREIGN KEY (partner_invoice_id) REFERENCES res_partner(id) ON DELETE RESTRICT
 sale_order_team_id_fkey                                         | sale_order                                                    | FOREIGN KEY (team_id) REFERENCES crm_team(id) ON DELETE SET NULL
 sale_order_user_id_fkey                                         | sale_order                                                    | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 sale_order_currency_id_fkey                                     | sale_order                                                    | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE RESTRICT
 sale_order_pricelist_id_fkey                                    | sale_order                                                    | FOREIGN KEY (pricelist_id) REFERENCES product_pricelist(id) ON DELETE SET NULL
 sale_order_pending_email_template_id_fkey                       | sale_order                                                    | FOREIGN KEY (pending_email_template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 sale_order_sale_order_template_id_fkey                          | sale_order                                                    | FOREIGN KEY (sale_order_template_id) REFERENCES sale_order_template(id) ON DELETE SET NULL
 sale_order_project_id_fkey                                      | sale_order                                                    | FOREIGN KEY (project_id) REFERENCES project_project(id) ON DELETE SET NULL
 sale_order_partner_shipping_id_fkey                             | sale_order                                                    | FOREIGN KEY (partner_shipping_id) REFERENCES res_partner(id) ON DELETE RESTRICT
 sale_order_date_order_conditional_required                      | sale_order                                                    | CHECK (((((state)::text = 'sale'::text) AND (date_order IS NOT NULL)) OR ((state)::text <> 'sale'::text)))
 sale_order_pkey                                                 | sale_order                                                    | PRIMARY KEY (id)
 sale_order_incoterm_fkey                                        | sale_order                                                    | FOREIGN KEY (incoterm) REFERENCES account_incoterms(id) ON DELETE SET NULL
 sale_order_warehouse_id_fkey                                    | sale_order                                                    | FOREIGN KEY (warehouse_id) REFERENCES stock_warehouse(id) ON DELETE SET NULL
 sale_order_procurement_group_id_fkey                            | sale_order                                                    | FOREIGN KEY (procurement_group_id) REFERENCES procurement_group(id) ON DELETE SET NULL
 sale_order_opportunity_id_fkey                                  | sale_order                                                    | FOREIGN KEY (opportunity_id) REFERENCES crm_lead(id) ON DELETE SET NULL
 sale_order_cancel_order_id_fkey                                 | sale_order_cancel                                             | FOREIGN KEY (order_id) REFERENCES sale_order(id) ON DELETE CASCADE
 sale_order_cancel_write_uid_fkey                                | sale_order_cancel                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_order_cancel_pkey                                          | sale_order_cancel                                             | PRIMARY KEY (id)
 sale_order_cancel_author_id_fkey                                | sale_order_cancel                                             | FOREIGN KEY (author_id) REFERENCES res_partner(id) ON DELETE SET NULL
 sale_order_cancel_template_id_fkey                              | sale_order_cancel                                             | FOREIGN KEY (template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 sale_order_cancel_create_uid_fkey                               | sale_order_cancel                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_order_discount_sale_order_id_fkey                          | sale_order_discount                                           | FOREIGN KEY (sale_order_id) REFERENCES sale_order(id) ON DELETE CASCADE
 sale_order_discount_write_uid_fkey                              | sale_order_discount                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_order_discount_create_uid_fkey                             | sale_order_discount                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_order_discount_pkey                                        | sale_order_discount                                           | PRIMARY KEY (id)
 sale_order_line_accountable_required_fields                     | sale_order_line                                               | CHECK (((display_type IS NOT NULL) OR is_downpayment OR ((product_id IS NOT NULL) AND (product_uom IS NOT NULL))))
 sale_order_line_pkey                                            | sale_order_line                                               | PRIMARY KEY (id)
 sale_order_line_route_id_fkey                                   | sale_order_line                                               | FOREIGN KEY (route_id) REFERENCES stock_route(id) ON DELETE RESTRICT
 sale_order_line_warehouse_id_fkey                               | sale_order_line                                               | FOREIGN KEY (warehouse_id) REFERENCES stock_warehouse(id) ON DELETE SET NULL
 sale_order_line_non_accountable_null_fields                     | sale_order_line                                               | CHECK (((display_type IS NULL) OR ((product_id IS NULL) AND (price_unit = (0)::numeric) AND (product_uom_qty = (0)::numeric) AND (product_uom IS NULL) AND (customer_lead = (0)::double precision))))
 sale_order_line_order_id_fkey                                   | sale_order_line                                               | FOREIGN KEY (order_id) REFERENCES sale_order(id) ON DELETE CASCADE
 sale_order_line_company_id_fkey                                 | sale_order_line                                               | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 sale_order_line_currency_id_fkey                                | sale_order_line                                               | FOREIGN KEY (currency_id) REFERENCES res_currency(id) ON DELETE SET NULL
 sale_order_line_order_partner_id_fkey                           | sale_order_line                                               | FOREIGN KEY (order_partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 sale_order_line_salesman_id_fkey                                | sale_order_line                                               | FOREIGN KEY (salesman_id) REFERENCES res_users(id) ON DELETE SET NULL
 sale_order_line_product_id_fkey                                 | sale_order_line                                               | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE RESTRICT
 sale_order_line_product_uom_fkey                                | sale_order_line                                               | FOREIGN KEY (product_uom) REFERENCES uom_uom(id) ON DELETE RESTRICT
 sale_order_line_linked_line_id_fkey                             | sale_order_line                                               | FOREIGN KEY (linked_line_id) REFERENCES sale_order_line(id) ON DELETE CASCADE
 sale_order_line_combo_item_id_fkey                              | sale_order_line                                               | FOREIGN KEY (combo_item_id) REFERENCES product_combo_item(id) ON DELETE SET NULL
 sale_order_line_product_packaging_id_fkey                       | sale_order_line                                               | FOREIGN KEY (product_packaging_id) REFERENCES product_packaging(id) ON DELETE SET NULL
 sale_order_line_create_uid_fkey                                 | sale_order_line                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_order_line_write_uid_fkey                                  | sale_order_line                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_order_line_project_id_fkey                                 | sale_order_line                                               | FOREIGN KEY (project_id) REFERENCES project_project(id) ON DELETE SET NULL
 sale_order_line_task_id_fkey                                    | sale_order_line                                               | FOREIGN KEY (task_id) REFERENCES project_task(id) ON DELETE SET NULL
 sale_order_line_load_id_fkey                                    | sale_order_line                                               | FOREIGN KEY (load_id) REFERENCES premafirm_load(id) ON DELETE SET NULL
 sale_order_line_invoice_rel_invoice_line_id_fkey                | sale_order_line_invoice_rel                                   | FOREIGN KEY (invoice_line_id) REFERENCES account_move_line(id) ON DELETE CASCADE
 sale_order_line_invoice_rel_order_line_id_fkey                  | sale_order_line_invoice_rel                                   | FOREIGN KEY (order_line_id) REFERENCES sale_order_line(id) ON DELETE CASCADE
 sale_order_line_invoice_rel_pkey                                | sale_order_line_invoice_rel                                   | PRIMARY KEY (invoice_line_id, order_line_id)
 sale_order_line_product_document_rel_sale_order_line_id_fkey    | sale_order_line_product_document_rel                          | FOREIGN KEY (sale_order_line_id) REFERENCES sale_order_line(id) ON DELETE CASCADE
 sale_order_line_product_document_rel_product_document_id_fkey   | sale_order_line_product_document_rel                          | FOREIGN KEY (product_document_id) REFERENCES product_document(id) ON DELETE CASCADE
 sale_order_line_product_document_rel_pkey                       | sale_order_line_product_document_rel                          | PRIMARY KEY (sale_order_line_id, product_document_id)
 sale_order_mass_cancel_wizard_rel_pkey                          | sale_order_mass_cancel_wizard_rel                             | PRIMARY KEY (sale_mass_cancel_orders_id, sale_order_id)
 sale_order_mass_cancel_wizard_r_sale_mass_cancel_orders_id_fkey | sale_order_mass_cancel_wizard_rel                             | FOREIGN KEY (sale_mass_cancel_orders_id) REFERENCES sale_mass_cancel_orders(id) ON DELETE CASCADE
 sale_order_mass_cancel_wizard_rel_sale_order_id_fkey            | sale_order_mass_cancel_wizard_rel                             | FOREIGN KEY (sale_order_id) REFERENCES sale_order(id) ON DELETE CASCADE
 sale_order_option_order_id_fkey                                 | sale_order_option                                             | FOREIGN KEY (order_id) REFERENCES sale_order(id) ON DELETE CASCADE
 sale_order_option_product_id_fkey                               | sale_order_option                                             | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE RESTRICT
 sale_order_option_line_id_fkey                                  | sale_order_option                                             | FOREIGN KEY (line_id) REFERENCES sale_order_line(id) ON DELETE SET NULL
 sale_order_option_uom_id_fkey                                   | sale_order_option                                             | FOREIGN KEY (uom_id) REFERENCES uom_uom(id) ON DELETE RESTRICT
 sale_order_option_create_uid_fkey                               | sale_order_option                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_order_option_pkey                                          | sale_order_option                                             | PRIMARY KEY (id)
 sale_order_option_write_uid_fkey                                | sale_order_option                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_order_spreadsheet_order_id_fkey                            | sale_order_spreadsheet                                        | FOREIGN KEY (order_id) REFERENCES sale_order(id) ON DELETE SET NULL
 sale_order_spreadsheet_write_uid_fkey                           | sale_order_spreadsheet                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_order_spreadsheet_pkey                                     | sale_order_spreadsheet                                        | PRIMARY KEY (id)
 sale_order_spreadsheet_company_id_fkey                          | sale_order_spreadsheet                                        | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 sale_order_spreadsheet_create_uid_fkey                          | sale_order_spreadsheet                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_order_tag_rel_order_id_fkey                                | sale_order_tag_rel                                            | FOREIGN KEY (order_id) REFERENCES sale_order(id) ON DELETE CASCADE
 sale_order_tag_rel_pkey                                         | sale_order_tag_rel                                            | PRIMARY KEY (order_id, tag_id)
 sale_order_tag_rel_tag_id_fkey                                  | sale_order_tag_rel                                            | FOREIGN KEY (tag_id) REFERENCES crm_tag(id) ON DELETE CASCADE
 sale_order_template_create_uid_fkey                             | sale_order_template                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_order_template_write_uid_fkey                              | sale_order_template                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_order_template_company_id_fkey                             | sale_order_template                                           | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 sale_order_template_mail_template_id_fkey                       | sale_order_template                                           | FOREIGN KEY (mail_template_id) REFERENCES mail_template(id) ON DELETE SET NULL
 sale_order_template_spreadsheet_template_id_fkey                | sale_order_template                                           | FOREIGN KEY (spreadsheet_template_id) REFERENCES sale_order_spreadsheet(id) ON DELETE SET NULL
 sale_order_template_pkey                                        | sale_order_template                                           | PRIMARY KEY (id)
 sale_order_template_line_product_uom_id_fkey                    | sale_order_template_line                                      | FOREIGN KEY (product_uom_id) REFERENCES uom_uom(id) ON DELETE SET NULL
 sale_order_template_line_non_accountable_fields_null            | sale_order_template_line                                      | CHECK (((display_type IS NULL) OR ((product_id IS NULL) AND (product_uom_qty = (0)::numeric) AND (product_uom_id IS NULL))))
 sale_order_template_line_write_uid_fkey                         | sale_order_template_line                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_order_template_line_create_uid_fkey                        | sale_order_template_line                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_order_template_line_accountable_product_id_required        | sale_order_template_line                                      | CHECK (((display_type IS NOT NULL) OR ((product_id IS NOT NULL) AND (product_uom_id IS NOT NULL))))
 sale_order_template_line_product_id_fkey                        | sale_order_template_line                                      | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE SET NULL
 sale_order_template_line_company_id_fkey                        | sale_order_template_line                                      | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 sale_order_template_line_sale_order_template_id_fkey            | sale_order_template_line                                      | FOREIGN KEY (sale_order_template_id) REFERENCES sale_order_template(id) ON DELETE CASCADE
 sale_order_template_line_pkey                                   | sale_order_template_line                                      | PRIMARY KEY (id)
 sale_order_template_option_sale_order_template_id_fkey          | sale_order_template_option                                    | FOREIGN KEY (sale_order_template_id) REFERENCES sale_order_template(id) ON DELETE CASCADE
 sale_order_template_option_create_uid_fkey                      | sale_order_template_option                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_order_template_option_write_uid_fkey                       | sale_order_template_option                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_order_template_option_uom_id_fkey                          | sale_order_template_option                                    | FOREIGN KEY (uom_id) REFERENCES uom_uom(id) ON DELETE RESTRICT
 sale_order_template_option_company_id_fkey                      | sale_order_template_option                                    | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 sale_order_template_option_product_id_fkey                      | sale_order_template_option                                    | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE RESTRICT
 sale_order_template_option_pkey                                 | sale_order_template_option                                    | PRIMARY KEY (id)
 sale_order_transaction_rel_pkey                                 | sale_order_transaction_rel                                    | PRIMARY KEY (transaction_id, sale_order_id)
 sale_order_transaction_rel_sale_order_id_fkey                   | sale_order_transaction_rel                                    | FOREIGN KEY (sale_order_id) REFERENCES sale_order(id) ON DELETE CASCADE
 sale_order_transaction_rel_transaction_id_fkey                  | sale_order_transaction_rel                                    | FOREIGN KEY (transaction_id) REFERENCES payment_transaction(id) ON DELETE CASCADE
 sale_payment_provider_onboarding_wizard_create_uid_fkey         | sale_payment_provider_onboarding_wizard                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_payment_provider_onboarding_wizard_pkey                    | sale_payment_provider_onboarding_wizard                       | PRIMARY KEY (id)
 sale_payment_provider_onboarding_wizard_write_uid_fkey          | sale_payment_provider_onboarding_wizard                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_pdf_form_field_create_uid_fkey                             | sale_pdf_form_field                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_pdf_form_field_write_uid_fkey                              | sale_pdf_form_field                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sale_pdf_form_field_unique_name_per_doc_type                    | sale_pdf_form_field                                           | UNIQUE (name, document_type)
 sale_pdf_form_field_pkey                                        | sale_pdf_form_field                                           | PRIMARY KEY (id)
 save_spreadsheet_template_create_uid_fkey                       | save_spreadsheet_template                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 save_spreadsheet_template_write_uid_fkey                        | save_spreadsheet_template                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 save_spreadsheet_template_pkey                                  | save_spreadsheet_template                                     | PRIMARY KEY (id)
 scheduled_message_attachment_rel_attachment_id_fkey             | scheduled_message_attachment_rel                              | FOREIGN KEY (attachment_id) REFERENCES ir_attachment(id) ON DELETE CASCADE
 scheduled_message_attachment_rel_scheduled_message_id_fkey      | scheduled_message_attachment_rel                              | FOREIGN KEY (scheduled_message_id) REFERENCES mail_scheduled_message(id) ON DELETE CASCADE
 scheduled_message_attachment_rel_pkey                           | scheduled_message_attachment_rel                              | PRIMARY KEY (scheduled_message_id, attachment_id)
 sms_account_code_write_uid_fkey                                 | sms_account_code                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_account_code_pkey                                           | sms_account_code                                              | PRIMARY KEY (id)
 sms_account_code_account_id_fkey                                | sms_account_code                                              | FOREIGN KEY (account_id) REFERENCES iap_account(id) ON DELETE CASCADE
 sms_account_code_create_uid_fkey                                | sms_account_code                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_account_phone_create_uid_fkey                               | sms_account_phone                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_account_phone_pkey                                          | sms_account_phone                                             | PRIMARY KEY (id)
 sms_account_phone_account_id_fkey                               | sms_account_phone                                             | FOREIGN KEY (account_id) REFERENCES iap_account(id) ON DELETE CASCADE
 sms_account_phone_write_uid_fkey                                | sms_account_phone                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_account_sender_pkey                                         | sms_account_sender                                            | PRIMARY KEY (id)
 sms_account_sender_create_uid_fkey                              | sms_account_sender                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_account_sender_account_id_fkey                              | sms_account_sender                                            | FOREIGN KEY (account_id) REFERENCES iap_account(id) ON DELETE CASCADE
 sms_account_sender_write_uid_fkey                               | sms_account_sender                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_composer_template_id_fkey                                   | sms_composer                                                  | FOREIGN KEY (template_id) REFERENCES sms_template(id) ON DELETE SET NULL
 sms_composer_pkey                                               | sms_composer                                                  | PRIMARY KEY (id)
 sms_composer_write_uid_fkey                                     | sms_composer                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_composer_create_uid_fkey                                    | sms_composer                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_resend_write_uid_fkey                                       | sms_resend                                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_resend_mail_message_id_fkey                                 | sms_resend                                                    | FOREIGN KEY (mail_message_id) REFERENCES mail_message(id) ON DELETE CASCADE
 sms_resend_pkey                                                 | sms_resend                                                    | PRIMARY KEY (id)
 sms_resend_create_uid_fkey                                      | sms_resend                                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_resend_recipient_sms_resend_id_fkey                         | sms_resend_recipient                                          | FOREIGN KEY (sms_resend_id) REFERENCES sms_resend(id) ON DELETE RESTRICT
 sms_resend_recipient_pkey                                       | sms_resend_recipient                                          | PRIMARY KEY (id)
 sms_resend_recipient_write_uid_fkey                             | sms_resend_recipient                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_resend_recipient_create_uid_fkey                            | sms_resend_recipient                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_resend_recipient_notification_id_fkey                       | sms_resend_recipient                                          | FOREIGN KEY (notification_id) REFERENCES mail_notification(id) ON DELETE CASCADE
 sms_sms_partner_id_fkey                                         | sms_sms                                                       | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 sms_sms_mail_message_id_fkey                                    | sms_sms                                                       | FOREIGN KEY (mail_message_id) REFERENCES mail_message(id) ON DELETE SET NULL
 sms_sms_create_uid_fkey                                         | sms_sms                                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_sms_uuid_unique                                             | sms_sms                                                       | UNIQUE (uuid)
 sms_sms_pkey                                                    | sms_sms                                                       | PRIMARY KEY (id)
 sms_sms_write_uid_fkey                                          | sms_sms                                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_template_create_uid_fkey                                    | sms_template                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_template_model_id_fkey                                      | sms_template                                                  | FOREIGN KEY (model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 sms_template_pkey                                               | sms_template                                                  | PRIMARY KEY (id)
 sms_template_write_uid_fkey                                     | sms_template                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_template_sidebar_action_id_fkey                             | sms_template                                                  | FOREIGN KEY (sidebar_action_id) REFERENCES ir_act_window(id) ON DELETE SET NULL
 sms_template_preview_write_uid_fkey                             | sms_template_preview                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_template_preview_pkey                                       | sms_template_preview                                          | PRIMARY KEY (id)
 sms_template_preview_sms_template_id_fkey                       | sms_template_preview                                          | FOREIGN KEY (sms_template_id) REFERENCES sms_template(id) ON DELETE CASCADE
 sms_template_preview_create_uid_fkey                            | sms_template_preview                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_template_reset_write_uid_fkey                               | sms_template_reset                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_template_reset_pkey                                         | sms_template_reset                                            | PRIMARY KEY (id)
 sms_template_reset_create_uid_fkey                              | sms_template_reset                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_template_sms_template_reset_rel_pkey                        | sms_template_sms_template_reset_rel                           | PRIMARY KEY (sms_template_reset_id, sms_template_id)
 sms_template_sms_template_reset_rel_sms_template_id_fkey        | sms_template_sms_template_reset_rel                           | FOREIGN KEY (sms_template_id) REFERENCES sms_template(id) ON DELETE CASCADE
 sms_template_sms_template_reset_rel_sms_template_reset_id_fkey  | sms_template_sms_template_reset_rel                           | FOREIGN KEY (sms_template_reset_id) REFERENCES sms_template_reset(id) ON DELETE CASCADE
 sms_tracker_create_uid_fkey                                     | sms_tracker                                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_tracker_write_uid_fkey                                      | sms_tracker                                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 sms_tracker_mail_notification_id_fkey                           | sms_tracker                                                   | FOREIGN KEY (mail_notification_id) REFERENCES mail_notification(id) ON DELETE CASCADE
 sms_tracker_pkey                                                | sms_tracker                                                   | PRIMARY KEY (id)
 sms_tracker_sms_uuid_unique                                     | sms_tracker                                                   | UNIQUE (sms_uuid)
 snailmail_letter_partner_id_fkey                                | snailmail_letter                                              | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE RESTRICT
 snailmail_letter_user_id_fkey                                   | snailmail_letter                                              | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 snailmail_letter_pkey                                           | snailmail_letter                                              | PRIMARY KEY (id)
 snailmail_letter_state_id_fkey                                  | snailmail_letter                                              | FOREIGN KEY (state_id) REFERENCES res_country_state(id) ON DELETE SET NULL
 snailmail_letter_message_id_fkey                                | snailmail_letter                                              | FOREIGN KEY (message_id) REFERENCES mail_message(id) ON DELETE SET NULL
 snailmail_letter_attachment_id_fkey                             | snailmail_letter                                              | FOREIGN KEY (attachment_id) REFERENCES ir_attachment(id) ON DELETE CASCADE
 snailmail_letter_report_template_fkey                           | snailmail_letter                                              | FOREIGN KEY (report_template) REFERENCES ir_act_report_xml(id) ON DELETE SET NULL
 snailmail_letter_company_id_fkey                                | snailmail_letter                                              | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 snailmail_letter_country_id_fkey                                | snailmail_letter                                              | FOREIGN KEY (country_id) REFERENCES res_country(id) ON DELETE SET NULL
 snailmail_letter_write_uid_fkey                                 | snailmail_letter                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 snailmail_letter_create_uid_fkey                                | snailmail_letter                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 snailmail_letter_format_error_pkey                              | snailmail_letter_format_error                                 | PRIMARY KEY (id)
 snailmail_letter_format_error_write_uid_fkey                    | snailmail_letter_format_error                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 snailmail_letter_format_error_create_uid_fkey                   | snailmail_letter_format_error                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 snailmail_letter_format_error_message_id_fkey                   | snailmail_letter_format_error                                 | FOREIGN KEY (message_id) REFERENCES mail_message(id) ON DELETE SET NULL
 snailmail_letter_missing_required_fields_country_id_fkey        | snailmail_letter_missing_required_fields                      | FOREIGN KEY (country_id) REFERENCES res_country(id) ON DELETE SET NULL
 snailmail_letter_missing_required_fields_state_id_fkey          | snailmail_letter_missing_required_fields                      | FOREIGN KEY (state_id) REFERENCES res_country_state(id) ON DELETE SET NULL
 snailmail_letter_missing_required_fields_letter_id_fkey         | snailmail_letter_missing_required_fields                      | FOREIGN KEY (letter_id) REFERENCES snailmail_letter(id) ON DELETE SET NULL
 snailmail_letter_missing_required_fields_create_uid_fkey        | snailmail_letter_missing_required_fields                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 snailmail_letter_missing_required_fields_write_uid_fkey         | snailmail_letter_missing_required_fields                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 snailmail_letter_missing_required_fields_pkey                   | snailmail_letter_missing_required_fields                      | PRIMARY KEY (id)
 snailmail_letter_missing_required_fields_partner_id_fkey        | snailmail_letter_missing_required_fields                      | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 spreadsheet_cell_thread_document_id_fkey                        | spreadsheet_cell_thread                                       | FOREIGN KEY (document_id) REFERENCES documents_document(id) ON DELETE CASCADE
 spreadsheet_cell_thread_write_uid_fkey                          | spreadsheet_cell_thread                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 spreadsheet_cell_thread_create_uid_fkey                         | spreadsheet_cell_thread                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 spreadsheet_cell_thread_pkey                                    | spreadsheet_cell_thread                                       | PRIMARY KEY (id)
 spreadsheet_cell_thread_sale_order_spreadsheet_id_fkey          | spreadsheet_cell_thread                                       | FOREIGN KEY (sale_order_spreadsheet_id) REFERENCES sale_order_spreadsheet(id) ON DELETE CASCADE
 spreadsheet_cell_thread_dashboard_id_fkey                       | spreadsheet_cell_thread                                       | FOREIGN KEY (dashboard_id) REFERENCES spreadsheet_dashboard(id) ON DELETE CASCADE
 spreadsheet_cell_thread_template_id_fkey                        | spreadsheet_cell_thread                                       | FOREIGN KEY (template_id) REFERENCES spreadsheet_template(id) ON DELETE CASCADE
 spreadsheet_contributor_document_id_fkey                        | spreadsheet_contributor                                       | FOREIGN KEY (document_id) REFERENCES documents_document(id) ON DELETE SET NULL
 spreadsheet_contributor_spreadsheet_user_unique                 | spreadsheet_contributor                                       | UNIQUE (document_id, user_id)
 spreadsheet_contributor_pkey                                    | spreadsheet_contributor                                       | PRIMARY KEY (id)
 spreadsheet_contributor_write_uid_fkey                          | spreadsheet_contributor                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 spreadsheet_contributor_create_uid_fkey                         | spreadsheet_contributor                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 spreadsheet_contributor_user_id_fkey                            | spreadsheet_contributor                                       | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 spreadsheet_dashboard_create_uid_fkey                           | spreadsheet_dashboard                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 spreadsheet_dashboard_dashboard_group_id_fkey                   | spreadsheet_dashboard                                         | FOREIGN KEY (dashboard_group_id) REFERENCES spreadsheet_dashboard_group(id) ON DELETE RESTRICT
 spreadsheet_dashboard_pkey                                      | spreadsheet_dashboard                                         | PRIMARY KEY (id)
 spreadsheet_dashboard_company_id_fkey                           | spreadsheet_dashboard                                         | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 spreadsheet_dashboard_write_uid_fkey                            | spreadsheet_dashboard                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 spreadsheet_dashboard_group_pkey                                | spreadsheet_dashboard_group                                   | PRIMARY KEY (id)
 spreadsheet_dashboard_group_write_uid_fkey                      | spreadsheet_dashboard_group                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 spreadsheet_dashboard_group_create_uid_fkey                     | spreadsheet_dashboard_group                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 spreadsheet_dashboard_share_dashboard_id_fkey                   | spreadsheet_dashboard_share                                   | FOREIGN KEY (dashboard_id) REFERENCES spreadsheet_dashboard(id) ON DELETE CASCADE
 spreadsheet_dashboard_share_create_uid_fkey                     | spreadsheet_dashboard_share                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 spreadsheet_dashboard_share_pkey                                | spreadsheet_dashboard_share                                   | PRIMARY KEY (id)
 spreadsheet_dashboard_share_write_uid_fkey                      | spreadsheet_dashboard_share                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 spreadsheet_document_to_dashboard_create_uid_fkey               | spreadsheet_document_to_dashboard                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 spreadsheet_document_to_dashboard_write_uid_fkey                | spreadsheet_document_to_dashboard                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 spreadsheet_document_to_dashboard_dashboard_group_id_fkey       | spreadsheet_document_to_dashboard                             | FOREIGN KEY (dashboard_group_id) REFERENCES spreadsheet_dashboard_group(id) ON DELETE CASCADE
 spreadsheet_document_to_dashboard_document_id_fkey              | spreadsheet_document_to_dashboard                             | FOREIGN KEY (document_id) REFERENCES documents_document(id) ON DELETE CASCADE
 spreadsheet_document_to_dashboard_pkey                          | spreadsheet_document_to_dashboard                             | PRIMARY KEY (id)
 spreadsheet_revision_pkey                                       | spreadsheet_revision                                          | PRIMARY KEY (id)
 spreadsheet_revision_parent_revision_id_fkey                    | spreadsheet_revision                                          | FOREIGN KEY (parent_revision_id) REFERENCES spreadsheet_revision(id) ON DELETE SET NULL
 spreadsheet_revision_write_uid_fkey                             | spreadsheet_revision                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 spreadsheet_revision_create_uid_fkey                            | spreadsheet_revision                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 spreadsheet_template_pkey                                       | spreadsheet_template                                          | PRIMARY KEY (id)
 spreadsheet_template_write_uid_fkey                             | spreadsheet_template                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 spreadsheet_template_create_uid_fkey                            | spreadsheet_template                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_add_to_wave_pkey                                          | stock_add_to_wave                                             | PRIMARY KEY (id)
 stock_add_to_wave_user_id_fkey                                  | stock_add_to_wave                                             | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 stock_add_to_wave_create_uid_fkey                               | stock_add_to_wave                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_add_to_wave_write_uid_fkey                                | stock_add_to_wave                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_add_to_wave_wave_id_fkey                                  | stock_add_to_wave                                             | FOREIGN KEY (wave_id) REFERENCES stock_picking_batch(id) ON DELETE SET NULL
 stock_add_to_wave_stock_move_line_rel_stock_move_line_id_fkey   | stock_add_to_wave_stock_move_line_rel                         | FOREIGN KEY (stock_move_line_id) REFERENCES stock_move_line(id) ON DELETE CASCADE
 stock_add_to_wave_stock_move_line_rel_pkey                      | stock_add_to_wave_stock_move_line_rel                         | PRIMARY KEY (stock_add_to_wave_id, stock_move_line_id)
 stock_add_to_wave_stock_move_line_rel_stock_add_to_wave_id_fkey | stock_add_to_wave_stock_move_line_rel                         | FOREIGN KEY (stock_add_to_wave_id) REFERENCES stock_add_to_wave(id) ON DELETE CASCADE
 stock_add_to_wave_stock_picking_rel_pkey                        | stock_add_to_wave_stock_picking_rel                           | PRIMARY KEY (stock_add_to_wave_id, stock_picking_id)
 stock_add_to_wave_stock_picking_rel_stock_add_to_wave_id_fkey   | stock_add_to_wave_stock_picking_rel                           | FOREIGN KEY (stock_add_to_wave_id) REFERENCES stock_add_to_wave(id) ON DELETE CASCADE
 stock_add_to_wave_stock_picking_rel_stock_picking_id_fkey       | stock_add_to_wave_stock_picking_rel                           | FOREIGN KEY (stock_picking_id) REFERENCES stock_picking(id) ON DELETE CASCADE
 stock_backorder_confirmation_write_uid_fkey                     | stock_backorder_confirmation                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_backorder_confirmation_create_uid_fkey                    | stock_backorder_confirmation                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_backorder_confirmation_pkey                               | stock_backorder_confirmation                                  | PRIMARY KEY (id)
 stock_backorder_confirmation_line_picking_id_fkey               | stock_backorder_confirmation_line                             | FOREIGN KEY (picking_id) REFERENCES stock_picking(id) ON DELETE SET NULL
 stock_backorder_confirmation_line_write_uid_fkey                | stock_backorder_confirmation_line                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_backorder_confirmation_line_create_uid_fkey               | stock_backorder_confirmation_line                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_backorder_confirmation_lin_backorder_confirmation_id_fkey | stock_backorder_confirmation_line                             | FOREIGN KEY (backorder_confirmation_id) REFERENCES stock_backorder_confirmation(id) ON DELETE SET NULL
 stock_backorder_confirmation_line_pkey                          | stock_backorder_confirmation_line                             | PRIMARY KEY (id)
 stock_barcode_cancel_operation_write_uid_fkey                   | stock_barcode_cancel_operation                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_barcode_cancel_operation_create_uid_fkey                  | stock_barcode_cancel_operation                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_barcode_cancel_operation_picking_id_fkey                  | stock_barcode_cancel_operation                                | FOREIGN KEY (picking_id) REFERENCES stock_picking(id) ON DELETE SET NULL
 stock_barcode_cancel_operation_pkey                             | stock_barcode_cancel_operation                                | PRIMARY KEY (id)
 stock_barcode_cancel_operation_batch_id_fkey                    | stock_barcode_cancel_operation                                | FOREIGN KEY (batch_id) REFERENCES stock_picking_batch(id) ON DELETE SET NULL
 stock_change_product_qty_create_uid_fkey                        | stock_change_product_qty                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_change_product_qty_product_tmpl_id_fkey                   | stock_change_product_qty                                      | FOREIGN KEY (product_tmpl_id) REFERENCES product_template(id) ON DELETE CASCADE
 stock_change_product_qty_product_id_fkey                        | stock_change_product_qty                                      | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE CASCADE
 stock_change_product_qty_pkey                                   | stock_change_product_qty                                      | PRIMARY KEY (id)
 stock_change_product_qty_write_uid_fkey                         | stock_change_product_qty                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_conflict_quant_rel_stock_quant_id_fkey                    | stock_conflict_quant_rel                                      | FOREIGN KEY (stock_quant_id) REFERENCES stock_quant(id) ON DELETE CASCADE
 stock_conflict_quant_rel_stock_inventory_conflict_id_fkey       | stock_conflict_quant_rel                                      | FOREIGN KEY (stock_inventory_conflict_id) REFERENCES stock_inventory_conflict(id) ON DELETE CASCADE
 stock_conflict_quant_rel_pkey                                   | stock_conflict_quant_rel                                      | PRIMARY KEY (stock_inventory_conflict_id, stock_quant_id)
 stock_inventory_adjustment_name_pkey                            | stock_inventory_adjustment_name                               | PRIMARY KEY (id)
 stock_inventory_adjustment_name_create_uid_fkey                 | stock_inventory_adjustment_name                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_inventory_adjustment_name_write_uid_fkey                  | stock_inventory_adjustment_name                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_inventory_adjustment_name_stock_quant_stock_quant_id_fkey | stock_inventory_adjustment_name_stock_quant_rel               | FOREIGN KEY (stock_quant_id) REFERENCES stock_quant(id) ON DELETE CASCADE
 stock_inventory_adjustment_name_stock_quant_rel_pkey            | stock_inventory_adjustment_name_stock_quant_rel               | PRIMARY KEY (stock_inventory_adjustment_name_id, stock_quant_id)
 stock_inventory_adjustment_na_stock_inventory_adjustment_n_fkey | stock_inventory_adjustment_name_stock_quant_rel               | FOREIGN KEY (stock_inventory_adjustment_name_id) REFERENCES stock_inventory_adjustment_name(id) ON DELETE CASCADE
 stock_inventory_conflict_create_uid_fkey                        | stock_inventory_conflict                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_inventory_conflict_pkey                                   | stock_inventory_conflict                                      | PRIMARY KEY (id)
 stock_inventory_conflict_write_uid_fkey                         | stock_inventory_conflict                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_inventory_conflict_stock_quant_rel_stock_quant_id_fkey    | stock_inventory_conflict_stock_quant_rel                      | FOREIGN KEY (stock_quant_id) REFERENCES stock_quant(id) ON DELETE CASCADE
 stock_inventory_conflict_stock_stock_inventory_conflict_id_fkey | stock_inventory_conflict_stock_quant_rel                      | FOREIGN KEY (stock_inventory_conflict_id) REFERENCES stock_inventory_conflict(id) ON DELETE CASCADE
 stock_inventory_conflict_stock_quant_rel_pkey                   | stock_inventory_conflict_stock_quant_rel                      | PRIMARY KEY (stock_inventory_conflict_id, stock_quant_id)
 stock_inventory_warning_create_uid_fkey                         | stock_inventory_warning                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_inventory_warning_write_uid_fkey                          | stock_inventory_warning                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_inventory_warning_pkey                                    | stock_inventory_warning                                       | PRIMARY KEY (id)
 stock_inventory_warning_stock_quant_rel_pkey                    | stock_inventory_warning_stock_quant_rel                       | PRIMARY KEY (stock_inventory_warning_id, stock_quant_id)
 stock_inventory_warning_stock_q_stock_inventory_warning_id_fkey | stock_inventory_warning_stock_quant_rel                       | FOREIGN KEY (stock_inventory_warning_id) REFERENCES stock_inventory_warning(id) ON DELETE CASCADE
 stock_inventory_warning_stock_quant_rel_stock_quant_id_fkey     | stock_inventory_warning_stock_quant_rel                       | FOREIGN KEY (stock_quant_id) REFERENCES stock_quant(id) ON DELETE CASCADE
 stock_location_barcode_company_uniq                             | stock_location                                                | UNIQUE (barcode, company_id)
 stock_location_inventory_freq_nonneg                            | stock_location                                                | CHECK ((cyclic_inventory_frequency >= 0))
 stock_location_pkey                                             | stock_location                                                | PRIMARY KEY (id)
 stock_location_company_id_fkey                                  | stock_location                                                | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 stock_location_removal_strategy_id_fkey                         | stock_location                                                | FOREIGN KEY (removal_strategy_id) REFERENCES product_removal(id) ON DELETE SET NULL
 stock_location_warehouse_id_fkey                                | stock_location                                                | FOREIGN KEY (warehouse_id) REFERENCES stock_warehouse(id) ON DELETE SET NULL
 stock_location_storage_category_id_fkey                         | stock_location                                                | FOREIGN KEY (storage_category_id) REFERENCES stock_storage_category(id) ON DELETE SET NULL
 stock_location_create_uid_fkey                                  | stock_location                                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_location_write_uid_fkey                                   | stock_location                                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_location_valuation_in_account_id_fkey                     | stock_location                                                | FOREIGN KEY (valuation_in_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 stock_location_valuation_out_account_id_fkey                    | stock_location                                                | FOREIGN KEY (valuation_out_account_id) REFERENCES account_account(id) ON DELETE SET NULL
 stock_location_location_id_fkey                                 | stock_location                                                | FOREIGN KEY (location_id) REFERENCES stock_location(id) ON DELETE SET NULL
 stock_location_stock_picking_type_re_stock_picking_type_id_fkey | stock_location_stock_picking_type_rel                         | FOREIGN KEY (stock_picking_type_id) REFERENCES stock_picking_type(id) ON DELETE CASCADE
 stock_location_stock_picking_type_rel_pkey                      | stock_location_stock_picking_type_rel                         | PRIMARY KEY (stock_picking_type_id, stock_location_id)
 stock_location_stock_picking_type_rel_stock_location_id_fkey    | stock_location_stock_picking_type_rel                         | FOREIGN KEY (stock_location_id) REFERENCES stock_location(id) ON DELETE CASCADE
 stock_lot_pkey                                                  | stock_lot                                                     | PRIMARY KEY (id)
 stock_lot_product_uom_id_fkey                                   | stock_lot                                                     | FOREIGN KEY (product_uom_id) REFERENCES uom_uom(id) ON DELETE SET NULL
 stock_lot_product_id_fkey                                       | stock_lot                                                     | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE RESTRICT
 stock_lot_location_id_fkey                                      | stock_lot                                                     | FOREIGN KEY (location_id) REFERENCES stock_location(id) ON DELETE SET NULL
 stock_lot_company_id_fkey                                       | stock_lot                                                     | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 stock_lot_write_uid_fkey                                        | stock_lot                                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_lot_create_uid_fkey                                       | stock_lot                                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_move_group_id_fkey                                        | stock_move                                                    | FOREIGN KEY (group_id) REFERENCES procurement_group(id) ON DELETE SET NULL
 stock_move_byproduct_id_fkey                                    | stock_move                                                    | FOREIGN KEY (byproduct_id) REFERENCES mrp_bom_byproduct(id) ON DELETE SET NULL
 stock_move_bom_line_id_fkey                                     | stock_move                                                    | FOREIGN KEY (bom_line_id) REFERENCES mrp_bom_line(id) ON DELETE SET NULL
 stock_move_workorder_id_fkey                                    | stock_move                                                    | FOREIGN KEY (workorder_id) REFERENCES mrp_workorder(id) ON DELETE SET NULL
 stock_move_operation_id_fkey                                    | stock_move                                                    | FOREIGN KEY (operation_id) REFERENCES mrp_routing_workcenter(id) ON DELETE SET NULL
 stock_move_consume_unbuild_id_fkey                              | stock_move                                                    | FOREIGN KEY (consume_unbuild_id) REFERENCES mrp_unbuild(id) ON DELETE SET NULL
 stock_move_unbuild_id_fkey                                      | stock_move                                                    | FOREIGN KEY (unbuild_id) REFERENCES mrp_unbuild(id) ON DELETE SET NULL
 stock_move_raw_material_production_id_fkey                      | stock_move                                                    | FOREIGN KEY (raw_material_production_id) REFERENCES mrp_production(id) ON DELETE SET NULL
 stock_move_production_id_fkey                                   | stock_move                                                    | FOREIGN KEY (production_id) REFERENCES mrp_production(id) ON DELETE SET NULL
 stock_move_created_production_id_fkey                           | stock_move                                                    | FOREIGN KEY (created_production_id) REFERENCES mrp_production(id) ON DELETE SET NULL
 stock_move_company_id_fkey                                      | stock_move                                                    | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 stock_move_product_id_fkey                                      | stock_move                                                    | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE RESTRICT
 stock_move_product_uom_fkey                                     | stock_move                                                    | FOREIGN KEY (product_uom) REFERENCES uom_uom(id) ON DELETE RESTRICT
 stock_move_location_id_fkey                                     | stock_move                                                    | FOREIGN KEY (location_id) REFERENCES stock_location(id) ON DELETE RESTRICT
 stock_move_location_dest_id_fkey                                | stock_move                                                    | FOREIGN KEY (location_dest_id) REFERENCES stock_location(id) ON DELETE RESTRICT
 stock_move_location_final_id_fkey                               | stock_move                                                    | FOREIGN KEY (location_final_id) REFERENCES stock_location(id) ON DELETE SET NULL
 stock_move_partner_id_fkey                                      | stock_move                                                    | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 stock_move_picking_id_fkey                                      | stock_move                                                    | FOREIGN KEY (picking_id) REFERENCES stock_picking(id) ON DELETE SET NULL
 stock_move_scrap_id_fkey                                        | stock_move                                                    | FOREIGN KEY (scrap_id) REFERENCES stock_scrap(id) ON DELETE SET NULL
 stock_move_rule_id_fkey                                         | stock_move                                                    | FOREIGN KEY (rule_id) REFERENCES stock_rule(id) ON DELETE RESTRICT
 stock_move_picking_type_id_fkey                                 | stock_move                                                    | FOREIGN KEY (picking_type_id) REFERENCES stock_picking_type(id) ON DELETE SET NULL
 stock_move_origin_returned_move_id_fkey                         | stock_move                                                    | FOREIGN KEY (origin_returned_move_id) REFERENCES stock_move(id) ON DELETE SET NULL
 stock_move_restrict_partner_id_fkey                             | stock_move                                                    | FOREIGN KEY (restrict_partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 stock_move_warehouse_id_fkey                                    | stock_move                                                    | FOREIGN KEY (warehouse_id) REFERENCES stock_warehouse(id) ON DELETE SET NULL
 stock_move_package_level_id_fkey                                | stock_move                                                    | FOREIGN KEY (package_level_id) REFERENCES stock_package_level(id) ON DELETE SET NULL
 stock_move_orderpoint_id_fkey                                   | stock_move                                                    | FOREIGN KEY (orderpoint_id) REFERENCES stock_warehouse_orderpoint(id) ON DELETE SET NULL
 stock_move_product_packaging_id_fkey                            | stock_move                                                    | FOREIGN KEY (product_packaging_id) REFERENCES product_packaging(id) ON DELETE SET NULL
 stock_move_create_uid_fkey                                      | stock_move                                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_move_write_uid_fkey                                       | stock_move                                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_move_pkey                                                 | stock_move                                                    | PRIMARY KEY (id)
 stock_move_order_finished_lot_id_fkey                           | stock_move                                                    | FOREIGN KEY (order_finished_lot_id) REFERENCES stock_lot(id) ON DELETE SET NULL
 stock_move_sale_line_id_fkey                                    | stock_move                                                    | FOREIGN KEY (sale_line_id) REFERENCES sale_order_line(id) ON DELETE SET NULL
 stock_move_purchase_line_id_fkey                                | stock_move                                                    | FOREIGN KEY (purchase_line_id) REFERENCES purchase_order_line(id) ON DELETE SET NULL
 stock_move_created_purchase_line_rel_pkey                       | stock_move_created_purchase_line_rel                          | PRIMARY KEY (created_purchase_line_id, move_id)
 stock_move_created_purchase_line__created_purchase_line_id_fkey | stock_move_created_purchase_line_rel                          | FOREIGN KEY (created_purchase_line_id) REFERENCES purchase_order_line(id) ON DELETE CASCADE
 stock_move_created_purchase_line_rel_move_id_fkey               | stock_move_created_purchase_line_rel                          | FOREIGN KEY (move_id) REFERENCES stock_move(id) ON DELETE CASCADE
 stock_move_line_workorder_id_fkey                               | stock_move_line                                               | FOREIGN KEY (workorder_id) REFERENCES mrp_workorder(id) ON DELETE SET NULL
 stock_move_line_production_id_fkey                              | stock_move_line                                               | FOREIGN KEY (production_id) REFERENCES mrp_production(id) ON DELETE SET NULL
 stock_move_line_pkey                                            | stock_move_line                                               | PRIMARY KEY (id)
 stock_move_line_picking_id_fkey                                 | stock_move_line                                               | FOREIGN KEY (picking_id) REFERENCES stock_picking(id) ON DELETE SET NULL
 stock_move_line_move_id_fkey                                    | stock_move_line                                               | FOREIGN KEY (move_id) REFERENCES stock_move(id) ON DELETE SET NULL
 stock_move_line_company_id_fkey                                 | stock_move_line                                               | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 stock_move_line_product_id_fkey                                 | stock_move_line                                               | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE CASCADE
 stock_move_line_product_uom_id_fkey                             | stock_move_line                                               | FOREIGN KEY (product_uom_id) REFERENCES uom_uom(id) ON DELETE RESTRICT
 stock_move_line_package_id_fkey                                 | stock_move_line                                               | FOREIGN KEY (package_id) REFERENCES stock_quant_package(id) ON DELETE RESTRICT
 stock_move_line_package_level_id_fkey                           | stock_move_line                                               | FOREIGN KEY (package_level_id) REFERENCES stock_package_level(id) ON DELETE SET NULL
 stock_move_line_lot_id_fkey                                     | stock_move_line                                               | FOREIGN KEY (lot_id) REFERENCES stock_lot(id) ON DELETE SET NULL
 stock_move_line_result_package_id_fkey                          | stock_move_line                                               | FOREIGN KEY (result_package_id) REFERENCES stock_quant_package(id) ON DELETE RESTRICT
 stock_move_line_owner_id_fkey                                   | stock_move_line                                               | FOREIGN KEY (owner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 stock_move_line_location_id_fkey                                | stock_move_line                                               | FOREIGN KEY (location_id) REFERENCES stock_location(id) ON DELETE RESTRICT
 stock_move_line_create_uid_fkey                                 | stock_move_line                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_move_line_location_dest_id_fkey                           | stock_move_line                                               | FOREIGN KEY (location_dest_id) REFERENCES stock_location(id) ON DELETE RESTRICT
 stock_move_line_batch_id_fkey                                   | stock_move_line                                               | FOREIGN KEY (batch_id) REFERENCES stock_picking_batch(id) ON DELETE SET NULL
 stock_move_line_write_uid_fkey                                  | stock_move_line                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_move_line_consume_rel_consume_line_id_fkey                | stock_move_line_consume_rel                                   | FOREIGN KEY (consume_line_id) REFERENCES stock_move_line(id) ON DELETE CASCADE
 stock_move_line_consume_rel_pkey                                | stock_move_line_consume_rel                                   | PRIMARY KEY (consume_line_id, produce_line_id)
 stock_move_line_consume_rel_produce_line_id_fkey                | stock_move_line_consume_rel                                   | FOREIGN KEY (produce_line_id) REFERENCES stock_move_line(id) ON DELETE CASCADE
 stock_move_move_rel_move_orig_id_fkey                           | stock_move_move_rel                                           | FOREIGN KEY (move_orig_id) REFERENCES stock_move(id) ON DELETE CASCADE
 stock_move_move_rel_pkey                                        | stock_move_move_rel                                           | PRIMARY KEY (move_orig_id, move_dest_id)
 stock_move_move_rel_move_dest_id_fkey                           | stock_move_move_rel                                           | FOREIGN KEY (move_dest_id) REFERENCES stock_move(id) ON DELETE CASCADE
 stock_orderpoint_snooze_write_uid_fkey                          | stock_orderpoint_snooze                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_orderpoint_snooze_pkey                                    | stock_orderpoint_snooze                                       | PRIMARY KEY (id)
 stock_orderpoint_snooze_create_uid_fkey                         | stock_orderpoint_snooze                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_orderpoint_snooze_stock_warehouse_orderpoint_rel_pkey     | stock_orderpoint_snooze_stock_warehouse_orderpoint_rel        | PRIMARY KEY (stock_orderpoint_snooze_id, stock_warehouse_orderpoint_id)
 stock_orderpoint_snooze_stock_w_stock_orderpoint_snooze_id_fkey | stock_orderpoint_snooze_stock_warehouse_orderpoint_rel        | FOREIGN KEY (stock_orderpoint_snooze_id) REFERENCES stock_orderpoint_snooze(id) ON DELETE CASCADE
 stock_orderpoint_snooze_stock_stock_warehouse_orderpoint_i_fkey | stock_orderpoint_snooze_stock_warehouse_orderpoint_rel        | FOREIGN KEY (stock_warehouse_orderpoint_id) REFERENCES stock_warehouse_orderpoint(id) ON DELETE CASCADE
 stock_package_destination_picking_id_fkey                       | stock_package_destination                                     | FOREIGN KEY (picking_id) REFERENCES stock_picking(id) ON DELETE CASCADE
 stock_package_destination_create_uid_fkey                       | stock_package_destination                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_package_destination_write_uid_fkey                        | stock_package_destination                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_package_destination_location_dest_id_fkey                 | stock_package_destination                                     | FOREIGN KEY (location_dest_id) REFERENCES stock_location(id) ON DELETE CASCADE
 stock_package_destination_pkey                                  | stock_package_destination                                     | PRIMARY KEY (id)
 stock_package_level_location_dest_id_fkey                       | stock_package_level                                           | FOREIGN KEY (location_dest_id) REFERENCES stock_location(id) ON DELETE SET NULL
 stock_package_level_picking_id_fkey                             | stock_package_level                                           | FOREIGN KEY (picking_id) REFERENCES stock_picking(id) ON DELETE SET NULL
 stock_package_level_package_id_fkey                             | stock_package_level                                           | FOREIGN KEY (package_id) REFERENCES stock_quant_package(id) ON DELETE RESTRICT
 stock_package_level_pkey                                        | stock_package_level                                           | PRIMARY KEY (id)
 stock_package_level_create_uid_fkey                             | stock_package_level                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_package_level_write_uid_fkey                              | stock_package_level                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_package_level_company_id_fkey                             | stock_package_level                                           | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 stock_package_type_positive_max_weight                          | stock_package_type                                            | CHECK ((max_weight >= (0.0)::double precision))
 stock_package_type_company_id_fkey                              | stock_package_type                                            | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 stock_package_type_barcode_uniq                                 | stock_package_type                                            | UNIQUE (barcode)
 stock_package_type_pkey                                         | stock_package_type                                            | PRIMARY KEY (id)
 stock_package_type_create_uid_fkey                              | stock_package_type                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_package_type_positive_length                              | stock_package_type                                            | CHECK ((packaging_length >= (0.0)::double precision))
 stock_package_type_positive_width                               | stock_package_type                                            | CHECK ((width >= (0.0)::double precision))
 stock_package_type_positive_height                              | stock_package_type                                            | CHECK ((height >= (0.0)::double precision))
 stock_package_type_write_uid_fkey                               | stock_package_type                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_package_type_stock_putaway_rule_rel_pkey                  | stock_package_type_stock_putaway_rule_rel                     | PRIMARY KEY (stock_putaway_rule_id, stock_package_type_id)
 stock_package_type_stock_putaway_rul_stock_package_type_id_fkey | stock_package_type_stock_putaway_rule_rel                     | FOREIGN KEY (stock_package_type_id) REFERENCES stock_package_type(id) ON DELETE CASCADE
 stock_package_type_stock_putaway_rul_stock_putaway_rule_id_fkey | stock_package_type_stock_putaway_rule_rel                     | FOREIGN KEY (stock_putaway_rule_id) REFERENCES stock_putaway_rule(id) ON DELETE CASCADE
 stock_picking_backorder_id_fkey                                 | stock_picking                                                 | FOREIGN KEY (backorder_id) REFERENCES stock_picking(id) ON DELETE SET NULL
 stock_picking_project_id_fkey                                   | stock_picking                                                 | FOREIGN KEY (project_id) REFERENCES project_project(id) ON DELETE SET NULL
 stock_picking_batch_id_fkey                                     | stock_picking                                                 | FOREIGN KEY (batch_id) REFERENCES stock_picking_batch(id) ON DELETE SET NULL
 stock_picking_name_uniq                                         | stock_picking                                                 | UNIQUE (name, company_id)
 stock_picking_pkey                                              | stock_picking                                                 | PRIMARY KEY (id)
 stock_picking_sale_id_fkey                                      | stock_picking                                                 | FOREIGN KEY (sale_id) REFERENCES sale_order(id) ON DELETE SET NULL
 stock_picking_return_id_fkey                                    | stock_picking                                                 | FOREIGN KEY (return_id) REFERENCES stock_picking(id) ON DELETE SET NULL
 stock_picking_group_id_fkey                                     | stock_picking                                                 | FOREIGN KEY (group_id) REFERENCES procurement_group(id) ON DELETE SET NULL
 stock_picking_location_id_fkey                                  | stock_picking                                                 | FOREIGN KEY (location_id) REFERENCES stock_location(id) ON DELETE RESTRICT
 stock_picking_location_dest_id_fkey                             | stock_picking                                                 | FOREIGN KEY (location_dest_id) REFERENCES stock_location(id) ON DELETE RESTRICT
 stock_picking_picking_type_id_fkey                              | stock_picking                                                 | FOREIGN KEY (picking_type_id) REFERENCES stock_picking_type(id) ON DELETE RESTRICT
 stock_picking_partner_id_fkey                                   | stock_picking                                                 | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 stock_picking_company_id_fkey                                   | stock_picking                                                 | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 stock_picking_user_id_fkey                                      | stock_picking                                                 | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 stock_picking_owner_id_fkey                                     | stock_picking                                                 | FOREIGN KEY (owner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 stock_picking_create_uid_fkey                                   | stock_picking                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_picking_write_uid_fkey                                    | stock_picking                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_picking_backorder_rel_stock_backorder_confirmation_i_fkey | stock_picking_backorder_rel                                   | FOREIGN KEY (stock_backorder_confirmation_id) REFERENCES stock_backorder_confirmation(id) ON DELETE CASCADE
 stock_picking_backorder_rel_pkey                                | stock_picking_backorder_rel                                   | PRIMARY KEY (stock_backorder_confirmation_id, stock_picking_id)
 stock_picking_backorder_rel_stock_picking_id_fkey               | stock_picking_backorder_rel                                   | FOREIGN KEY (stock_picking_id) REFERENCES stock_picking(id) ON DELETE CASCADE
 stock_picking_batch_write_uid_fkey                              | stock_picking_batch                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_picking_batch_pkey                                        | stock_picking_batch                                           | PRIMARY KEY (id)
 stock_picking_batch_company_id_fkey                             | stock_picking_batch                                           | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 stock_picking_batch_picking_type_id_fkey                        | stock_picking_batch                                           | FOREIGN KEY (picking_type_id) REFERENCES stock_picking_type(id) ON DELETE SET NULL
 stock_picking_batch_create_uid_fkey                             | stock_picking_batch                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_picking_batch_vehicle_id_fkey                             | stock_picking_batch                                           | FOREIGN KEY (vehicle_id) REFERENCES fleet_vehicle(id) ON DELETE SET NULL
 stock_picking_batch_vehicle_category_id_fkey                    | stock_picking_batch                                           | FOREIGN KEY (vehicle_category_id) REFERENCES fleet_vehicle_model_category(id) ON DELETE SET NULL
 stock_picking_batch_dock_id_fkey                                | stock_picking_batch                                           | FOREIGN KEY (dock_id) REFERENCES stock_location(id) ON DELETE SET NULL
 stock_picking_batch_driver_id_fkey                              | stock_picking_batch                                           | FOREIGN KEY (driver_id) REFERENCES res_partner(id) ON DELETE SET NULL
 stock_picking_batch_user_id_fkey                                | stock_picking_batch                                           | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 stock_picking_sms_rel_confirm_stock_sms_id_fkey                 | stock_picking_sms_rel                                         | FOREIGN KEY (confirm_stock_sms_id) REFERENCES confirm_stock_sms(id) ON DELETE CASCADE
 stock_picking_sms_rel_stock_picking_id_fkey                     | stock_picking_sms_rel                                         | FOREIGN KEY (stock_picking_id) REFERENCES stock_picking(id) ON DELETE CASCADE
 stock_picking_sms_rel_pkey                                      | stock_picking_sms_rel                                         | PRIMARY KEY (confirm_stock_sms_id, stock_picking_id)
 stock_picking_to_batch_user_id_fkey                             | stock_picking_to_batch                                        | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 stock_picking_to_batch_create_uid_fkey                          | stock_picking_to_batch                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_picking_to_batch_write_uid_fkey                           | stock_picking_to_batch                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_picking_to_batch_batch_id_fkey                            | stock_picking_to_batch                                        | FOREIGN KEY (batch_id) REFERENCES stock_picking_batch(id) ON DELETE SET NULL
 stock_picking_to_batch_pkey                                     | stock_picking_to_batch                                        | PRIMARY KEY (id)
 stock_picking_type_default_location_src_id_fkey                 | stock_picking_type                                            | FOREIGN KEY (default_location_src_id) REFERENCES stock_location(id) ON DELETE RESTRICT
 stock_picking_type_write_uid_fkey                               | stock_picking_type                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_picking_type_create_uid_fkey                              | stock_picking_type                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_picking_type_company_id_fkey                              | stock_picking_type                                            | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 stock_picking_type_warehouse_id_fkey                            | stock_picking_type                                            | FOREIGN KEY (warehouse_id) REFERENCES stock_warehouse(id) ON DELETE CASCADE
 stock_picking_type_pkey                                         | stock_picking_type                                            | PRIMARY KEY (id)
 stock_picking_type_return_picking_type_id_fkey                  | stock_picking_type                                            | FOREIGN KEY (return_picking_type_id) REFERENCES stock_picking_type(id) ON DELETE SET NULL
 stock_picking_type_default_location_dest_id_fkey                | stock_picking_type                                            | FOREIGN KEY (default_location_dest_id) REFERENCES stock_location(id) ON DELETE RESTRICT
 stock_picking_type_sequence_id_fkey                             | stock_picking_type                                            | FOREIGN KEY (sequence_id) REFERENCES ir_sequence(id) ON DELETE SET NULL
 stock_putaway_rule_write_uid_fkey                               | stock_putaway_rule                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_putaway_rule_pkey                                         | stock_putaway_rule                                            | PRIMARY KEY (id)
 stock_putaway_rule_create_uid_fkey                              | stock_putaway_rule                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_putaway_rule_storage_category_id_fkey                     | stock_putaway_rule                                            | FOREIGN KEY (storage_category_id) REFERENCES stock_storage_category(id) ON DELETE CASCADE
 stock_putaway_rule_company_id_fkey                              | stock_putaway_rule                                            | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 stock_putaway_rule_location_out_id_fkey                         | stock_putaway_rule                                            | FOREIGN KEY (location_out_id) REFERENCES stock_location(id) ON DELETE CASCADE
 stock_putaway_rule_location_in_id_fkey                          | stock_putaway_rule                                            | FOREIGN KEY (location_in_id) REFERENCES stock_location(id) ON DELETE CASCADE
 stock_putaway_rule_category_id_fkey                             | stock_putaway_rule                                            | FOREIGN KEY (category_id) REFERENCES product_category(id) ON DELETE CASCADE
 stock_putaway_rule_product_id_fkey                              | stock_putaway_rule                                            | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE CASCADE
 stock_quant_write_uid_fkey                                      | stock_quant                                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_quant_user_id_fkey                                        | stock_quant                                                   | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 stock_quant_owner_id_fkey                                       | stock_quant                                                   | FOREIGN KEY (owner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 stock_quant_package_id_fkey                                     | stock_quant                                                   | FOREIGN KEY (package_id) REFERENCES stock_quant_package(id) ON DELETE RESTRICT
 stock_quant_location_id_fkey                                    | stock_quant                                                   | FOREIGN KEY (location_id) REFERENCES stock_location(id) ON DELETE RESTRICT
 stock_quant_company_id_fkey                                     | stock_quant                                                   | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 stock_quant_product_id_fkey                                     | stock_quant                                                   | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE RESTRICT
 stock_quant_storage_category_id_fkey                            | stock_quant                                                   | FOREIGN KEY (storage_category_id) REFERENCES stock_storage_category(id) ON DELETE SET NULL
 stock_quant_pkey                                                | stock_quant                                                   | PRIMARY KEY (id)
 stock_quant_lot_id_fkey                                         | stock_quant                                                   | FOREIGN KEY (lot_id) REFERENCES stock_lot(id) ON DELETE RESTRICT
 stock_quant_create_uid_fkey                                     | stock_quant                                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_quant_package_pkey                                        | stock_quant_package                                           | PRIMARY KEY (id)
 stock_quant_package_create_uid_fkey                             | stock_quant_package                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_quant_package_company_id_fkey                             | stock_quant_package                                           | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 stock_quant_package_package_type_id_fkey                        | stock_quant_package                                           | FOREIGN KEY (package_type_id) REFERENCES stock_package_type(id) ON DELETE SET NULL
 stock_quant_package_write_uid_fkey                              | stock_quant_package                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_quant_package_location_id_fkey                            | stock_quant_package                                           | FOREIGN KEY (location_id) REFERENCES stock_location(id) ON DELETE SET NULL
 stock_quant_relocate_write_uid_fkey                             | stock_quant_relocate                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_quant_relocate_dest_location_id_fkey                      | stock_quant_relocate                                          | FOREIGN KEY (dest_location_id) REFERENCES stock_location(id) ON DELETE SET NULL
 stock_quant_relocate_dest_package_id_fkey                       | stock_quant_relocate                                          | FOREIGN KEY (dest_package_id) REFERENCES stock_quant_package(id) ON DELETE SET NULL
 stock_quant_relocate_create_uid_fkey                            | stock_quant_relocate                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_quant_relocate_pkey                                       | stock_quant_relocate                                          | PRIMARY KEY (id)
 stock_quant_stock_quant_relocate_r_stock_quant_relocate_id_fkey | stock_quant_stock_quant_relocate_rel                          | FOREIGN KEY (stock_quant_relocate_id) REFERENCES stock_quant_relocate(id) ON DELETE CASCADE
 stock_quant_stock_quant_relocate_rel_pkey                       | stock_quant_stock_quant_relocate_rel                          | PRIMARY KEY (stock_quant_relocate_id, stock_quant_id)
 stock_quant_stock_quant_relocate_rel_stock_quant_id_fkey        | stock_quant_stock_quant_relocate_rel                          | FOREIGN KEY (stock_quant_id) REFERENCES stock_quant(id) ON DELETE CASCADE
 stock_quant_stock_request_count_rel_stock_quant_id_fkey         | stock_quant_stock_request_count_rel                           | FOREIGN KEY (stock_quant_id) REFERENCES stock_quant(id) ON DELETE CASCADE
 stock_quant_stock_request_count_rel_pkey                        | stock_quant_stock_request_count_rel                           | PRIMARY KEY (stock_request_count_id, stock_quant_id)
 stock_quant_stock_request_count_rel_stock_request_count_id_fkey | stock_quant_stock_request_count_rel                           | FOREIGN KEY (stock_request_count_id) REFERENCES stock_request_count(id) ON DELETE CASCADE
 stock_quant_stock_track_confirmation_rel_stock_quant_id_fkey    | stock_quant_stock_track_confirmation_rel                      | FOREIGN KEY (stock_quant_id) REFERENCES stock_quant(id) ON DELETE CASCADE
 stock_quant_stock_track_confirmation_rel_pkey                   | stock_quant_stock_track_confirmation_rel                      | PRIMARY KEY (stock_track_confirmation_id, stock_quant_id)
 stock_quant_stock_track_confir_stock_track_confirmation_id_fkey | stock_quant_stock_track_confirmation_rel                      | FOREIGN KEY (stock_track_confirmation_id) REFERENCES stock_track_confirmation(id) ON DELETE CASCADE
 stock_quantity_history_write_uid_fkey                           | stock_quantity_history                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_quantity_history_create_uid_fkey                          | stock_quantity_history                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_quantity_history_pkey                                     | stock_quantity_history                                        | PRIMARY KEY (id)
 stock_replenishment_info_pkey                                   | stock_replenishment_info                                      | PRIMARY KEY (id)
 stock_replenishment_info_orderpoint_id_fkey                     | stock_replenishment_info                                      | FOREIGN KEY (orderpoint_id) REFERENCES stock_warehouse_orderpoint(id) ON DELETE SET NULL
 stock_replenishment_info_create_uid_fkey                        | stock_replenishment_info                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_replenishment_info_write_uid_fkey                         | stock_replenishment_info                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_replenishment_option_write_uid_fkey                       | stock_replenishment_option                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_replenishment_option_replenishment_info_id_fkey           | stock_replenishment_option                                    | FOREIGN KEY (replenishment_info_id) REFERENCES stock_replenishment_info(id) ON DELETE SET NULL
 stock_replenishment_option_create_uid_fkey                      | stock_replenishment_option                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_replenishment_option_route_id_fkey                        | stock_replenishment_option                                    | FOREIGN KEY (route_id) REFERENCES stock_route(id) ON DELETE SET NULL
 stock_replenishment_option_pkey                                 | stock_replenishment_option                                    | PRIMARY KEY (id)
 stock_replenishment_option_product_id_fkey                      | stock_replenishment_option                                    | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE SET NULL
 stock_request_count_pkey                                        | stock_request_count                                           | PRIMARY KEY (id)
 stock_request_count_write_uid_fkey                              | stock_request_count                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_request_count_user_id_fkey                                | stock_request_count                                           | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 stock_request_count_create_uid_fkey                             | stock_request_count                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_return_picking_write_uid_fkey                             | stock_return_picking                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_return_picking_picking_id_fkey                            | stock_return_picking                                          | FOREIGN KEY (picking_id) REFERENCES stock_picking(id) ON DELETE SET NULL
 stock_return_picking_pkey                                       | stock_return_picking                                          | PRIMARY KEY (id)
 stock_return_picking_create_uid_fkey                            | stock_return_picking                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_return_picking_line_wizard_id_fkey                        | stock_return_picking_line                                     | FOREIGN KEY (wizard_id) REFERENCES stock_return_picking(id) ON DELETE SET NULL
 stock_return_picking_line_move_id_fkey                          | stock_return_picking_line                                     | FOREIGN KEY (move_id) REFERENCES stock_move(id) ON DELETE SET NULL
 stock_return_picking_line_create_uid_fkey                       | stock_return_picking_line                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_return_picking_line_write_uid_fkey                        | stock_return_picking_line                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_return_picking_line_pkey                                  | stock_return_picking_line                                     | PRIMARY KEY (id)
 stock_return_picking_line_product_id_fkey                       | stock_return_picking_line                                     | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE CASCADE
 stock_route_create_uid_fkey                                     | stock_route                                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_route_company_id_fkey                                     | stock_route                                                   | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 stock_route_supplier_wh_id_fkey                                 | stock_route                                                   | FOREIGN KEY (supplier_wh_id) REFERENCES stock_warehouse(id) ON DELETE SET NULL
 stock_route_supplied_wh_id_fkey                                 | stock_route                                                   | FOREIGN KEY (supplied_wh_id) REFERENCES stock_warehouse(id) ON DELETE SET NULL
 stock_route_pkey                                                | stock_route                                                   | PRIMARY KEY (id)
 stock_route_write_uid_fkey                                      | stock_route                                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_route_categ_pkey                                          | stock_route_categ                                             | PRIMARY KEY (route_id, categ_id)
 stock_route_categ_categ_id_fkey                                 | stock_route_categ                                             | FOREIGN KEY (categ_id) REFERENCES product_category(id) ON DELETE CASCADE
 stock_route_categ_route_id_fkey                                 | stock_route_categ                                             | FOREIGN KEY (route_id) REFERENCES stock_route(id) ON DELETE CASCADE
 stock_route_move_move_id_fkey                                   | stock_route_move                                              | FOREIGN KEY (move_id) REFERENCES stock_move(id) ON DELETE CASCADE
 stock_route_move_route_id_fkey                                  | stock_route_move                                              | FOREIGN KEY (route_id) REFERENCES stock_route(id) ON DELETE CASCADE
 stock_route_move_pkey                                           | stock_route_move                                              | PRIMARY KEY (move_id, route_id)
 stock_route_packaging_pkey                                      | stock_route_packaging                                         | PRIMARY KEY (route_id, packaging_id)
 stock_route_packaging_packaging_id_fkey                         | stock_route_packaging                                         | FOREIGN KEY (packaging_id) REFERENCES product_packaging(id) ON DELETE CASCADE
 stock_route_packaging_route_id_fkey                             | stock_route_packaging                                         | FOREIGN KEY (route_id) REFERENCES stock_route(id) ON DELETE CASCADE
 stock_route_product_pkey                                        | stock_route_product                                           | PRIMARY KEY (route_id, product_id)
 stock_route_product_route_id_fkey                               | stock_route_product                                           | FOREIGN KEY (route_id) REFERENCES stock_route(id) ON DELETE CASCADE
 stock_route_product_product_id_fkey                             | stock_route_product                                           | FOREIGN KEY (product_id) REFERENCES product_template(id) ON DELETE CASCADE
 stock_route_stock_rules_report_rel_pkey                         | stock_route_stock_rules_report_rel                            | PRIMARY KEY (stock_rules_report_id, stock_route_id)
 stock_route_stock_rules_report_rel_stock_rules_report_id_fkey   | stock_route_stock_rules_report_rel                            | FOREIGN KEY (stock_rules_report_id) REFERENCES stock_rules_report(id) ON DELETE CASCADE
 stock_route_stock_rules_report_rel_stock_route_id_fkey          | stock_route_stock_rules_report_rel                            | FOREIGN KEY (stock_route_id) REFERENCES stock_route(id) ON DELETE CASCADE
 stock_route_warehouse_pkey                                      | stock_route_warehouse                                         | PRIMARY KEY (route_id, warehouse_id)
 stock_route_warehouse_warehouse_id_fkey                         | stock_route_warehouse                                         | FOREIGN KEY (warehouse_id) REFERENCES stock_warehouse(id) ON DELETE CASCADE
 stock_route_warehouse_route_id_fkey                             | stock_route_warehouse                                         | FOREIGN KEY (route_id) REFERENCES stock_route(id) ON DELETE CASCADE
 stock_rule_group_id_fkey                                        | stock_rule                                                    | FOREIGN KEY (group_id) REFERENCES procurement_group(id) ON DELETE SET NULL
 stock_rule_write_uid_fkey                                       | stock_rule                                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_rule_create_uid_fkey                                      | stock_rule                                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_rule_propagate_warehouse_id_fkey                          | stock_rule                                                    | FOREIGN KEY (propagate_warehouse_id) REFERENCES stock_warehouse(id) ON DELETE SET NULL
 stock_rule_warehouse_id_fkey                                    | stock_rule                                                    | FOREIGN KEY (warehouse_id) REFERENCES stock_warehouse(id) ON DELETE SET NULL
 stock_rule_partner_address_id_fkey                              | stock_rule                                                    | FOREIGN KEY (partner_address_id) REFERENCES res_partner(id) ON DELETE SET NULL
 stock_rule_picking_type_id_fkey                                 | stock_rule                                                    | FOREIGN KEY (picking_type_id) REFERENCES stock_picking_type(id) ON DELETE RESTRICT
 stock_rule_route_id_fkey                                        | stock_rule                                                    | FOREIGN KEY (route_id) REFERENCES stock_route(id) ON DELETE CASCADE
 stock_rule_location_src_id_fkey                                 | stock_rule                                                    | FOREIGN KEY (location_src_id) REFERENCES stock_location(id) ON DELETE SET NULL
 stock_rule_location_dest_id_fkey                                | stock_rule                                                    | FOREIGN KEY (location_dest_id) REFERENCES stock_location(id) ON DELETE RESTRICT
 stock_rule_company_id_fkey                                      | stock_rule                                                    | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 stock_rule_pkey                                                 | stock_rule                                                    | PRIMARY KEY (id)
 stock_rules_report_create_uid_fkey                              | stock_rules_report                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_rules_report_product_id_fkey                              | stock_rules_report                                            | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE CASCADE
 stock_rules_report_pkey                                         | stock_rules_report                                            | PRIMARY KEY (id)
 stock_rules_report_product_tmpl_id_fkey                         | stock_rules_report                                            | FOREIGN KEY (product_tmpl_id) REFERENCES product_template(id) ON DELETE CASCADE
 stock_rules_report_write_uid_fkey                               | stock_rules_report                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_rules_report_stock_warehouse_rel_stock_warehouse_id_fkey  | stock_rules_report_stock_warehouse_rel                        | FOREIGN KEY (stock_warehouse_id) REFERENCES stock_warehouse(id) ON DELETE CASCADE
 stock_rules_report_stock_warehouse_r_stock_rules_report_id_fkey | stock_rules_report_stock_warehouse_rel                        | FOREIGN KEY (stock_rules_report_id) REFERENCES stock_rules_report(id) ON DELETE CASCADE
 stock_rules_report_stock_warehouse_rel_pkey                     | stock_rules_report_stock_warehouse_rel                        | PRIMARY KEY (stock_rules_report_id, stock_warehouse_id)
 stock_scrap_product_id_fkey                                     | stock_scrap                                                   | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE RESTRICT
 stock_scrap_workorder_id_fkey                                   | stock_scrap                                                   | FOREIGN KEY (workorder_id) REFERENCES mrp_workorder(id) ON DELETE SET NULL
 stock_scrap_production_id_fkey                                  | stock_scrap                                                   | FOREIGN KEY (production_id) REFERENCES mrp_production(id) ON DELETE SET NULL
 stock_scrap_pkey                                                | stock_scrap                                                   | PRIMARY KEY (id)
 stock_scrap_lot_id_fkey                                         | stock_scrap                                                   | FOREIGN KEY (lot_id) REFERENCES stock_lot(id) ON DELETE SET NULL
 stock_scrap_company_id_fkey                                     | stock_scrap                                                   | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 stock_scrap_write_uid_fkey                                      | stock_scrap                                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_scrap_create_uid_fkey                                     | stock_scrap                                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_scrap_product_uom_id_fkey                                 | stock_scrap                                                   | FOREIGN KEY (product_uom_id) REFERENCES uom_uom(id) ON DELETE RESTRICT
 stock_scrap_scrap_location_id_fkey                              | stock_scrap                                                   | FOREIGN KEY (scrap_location_id) REFERENCES stock_location(id) ON DELETE RESTRICT
 stock_scrap_location_id_fkey                                    | stock_scrap                                                   | FOREIGN KEY (location_id) REFERENCES stock_location(id) ON DELETE RESTRICT
 stock_scrap_picking_id_fkey                                     | stock_scrap                                                   | FOREIGN KEY (picking_id) REFERENCES stock_picking(id) ON DELETE SET NULL
 stock_scrap_owner_id_fkey                                       | stock_scrap                                                   | FOREIGN KEY (owner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 stock_scrap_package_id_fkey                                     | stock_scrap                                                   | FOREIGN KEY (package_id) REFERENCES stock_quant_package(id) ON DELETE SET NULL
 stock_scrap_bom_id_fkey                                         | stock_scrap                                                   | FOREIGN KEY (bom_id) REFERENCES mrp_bom(id) ON DELETE SET NULL
 stock_scrap_reason_tag_pkey                                     | stock_scrap_reason_tag                                        | PRIMARY KEY (id)
 stock_scrap_reason_tag_write_uid_fkey                           | stock_scrap_reason_tag                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_scrap_reason_tag_create_uid_fkey                          | stock_scrap_reason_tag                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_scrap_reason_tag_name_uniq                                | stock_scrap_reason_tag                                        | UNIQUE (name)
 stock_scrap_stock_scrap_reason_tag_rel_stock_scrap_id_fkey      | stock_scrap_stock_scrap_reason_tag_rel                        | FOREIGN KEY (stock_scrap_id) REFERENCES stock_scrap(id) ON DELETE CASCADE
 stock_scrap_stock_scrap_reason_tag_rel_pkey                     | stock_scrap_stock_scrap_reason_tag_rel                        | PRIMARY KEY (stock_scrap_id, stock_scrap_reason_tag_id)
 stock_scrap_stock_scrap_reason_t_stock_scrap_reason_tag_id_fkey | stock_scrap_stock_scrap_reason_tag_rel                        | FOREIGN KEY (stock_scrap_reason_tag_id) REFERENCES stock_scrap_reason_tag(id) ON DELETE CASCADE
 stock_storage_category_company_id_fkey                          | stock_storage_category                                        | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 stock_storage_category_pkey                                     | stock_storage_category                                        | PRIMARY KEY (id)
 stock_storage_category_positive_max_weight                      | stock_storage_category                                        | CHECK ((max_weight >= (0)::numeric))
 stock_storage_category_create_uid_fkey                          | stock_storage_category                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_storage_category_write_uid_fkey                           | stock_storage_category                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_storage_category_capacity_unique_package_type             | stock_storage_category_capacity                               | UNIQUE (package_type_id, storage_category_id)
 stock_storage_category_capacity_pkey                            | stock_storage_category_capacity                               | PRIMARY KEY (id)
 stock_storage_category_capacity_positive_quantity               | stock_storage_category_capacity                               | CHECK ((quantity > (0)::double precision))
 stock_storage_category_capacity_unique_product                  | stock_storage_category_capacity                               | UNIQUE (product_id, storage_category_id)
 stock_storage_category_capacity_storage_category_id_fkey        | stock_storage_category_capacity                               | FOREIGN KEY (storage_category_id) REFERENCES stock_storage_category(id) ON DELETE CASCADE
 stock_storage_category_capacity_product_id_fkey                 | stock_storage_category_capacity                               | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE CASCADE
 stock_storage_category_capacity_package_type_id_fkey            | stock_storage_category_capacity                               | FOREIGN KEY (package_type_id) REFERENCES stock_package_type(id) ON DELETE CASCADE
 stock_storage_category_capacity_create_uid_fkey                 | stock_storage_category_capacity                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_storage_category_capacity_write_uid_fkey                  | stock_storage_category_capacity                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_traceability_report_write_uid_fkey                        | stock_traceability_report                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_traceability_report_create_uid_fkey                       | stock_traceability_report                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_traceability_report_pkey                                  | stock_traceability_report                                     | PRIMARY KEY (id)
 stock_track_confirmation_create_uid_fkey                        | stock_track_confirmation                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_track_confirmation_write_uid_fkey                         | stock_track_confirmation                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_track_confirmation_pkey                                   | stock_track_confirmation                                      | PRIMARY KEY (id)
 stock_track_line_wizard_id_fkey                                 | stock_track_line                                              | FOREIGN KEY (wizard_id) REFERENCES stock_track_confirmation(id) ON DELETE SET NULL
 stock_track_line_write_uid_fkey                                 | stock_track_line                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_track_line_pkey                                           | stock_track_line                                              | PRIMARY KEY (id)
 stock_track_line_product_id_fkey                                | stock_track_line                                              | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE SET NULL
 stock_track_line_create_uid_fkey                                | stock_track_line                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_valuation_layer_product_id_fkey                           | stock_valuation_layer                                         | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE RESTRICT
 stock_valuation_layer_categ_id_fkey                             | stock_valuation_layer                                         | FOREIGN KEY (categ_id) REFERENCES product_category(id) ON DELETE SET NULL
 stock_valuation_layer_stock_valuation_layer_id_fkey             | stock_valuation_layer                                         | FOREIGN KEY (stock_valuation_layer_id) REFERENCES stock_valuation_layer(id) ON DELETE SET NULL
 stock_valuation_layer_stock_move_id_fkey                        | stock_valuation_layer                                         | FOREIGN KEY (stock_move_id) REFERENCES stock_move(id) ON DELETE SET NULL
 stock_valuation_layer_account_move_id_fkey                      | stock_valuation_layer                                         | FOREIGN KEY (account_move_id) REFERENCES account_move(id) ON DELETE SET NULL
 stock_valuation_layer_account_move_line_id_fkey                 | stock_valuation_layer                                         | FOREIGN KEY (account_move_line_id) REFERENCES account_move_line(id) ON DELETE SET NULL
 stock_valuation_layer_lot_id_fkey                               | stock_valuation_layer                                         | FOREIGN KEY (lot_id) REFERENCES stock_lot(id) ON DELETE SET NULL
 stock_valuation_layer_create_uid_fkey                           | stock_valuation_layer                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_valuation_layer_write_uid_fkey                            | stock_valuation_layer                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_valuation_layer_pkey                                      | stock_valuation_layer                                         | PRIMARY KEY (id)
 stock_valuation_layer_company_id_fkey                           | stock_valuation_layer                                         | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 stock_valuation_layer_revaluation_lot_id_fkey                   | stock_valuation_layer_revaluation                             | FOREIGN KEY (lot_id) REFERENCES stock_lot(id) ON DELETE SET NULL
 stock_valuation_layer_revaluation_company_id_fkey               | stock_valuation_layer_revaluation                             | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE CASCADE
 stock_valuation_layer_revaluation_product_id_fkey               | stock_valuation_layer_revaluation                             | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE CASCADE
 stock_valuation_layer_revaluation_account_journal_id_fkey       | stock_valuation_layer_revaluation                             | FOREIGN KEY (account_journal_id) REFERENCES account_journal(id) ON DELETE SET NULL
 stock_valuation_layer_revaluation_account_id_fkey               | stock_valuation_layer_revaluation                             | FOREIGN KEY (account_id) REFERENCES account_account(id) ON DELETE SET NULL
 stock_valuation_layer_revaluation_create_uid_fkey               | stock_valuation_layer_revaluation                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_valuation_layer_revaluation_write_uid_fkey                | stock_valuation_layer_revaluation                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_valuation_layer_revaluation_pkey                          | stock_valuation_layer_revaluation                             | PRIMARY KEY (id)
 stock_valuation_layer_stock_valuation_layer_revaluation_re_pkey | stock_valuation_layer_stock_valuation_layer_revaluation_rel   | PRIMARY KEY (stock_valuation_layer_revaluation_id, stock_valuation_layer_id)
 stock_valuation_layer_stock_v_stock_valuation_layer_revalu_fkey | stock_valuation_layer_stock_valuation_layer_revaluation_rel   | FOREIGN KEY (stock_valuation_layer_revaluation_id) REFERENCES stock_valuation_layer_revaluation(id) ON DELETE CASCADE
 stock_valuation_layer_stock_valua_stock_valuation_layer_id_fkey | stock_valuation_layer_stock_valuation_layer_revaluation_rel   | FOREIGN KEY (stock_valuation_layer_id) REFERENCES stock_valuation_layer(id) ON DELETE CASCADE
 stock_warehouse_company_id_fkey                                 | stock_warehouse                                               | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 stock_warehouse_partner_id_fkey                                 | stock_warehouse                                               | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 stock_warehouse_view_location_id_fkey                           | stock_warehouse                                               | FOREIGN KEY (view_location_id) REFERENCES stock_location(id) ON DELETE RESTRICT
 stock_warehouse_lot_stock_id_fkey                               | stock_warehouse                                               | FOREIGN KEY (lot_stock_id) REFERENCES stock_location(id) ON DELETE RESTRICT
 stock_warehouse_pbm_mto_pull_id_fkey                            | stock_warehouse                                               | FOREIGN KEY (pbm_mto_pull_id) REFERENCES stock_rule(id) ON DELETE SET NULL
 stock_warehouse_sam_rule_id_fkey                                | stock_warehouse                                               | FOREIGN KEY (sam_rule_id) REFERENCES stock_rule(id) ON DELETE SET NULL
 stock_warehouse_manufacture_pull_id_fkey                        | stock_warehouse                                               | FOREIGN KEY (manufacture_pull_id) REFERENCES stock_rule(id) ON DELETE SET NULL
 stock_warehouse_buy_pull_id_fkey                                | stock_warehouse                                               | FOREIGN KEY (buy_pull_id) REFERENCES stock_rule(id) ON DELETE SET NULL
 stock_warehouse_in_type_id_fkey                                 | stock_warehouse                                               | FOREIGN KEY (in_type_id) REFERENCES stock_picking_type(id) ON DELETE SET NULL
 stock_warehouse_int_type_id_fkey                                | stock_warehouse                                               | FOREIGN KEY (int_type_id) REFERENCES stock_picking_type(id) ON DELETE SET NULL
 stock_warehouse_qc_type_id_fkey                                 | stock_warehouse                                               | FOREIGN KEY (qc_type_id) REFERENCES stock_picking_type(id) ON DELETE SET NULL
 stock_warehouse_store_type_id_fkey                              | stock_warehouse                                               | FOREIGN KEY (store_type_id) REFERENCES stock_picking_type(id) ON DELETE SET NULL
 stock_warehouse_warehouse_name_uniq                             | stock_warehouse                                               | UNIQUE (name, company_id)
 stock_warehouse_warehouse_code_uniq                             | stock_warehouse                                               | UNIQUE (code, company_id)
 stock_warehouse_sam_loc_id_fkey                                 | stock_warehouse                                               | FOREIGN KEY (sam_loc_id) REFERENCES stock_location(id) ON DELETE SET NULL
 stock_warehouse_xdock_type_id_fkey                              | stock_warehouse                                               | FOREIGN KEY (xdock_type_id) REFERENCES stock_picking_type(id) ON DELETE SET NULL
 stock_warehouse_pbm_loc_id_fkey                                 | stock_warehouse                                               | FOREIGN KEY (pbm_loc_id) REFERENCES stock_location(id) ON DELETE SET NULL
 stock_warehouse_crossdock_route_id_fkey                         | stock_warehouse                                               | FOREIGN KEY (crossdock_route_id) REFERENCES stock_route(id) ON DELETE RESTRICT
 stock_warehouse_reception_route_id_fkey                         | stock_warehouse                                               | FOREIGN KEY (reception_route_id) REFERENCES stock_route(id) ON DELETE RESTRICT
 stock_warehouse_delivery_route_id_fkey                          | stock_warehouse                                               | FOREIGN KEY (delivery_route_id) REFERENCES stock_route(id) ON DELETE RESTRICT
 stock_warehouse_pbm_route_id_fkey                               | stock_warehouse                                               | FOREIGN KEY (pbm_route_id) REFERENCES stock_route(id) ON DELETE RESTRICT
 stock_warehouse_sam_type_id_fkey                                | stock_warehouse                                               | FOREIGN KEY (sam_type_id) REFERENCES stock_picking_type(id) ON DELETE SET NULL
 stock_warehouse_pbm_type_id_fkey                                | stock_warehouse                                               | FOREIGN KEY (pbm_type_id) REFERENCES stock_picking_type(id) ON DELETE SET NULL
 stock_warehouse_manufacture_mto_pull_id_fkey                    | stock_warehouse                                               | FOREIGN KEY (manufacture_mto_pull_id) REFERENCES stock_rule(id) ON DELETE SET NULL
 stock_warehouse_manu_type_id_fkey                               | stock_warehouse                                               | FOREIGN KEY (manu_type_id) REFERENCES stock_picking_type(id) ON DELETE SET NULL
 stock_warehouse_wh_input_stock_loc_id_fkey                      | stock_warehouse                                               | FOREIGN KEY (wh_input_stock_loc_id) REFERENCES stock_location(id) ON DELETE SET NULL
 stock_warehouse_wh_qc_stock_loc_id_fkey                         | stock_warehouse                                               | FOREIGN KEY (wh_qc_stock_loc_id) REFERENCES stock_location(id) ON DELETE SET NULL
 stock_warehouse_create_uid_fkey                                 | stock_warehouse                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_warehouse_wh_pack_stock_loc_id_fkey                       | stock_warehouse                                               | FOREIGN KEY (wh_pack_stock_loc_id) REFERENCES stock_location(id) ON DELETE SET NULL
 stock_warehouse_write_uid_fkey                                  | stock_warehouse                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_warehouse_wh_output_stock_loc_id_fkey                     | stock_warehouse                                               | FOREIGN KEY (wh_output_stock_loc_id) REFERENCES stock_location(id) ON DELETE SET NULL
 stock_warehouse_mto_pull_id_fkey                                | stock_warehouse                                               | FOREIGN KEY (mto_pull_id) REFERENCES stock_rule(id) ON DELETE SET NULL
 stock_warehouse_pack_type_id_fkey                               | stock_warehouse                                               | FOREIGN KEY (pack_type_id) REFERENCES stock_picking_type(id) ON DELETE SET NULL
 stock_warehouse_pick_type_id_fkey                               | stock_warehouse                                               | FOREIGN KEY (pick_type_id) REFERENCES stock_picking_type(id) ON DELETE SET NULL
 stock_warehouse_pkey                                            | stock_warehouse                                               | PRIMARY KEY (id)
 stock_warehouse_out_type_id_fkey                                | stock_warehouse                                               | FOREIGN KEY (out_type_id) REFERENCES stock_picking_type(id) ON DELETE SET NULL
 stock_warehouse_orderpoint_supplier_id_fkey                     | stock_warehouse_orderpoint                                    | FOREIGN KEY (supplier_id) REFERENCES product_supplierinfo(id) ON DELETE SET NULL
 stock_warehouse_orderpoint_bom_id_fkey                          | stock_warehouse_orderpoint                                    | FOREIGN KEY (bom_id) REFERENCES mrp_bom(id) ON DELETE SET NULL
 stock_warehouse_orderpoint_write_uid_fkey                       | stock_warehouse_orderpoint                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_warehouse_orderpoint_create_uid_fkey                      | stock_warehouse_orderpoint                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_warehouse_orderpoint_route_id_fkey                        | stock_warehouse_orderpoint                                    | FOREIGN KEY (route_id) REFERENCES stock_route(id) ON DELETE SET NULL
 stock_warehouse_orderpoint_company_id_fkey                      | stock_warehouse_orderpoint                                    | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 stock_warehouse_orderpoint_group_id_fkey                        | stock_warehouse_orderpoint                                    | FOREIGN KEY (group_id) REFERENCES procurement_group(id) ON DELETE SET NULL
 stock_warehouse_orderpoint_product_category_id_fkey             | stock_warehouse_orderpoint                                    | FOREIGN KEY (product_category_id) REFERENCES product_category(id) ON DELETE SET NULL
 stock_warehouse_orderpoint_product_id_fkey                      | stock_warehouse_orderpoint                                    | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE CASCADE
 stock_warehouse_orderpoint_location_id_fkey                     | stock_warehouse_orderpoint                                    | FOREIGN KEY (location_id) REFERENCES stock_location(id) ON DELETE CASCADE
 stock_warehouse_orderpoint_warehouse_id_fkey                    | stock_warehouse_orderpoint                                    | FOREIGN KEY (warehouse_id) REFERENCES stock_warehouse(id) ON DELETE CASCADE
 stock_warehouse_orderpoint_product_supplier_id_fkey             | stock_warehouse_orderpoint                                    | FOREIGN KEY (product_supplier_id) REFERENCES res_partner(id) ON DELETE SET NULL
 stock_warehouse_orderpoint_vendor_id_fkey                       | stock_warehouse_orderpoint                                    | FOREIGN KEY (vendor_id) REFERENCES res_partner(id) ON DELETE SET NULL
 stock_warehouse_orderpoint_pkey                                 | stock_warehouse_orderpoint                                    | PRIMARY KEY (id)
 stock_warehouse_orderpoint_qty_multiple_check                   | stock_warehouse_orderpoint                                    | CHECK ((qty_multiple >= (0)::numeric))
 stock_warehouse_orderpoint_product_location_check               | stock_warehouse_orderpoint                                    | UNIQUE (product_id, location_id, company_id)
 stock_warn_insufficient_qty_scrap_create_uid_fkey               | stock_warn_insufficient_qty_scrap                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_warn_insufficient_qty_scrap_write_uid_fkey                | stock_warn_insufficient_qty_scrap                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_warn_insufficient_qty_scrap_product_id_fkey               | stock_warn_insufficient_qty_scrap                             | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE CASCADE
 stock_warn_insufficient_qty_scrap_scrap_id_fkey                 | stock_warn_insufficient_qty_scrap                             | FOREIGN KEY (scrap_id) REFERENCES stock_scrap(id) ON DELETE SET NULL
 stock_warn_insufficient_qty_scrap_location_id_fkey              | stock_warn_insufficient_qty_scrap                             | FOREIGN KEY (location_id) REFERENCES stock_location(id) ON DELETE CASCADE
 stock_warn_insufficient_qty_scrap_pkey                          | stock_warn_insufficient_qty_scrap                             | PRIMARY KEY (id)
 stock_warn_insufficient_qty_unbuild_write_uid_fkey              | stock_warn_insufficient_qty_unbuild                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_warn_insufficient_qty_unbuild_product_id_fkey             | stock_warn_insufficient_qty_unbuild                           | FOREIGN KEY (product_id) REFERENCES product_product(id) ON DELETE CASCADE
 stock_warn_insufficient_qty_unbuild_location_id_fkey            | stock_warn_insufficient_qty_unbuild                           | FOREIGN KEY (location_id) REFERENCES stock_location(id) ON DELETE CASCADE
 stock_warn_insufficient_qty_unbuild_pkey                        | stock_warn_insufficient_qty_unbuild                           | PRIMARY KEY (id)
 stock_warn_insufficient_qty_unbuild_unbuild_id_fkey             | stock_warn_insufficient_qty_unbuild                           | FOREIGN KEY (unbuild_id) REFERENCES mrp_unbuild(id) ON DELETE SET NULL
 stock_warn_insufficient_qty_unbuild_create_uid_fkey             | stock_warn_insufficient_qty_unbuild                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 stock_wh_resupply_table_supplied_wh_id_fkey                     | stock_wh_resupply_table                                       | FOREIGN KEY (supplied_wh_id) REFERENCES stock_warehouse(id) ON DELETE CASCADE
 stock_wh_resupply_table_supplier_wh_id_fkey                     | stock_wh_resupply_table                                       | FOREIGN KEY (supplier_wh_id) REFERENCES stock_warehouse(id) ON DELETE CASCADE
 stock_wh_resupply_table_pkey                                    | stock_wh_resupply_table                                       | PRIMARY KEY (supplied_wh_id, supplier_wh_id)
 studio_approval_entry_rule_id_fkey                              | studio_approval_entry                                         | FOREIGN KEY (rule_id) REFERENCES studio_approval_rule(id) ON DELETE CASCADE
 studio_approval_entry_user_id_fkey                              | studio_approval_entry                                         | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE RESTRICT
 studio_approval_entry_uniq_combination                          | studio_approval_entry                                         | UNIQUE (rule_id, model, res_id)
 studio_approval_entry_pkey                                      | studio_approval_entry                                         | PRIMARY KEY (id)
 studio_approval_entry_write_uid_fkey                            | studio_approval_entry                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 studio_approval_entry_create_uid_fkey                           | studio_approval_entry                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 studio_approval_request_pkey                                    | studio_approval_request                                       | PRIMARY KEY (id)
 studio_approval_request_rule_id_fkey                            | studio_approval_request                                       | FOREIGN KEY (rule_id) REFERENCES studio_approval_rule(id) ON DELETE CASCADE
 studio_approval_request_create_uid_fkey                         | studio_approval_request                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 studio_approval_request_write_uid_fkey                          | studio_approval_request                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 studio_approval_request_mail_activity_id_fkey                   | studio_approval_request                                       | FOREIGN KEY (mail_activity_id) REFERENCES mail_activity(id) ON DELETE CASCADE
 studio_approval_rule_method_or_action_not_null                  | studio_approval_rule                                          | CHECK (((method IS NOT NULL) OR (action_id IS NOT NULL)))
 studio_approval_rule_approval_group_id_fkey                     | studio_approval_rule                                          | FOREIGN KEY (approval_group_id) REFERENCES res_groups(id) ON DELETE SET NULL
 studio_approval_rule_write_uid_fkey                             | studio_approval_rule                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 studio_approval_rule_pkey                                       | studio_approval_rule                                          | PRIMARY KEY (id)
 studio_approval_rule_method_or_action_together                  | studio_approval_rule                                          | CHECK (((method IS NULL) OR (action_id IS NULL)))
 studio_approval_rule_create_uid_fkey                            | studio_approval_rule                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 studio_approval_rule_model_id_fkey                              | studio_approval_rule                                          | FOREIGN KEY (model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 studio_approval_rule_approver_rule_id_fkey                      | studio_approval_rule_approver                                 | FOREIGN KEY (rule_id) REFERENCES studio_approval_rule(id) ON DELETE CASCADE
 studio_approval_rule_approver_create_uid_fkey                   | studio_approval_rule_approver                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 studio_approval_rule_approver_write_uid_fkey                    | studio_approval_rule_approver                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 studio_approval_rule_approver_pkey                              | studio_approval_rule_approver                                 | PRIMARY KEY (id)
 studio_approval_rule_approver_user_id_fkey                      | studio_approval_rule_approver                                 | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 studio_approval_rule_delegate_pkey                              | studio_approval_rule_delegate                                 | PRIMARY KEY (id)
 studio_approval_rule_delegate_create_uid_fkey                   | studio_approval_rule_delegate                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 studio_approval_rule_delegate_approval_rule_id_fkey             | studio_approval_rule_delegate                                 | FOREIGN KEY (approval_rule_id) REFERENCES studio_approval_rule(id) ON DELETE CASCADE
 studio_approval_rule_delegate_write_uid_fkey                    | studio_approval_rule_delegate                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 studio_export_model_unique_model                                | studio_export_model                                           | UNIQUE (model_id)
 studio_export_model_model_id_fkey                               | studio_export_model                                           | FOREIGN KEY (model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 studio_export_model_write_uid_fkey                              | studio_export_model                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 studio_export_model_create_uid_fkey                             | studio_export_model                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 studio_export_model_pkey                                        | studio_export_model                                           | PRIMARY KEY (id)
 studio_export_wizard_pkey                                       | studio_export_wizard                                          | PRIMARY KEY (id)
 studio_export_wizard_write_uid_fkey                             | studio_export_wizard                                          | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 studio_export_wizard_create_uid_fkey                            | studio_export_wizard                                          | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 studio_export_wizard_data_create_uid_fkey                       | studio_export_wizard_data                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 studio_export_wizard_data_write_uid_fkey                        | studio_export_wizard_data                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 studio_export_wizard_data_pkey                                  | studio_export_wizard_data                                     | PRIMARY KEY (id)
 task_dependencies_rel_depends_on_id_fkey                        | task_dependencies_rel                                         | FOREIGN KEY (depends_on_id) REFERENCES project_task(id) ON DELETE CASCADE
 task_dependencies_rel_pkey                                      | task_dependencies_rel                                         | PRIMARY KEY (task_id, depends_on_id)
 task_dependencies_rel_task_id_fkey                              | task_dependencies_rel                                         | FOREIGN KEY (task_id) REFERENCES project_task(id) ON DELETE CASCADE
 team_favorite_user_rel_team_id_fkey                             | team_favorite_user_rel                                        | FOREIGN KEY (team_id) REFERENCES crm_team(id) ON DELETE CASCADE
 team_favorite_user_rel_pkey                                     | team_favorite_user_rel                                        | PRIMARY KEY (team_id, user_id)
 team_favorite_user_rel_user_id_fkey                             | team_favorite_user_rel                                        | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE CASCADE
 team_stage_auto_close_from_rel_helpdesk_team_id_fkey            | team_stage_auto_close_from_rel                                | FOREIGN KEY (helpdesk_team_id) REFERENCES helpdesk_team(id) ON DELETE CASCADE
 team_stage_auto_close_from_rel_helpdesk_stage_id_fkey           | team_stage_auto_close_from_rel                                | FOREIGN KEY (helpdesk_stage_id) REFERENCES helpdesk_stage(id) ON DELETE CASCADE
 team_stage_auto_close_from_rel_pkey                             | team_stage_auto_close_from_rel                                | PRIMARY KEY (helpdesk_team_id, helpdesk_stage_id)
 team_stage_rel_helpdesk_team_id_fkey                            | team_stage_rel                                                | FOREIGN KEY (helpdesk_team_id) REFERENCES helpdesk_team(id) ON DELETE CASCADE
 team_stage_rel_pkey                                             | team_stage_rel                                                | PRIMARY KEY (helpdesk_team_id, helpdesk_stage_id)
 team_stage_rel_helpdesk_stage_id_fkey                           | team_stage_rel                                                | FOREIGN KEY (helpdesk_stage_id) REFERENCES helpdesk_stage(id) ON DELETE CASCADE
 template_attribute_value_mrp_p_template_attribute_value_id_fkey | template_attribute_value_mrp_production_rel                   | FOREIGN KEY (template_attribute_value_id) REFERENCES product_template_attribute_value(id) ON DELETE CASCADE
 template_attribute_value_mrp_production_rel_production_id_fkey  | template_attribute_value_mrp_production_rel                   | FOREIGN KEY (production_id) REFERENCES mrp_production(id) ON DELETE CASCADE
 template_attribute_value_mrp_production_rel_pkey                | template_attribute_value_mrp_production_rel                   | PRIMARY KEY (production_id, template_attribute_value_id)
 template_attribute_value_stock_template_attribute_value_id_fkey | template_attribute_value_stock_move_rel                       | FOREIGN KEY (template_attribute_value_id) REFERENCES product_template_attribute_value(id) ON DELETE CASCADE
 template_attribute_value_stock_move_rel_move_id_fkey            | template_attribute_value_stock_move_rel                       | FOREIGN KEY (move_id) REFERENCES stock_move(id) ON DELETE CASCADE
 template_attribute_value_stock_move_rel_pkey                    | template_attribute_value_stock_move_rel                       | PRIMARY KEY (move_id, template_attribute_value_id)
 theme_ir_asset_create_uid_fkey                                  | theme_ir_asset                                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 theme_ir_asset_pkey                                             | theme_ir_asset                                                | PRIMARY KEY (id)
 theme_ir_asset_write_uid_fkey                                   | theme_ir_asset                                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 theme_ir_attachment_write_uid_fkey                              | theme_ir_attachment                                           | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 theme_ir_attachment_pkey                                        | theme_ir_attachment                                           | PRIMARY KEY (id)
 theme_ir_attachment_create_uid_fkey                             | theme_ir_attachment                                           | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 theme_ir_ui_view_write_uid_fkey                                 | theme_ir_ui_view                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 theme_ir_ui_view_create_uid_fkey                                | theme_ir_ui_view                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 theme_ir_ui_view_pkey                                           | theme_ir_ui_view                                              | PRIMARY KEY (id)
 theme_website_menu_create_uid_fkey                              | theme_website_menu                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 theme_website_menu_pkey                                         | theme_website_menu                                            | PRIMARY KEY (id)
 theme_website_menu_write_uid_fkey                               | theme_website_menu                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 theme_website_menu_parent_id_fkey                               | theme_website_menu                                            | FOREIGN KEY (parent_id) REFERENCES theme_website_menu(id) ON DELETE CASCADE
 theme_website_menu_page_id_fkey                                 | theme_website_menu                                            | FOREIGN KEY (page_id) REFERENCES theme_website_page(id) ON DELETE CASCADE
 theme_website_page_view_id_fkey                                 | theme_website_page                                            | FOREIGN KEY (view_id) REFERENCES theme_ir_ui_view(id) ON DELETE CASCADE
 theme_website_page_write_uid_fkey                               | theme_website_page                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 theme_website_page_create_uid_fkey                              | theme_website_page                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 theme_website_page_pkey                                         | theme_website_page                                            | PRIMARY KEY (id)
 timer_timer_unique_timer                                        | timer_timer                                                   | UNIQUE (res_model, res_id, user_id)
 timer_timer_pkey                                                | timer_timer                                                   | PRIMARY KEY (id)
 timer_timer_write_uid_fkey                                      | timer_timer                                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 timer_timer_create_uid_fkey                                     | timer_timer                                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 timer_timer_user_id_fkey                                        | timer_timer                                                   | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE SET NULL
 uom_category_write_uid_fkey                                     | uom_category                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 uom_category_pkey                                               | uom_category                                                  | PRIMARY KEY (id)
 uom_category_create_uid_fkey                                    | uom_category                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 uom_uom_factor_reference_is_one                                 | uom_uom                                                       | CHECK (((((uom_type)::text = 'reference'::text) AND (factor = 1.0)) OR ((uom_type)::text <> 'reference'::text)))
 uom_uom_rounding_gt_zero                                        | uom_uom                                                       | CHECK ((rounding > (0)::numeric))
 uom_uom_factor_gt_zero                                          | uom_uom                                                       | CHECK ((factor <> (0)::numeric))
 uom_uom_pkey                                                    | uom_uom                                                       | PRIMARY KEY (id)
 uom_uom_write_uid_fkey                                          | uom_uom                                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 uom_uom_create_uid_fkey                                         | uom_uom                                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 uom_uom_category_id_fkey                                        | uom_uom                                                       | FOREIGN KEY (category_id) REFERENCES uom_category(id) ON DELETE RESTRICT
 update_product_attribute_value_pkey                             | update_product_attribute_value                                | PRIMARY KEY (id)
 update_product_attribute_value_attribute_value_id_fkey          | update_product_attribute_value                                | FOREIGN KEY (attribute_value_id) REFERENCES product_attribute_value(id) ON DELETE CASCADE
 update_product_attribute_value_write_uid_fkey                   | update_product_attribute_value                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 update_product_attribute_value_create_uid_fkey                  | update_product_attribute_value                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 utm_campaign_stage_id_fkey                                      | utm_campaign                                                  | FOREIGN KEY (stage_id) REFERENCES utm_stage(id) ON DELETE RESTRICT
 utm_campaign_company_id_fkey                                    | utm_campaign                                                  | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE SET NULL
 utm_campaign_ab_testing_winner_mailing_id_fkey                  | utm_campaign                                                  | FOREIGN KEY (ab_testing_winner_mailing_id) REFERENCES mailing_mailing(id) ON DELETE SET NULL
 utm_campaign_write_uid_fkey                                     | utm_campaign                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 utm_campaign_pkey                                               | utm_campaign                                                  | PRIMARY KEY (id)
 utm_campaign_create_uid_fkey                                    | utm_campaign                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 utm_campaign_unique_name                                        | utm_campaign                                                  | UNIQUE (name)
 utm_campaign_user_id_fkey                                       | utm_campaign                                                  | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE RESTRICT
 utm_medium_create_uid_fkey                                      | utm_medium                                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 utm_medium_write_uid_fkey                                       | utm_medium                                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 utm_medium_pkey                                                 | utm_medium                                                    | PRIMARY KEY (id)
 utm_medium_unique_name                                          | utm_medium                                                    | UNIQUE (name)
 utm_source_pkey                                                 | utm_source                                                    | PRIMARY KEY (id)
 utm_source_write_uid_fkey                                       | utm_source                                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 utm_source_unique_name                                          | utm_source                                                    | UNIQUE (name)
 utm_source_create_uid_fkey                                      | utm_source                                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 utm_stage_create_uid_fkey                                       | utm_stage                                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 utm_stage_write_uid_fkey                                        | utm_stage                                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 utm_stage_pkey                                                  | utm_stage                                                     | PRIMARY KEY (id)
 utm_tag_write_uid_fkey                                          | utm_tag                                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 utm_tag_name_uniq                                               | utm_tag                                                       | UNIQUE (name)
 utm_tag_pkey                                                    | utm_tag                                                       | PRIMARY KEY (id)
 utm_tag_create_uid_fkey                                         | utm_tag                                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 utm_tag_rel_campaign_id_fkey                                    | utm_tag_rel                                                   | FOREIGN KEY (campaign_id) REFERENCES utm_tag(id) ON DELETE CASCADE
 utm_tag_rel_pkey                                                | utm_tag_rel                                                   | PRIMARY KEY (tag_id, campaign_id)
 utm_tag_rel_tag_id_fkey                                         | utm_tag_rel                                                   | FOREIGN KEY (tag_id) REFERENCES utm_campaign(id) ON DELETE CASCADE
 validate_account_move_pkey                                      | validate_account_move                                         | PRIMARY KEY (id)
 validate_account_move_create_uid_fkey                           | validate_account_move                                         | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 validate_account_move_write_uid_fkey                            | validate_account_move                                         | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 web_editor_converter_test_create_uid_fkey                       | web_editor_converter_test                                     | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 web_editor_converter_test_write_uid_fkey                        | web_editor_converter_test                                     | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 web_editor_converter_test_many2one_fkey                         | web_editor_converter_test                                     | FOREIGN KEY (many2one) REFERENCES web_editor_converter_test_sub(id) ON DELETE SET NULL
 web_editor_converter_test_pkey                                  | web_editor_converter_test                                     | PRIMARY KEY (id)
 web_editor_converter_test_sub_pkey                              | web_editor_converter_test_sub                                 | PRIMARY KEY (id)
 web_editor_converter_test_sub_write_uid_fkey                    | web_editor_converter_test_sub                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 web_editor_converter_test_sub_create_uid_fkey                   | web_editor_converter_test_sub                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 web_tour_tour_write_uid_fkey                                    | web_tour_tour                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 web_tour_tour_pkey                                              | web_tour_tour                                                 | PRIMARY KEY (id)
 web_tour_tour_uniq_name                                         | web_tour_tour                                                 | UNIQUE (name)
 web_tour_tour_create_uid_fkey                                   | web_tour_tour                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 web_tour_tour_step_create_uid_fkey                              | web_tour_tour_step                                            | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 web_tour_tour_step_pkey                                         | web_tour_tour_step                                            | PRIMARY KEY (id)
 web_tour_tour_step_write_uid_fkey                               | web_tour_tour_step                                            | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 web_tour_tour_step_tour_id_fkey                                 | web_tour_tour_step                                            | FOREIGN KEY (tour_id) REFERENCES web_tour_tour(id) ON DELETE CASCADE
 website_write_uid_fkey                                          | website                                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_pkey                                                    | website                                                       | PRIMARY KEY (id)
 website_crm_default_team_id_fkey                                | website                                                       | FOREIGN KEY (crm_default_team_id) REFERENCES crm_team(id) ON DELETE SET NULL
 website_domain_unique                                           | website                                                       | UNIQUE (domain)
 website_crm_default_user_id_fkey                                | website                                                       | FOREIGN KEY (crm_default_user_id) REFERENCES res_users(id) ON DELETE SET NULL
 website_company_id_fkey                                         | website                                                       | FOREIGN KEY (company_id) REFERENCES res_company(id) ON DELETE RESTRICT
 website_default_lang_id_fkey                                    | website                                                       | FOREIGN KEY (default_lang_id) REFERENCES res_lang(id) ON DELETE RESTRICT
 website_user_id_fkey                                            | website                                                       | FOREIGN KEY (user_id) REFERENCES res_users(id) ON DELETE RESTRICT
 website_theme_id_fkey                                           | website                                                       | FOREIGN KEY (theme_id) REFERENCES ir_module_module(id) ON DELETE SET NULL
 website_create_uid_fkey                                         | website                                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_configurator_feature_page_view_id_fkey                  | website_configurator_feature                                  | FOREIGN KEY (page_view_id) REFERENCES ir_ui_view(id) ON DELETE CASCADE
 website_configurator_feature_pkey                               | website_configurator_feature                                  | PRIMARY KEY (id)
 website_configurator_feature_write_uid_fkey                     | website_configurator_feature                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_configurator_feature_create_uid_fkey                    | website_configurator_feature                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_configurator_feature_module_id_fkey                     | website_configurator_feature                                  | FOREIGN KEY (module_id) REFERENCES ir_module_module(id) ON DELETE CASCADE
 website_controller_page_view_id_fkey                            | website_controller_page                                       | FOREIGN KEY (view_id) REFERENCES ir_ui_view(id) ON DELETE CASCADE
 website_controller_page_unique_name_slugified                   | website_controller_page                                       | UNIQUE (name_slugified)
 website_controller_page_write_uid_fkey                          | website_controller_page                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_controller_page_record_view_id_fkey                     | website_controller_page                                       | FOREIGN KEY (record_view_id) REFERENCES ir_ui_view(id) ON DELETE CASCADE
 website_controller_page_website_id_fkey                         | website_controller_page                                       | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE CASCADE
 website_controller_page_create_uid_fkey                         | website_controller_page                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_controller_page_pkey                                    | website_controller_page                                       | PRIMARY KEY (id)
 website_custom_blocked_third_party_domains_pkey                 | website_custom_blocked_third_party_domains                    | PRIMARY KEY (id)
 website_custom_blocked_third_party_domains_create_uid_fkey      | website_custom_blocked_third_party_domains                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_custom_blocked_third_party_domains_write_uid_fkey       | website_custom_blocked_third_party_domains                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_lang_rel_pkey                                           | website_lang_rel                                              | PRIMARY KEY (website_id, lang_id)
 website_lang_rel_lang_id_fkey                                   | website_lang_rel                                              | FOREIGN KEY (lang_id) REFERENCES res_lang(id) ON DELETE CASCADE
 website_lang_rel_website_id_fkey                                | website_lang_rel                                              | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE CASCADE
 website_menu_write_uid_fkey                                     | website_menu                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_menu_theme_template_id_fkey                             | website_menu                                                  | FOREIGN KEY (theme_template_id) REFERENCES theme_website_menu(id) ON DELETE SET NULL
 website_menu_pkey                                               | website_menu                                                  | PRIMARY KEY (id)
 website_menu_page_id_fkey                                       | website_menu                                                  | FOREIGN KEY (page_id) REFERENCES website_page(id) ON DELETE CASCADE
 website_menu_controller_page_id_fkey                            | website_menu                                                  | FOREIGN KEY (controller_page_id) REFERENCES website_controller_page(id) ON DELETE CASCADE
 website_menu_website_id_fkey                                    | website_menu                                                  | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE CASCADE
 website_menu_parent_id_fkey                                     | website_menu                                                  | FOREIGN KEY (parent_id) REFERENCES website_menu(id) ON DELETE CASCADE
 website_menu_create_uid_fkey                                    | website_menu                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_page_view_id_fkey                                       | website_page                                                  | FOREIGN KEY (view_id) REFERENCES ir_ui_view(id) ON DELETE CASCADE
 website_page_website_id_fkey                                    | website_page                                                  | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE CASCADE
 website_page_theme_template_id_fkey                             | website_page                                                  | FOREIGN KEY (theme_template_id) REFERENCES theme_website_page(id) ON DELETE SET NULL
 website_page_pkey                                               | website_page                                                  | PRIMARY KEY (id)
 website_page_write_uid_fkey                                     | website_page                                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_page_create_uid_fkey                                    | website_page                                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_page_properties_website_id_fkey                         | website_page_properties                                       | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE CASCADE
 website_page_properties_create_uid_fkey                         | website_page_properties                                       | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_page_properties_pkey                                    | website_page_properties                                       | PRIMARY KEY (id)
 website_page_properties_write_uid_fkey                          | website_page_properties                                       | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_page_properties_target_model_id_fkey                    | website_page_properties                                       | FOREIGN KEY (target_model_id) REFERENCES website_page(id) ON DELETE SET NULL
 website_page_properties_base_website_id_fkey                    | website_page_properties_base                                  | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE CASCADE
 website_page_properties_base_pkey                               | website_page_properties_base                                  | PRIMARY KEY (id)
 website_page_properties_base_write_uid_fkey                     | website_page_properties_base                                  | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_page_properties_base_create_uid_fkey                    | website_page_properties_base                                  | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_rewrite_route_id_fkey                                   | website_rewrite                                               | FOREIGN KEY (route_id) REFERENCES website_route(id) ON DELETE SET NULL
 website_rewrite_write_uid_fkey                                  | website_rewrite                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_rewrite_create_uid_fkey                                 | website_rewrite                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_rewrite_pkey                                            | website_rewrite                                               | PRIMARY KEY (id)
 website_rewrite_website_id_fkey                                 | website_rewrite                                               | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE CASCADE
 website_robots_write_uid_fkey                                   | website_robots                                                | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_robots_create_uid_fkey                                  | website_robots                                                | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_robots_pkey                                             | website_robots                                                | PRIMARY KEY (id)
 website_route_write_uid_fkey                                    | website_route                                                 | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_route_pkey                                              | website_route                                                 | PRIMARY KEY (id)
 website_route_create_uid_fkey                                   | website_route                                                 | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_snippet_filter_website_id_fkey                          | website_snippet_filter                                        | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE CASCADE
 website_snippet_filter_create_uid_fkey                          | website_snippet_filter                                        | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_snippet_filter_filter_id_fkey                           | website_snippet_filter                                        | FOREIGN KEY (filter_id) REFERENCES ir_filters(id) ON DELETE CASCADE
 website_snippet_filter_action_server_id_fkey                    | website_snippet_filter                                        | FOREIGN KEY (action_server_id) REFERENCES ir_act_server(id) ON DELETE CASCADE
 website_snippet_filter_write_uid_fkey                           | website_snippet_filter                                        | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_snippet_filter_pkey                                     | website_snippet_filter                                        | PRIMARY KEY (id)
 website_track_visitor_id_fkey                                   | website_track                                                 | FOREIGN KEY (visitor_id) REFERENCES website_visitor(id) ON DELETE CASCADE
 website_track_page_id_fkey                                      | website_track                                                 | FOREIGN KEY (page_id) REFERENCES website_page(id) ON DELETE CASCADE
 website_track_pkey                                              | website_track                                                 | PRIMARY KEY (id)
 website_visitor_write_uid_fkey                                  | website_visitor                                               | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_visitor_access_token_unique                             | website_visitor                                               | UNIQUE (access_token)
 website_visitor_partner_id_fkey                                 | website_visitor                                               | FOREIGN KEY (partner_id) REFERENCES res_partner(id) ON DELETE SET NULL
 website_visitor_country_id_fkey                                 | website_visitor                                               | FOREIGN KEY (country_id) REFERENCES res_country(id) ON DELETE SET NULL
 website_visitor_lang_id_fkey                                    | website_visitor                                               | FOREIGN KEY (lang_id) REFERENCES res_lang(id) ON DELETE SET NULL
 website_visitor_create_uid_fkey                                 | website_visitor                                               | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 website_visitor_pkey                                            | website_visitor                                               | PRIMARY KEY (id)
 website_visitor_website_id_fkey                                 | website_visitor                                               | FOREIGN KEY (website_id) REFERENCES website(id) ON DELETE SET NULL
 whatsapp_account_phone_uid_unique                               | whatsapp_account                                              | UNIQUE (phone_uid)
 whatsapp_account_write_uid_fkey                                 | whatsapp_account                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 whatsapp_account_create_uid_fkey                                | whatsapp_account                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 whatsapp_account_pkey                                           | whatsapp_account                                              | PRIMARY KEY (id)
 whatsapp_composer_pkey                                          | whatsapp_composer                                             | PRIMARY KEY (id)
 whatsapp_composer_write_uid_fkey                                | whatsapp_composer                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 whatsapp_composer_create_uid_fkey                               | whatsapp_composer                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 whatsapp_composer_wa_template_id_fkey                           | whatsapp_composer                                             | FOREIGN KEY (wa_template_id) REFERENCES whatsapp_template(id) ON DELETE SET NULL
 whatsapp_composer_attachment_id_fkey                            | whatsapp_composer                                             | FOREIGN KEY (attachment_id) REFERENCES ir_attachment(id) ON DELETE SET NULL
 whatsapp_message_create_uid_fkey                                | whatsapp_message                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 whatsapp_message_wa_account_id_fkey                             | whatsapp_message                                              | FOREIGN KEY (wa_account_id) REFERENCES whatsapp_account(id) ON DELETE SET NULL
 whatsapp_message_parent_id_fkey                                 | whatsapp_message                                              | FOREIGN KEY (parent_id) REFERENCES whatsapp_message(id) ON DELETE SET NULL
 whatsapp_message_mail_message_id_fkey                           | whatsapp_message                                              | FOREIGN KEY (mail_message_id) REFERENCES mail_message(id) ON DELETE SET NULL
 whatsapp_message_write_uid_fkey                                 | whatsapp_message                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 whatsapp_message_pkey                                           | whatsapp_message                                              | PRIMARY KEY (id)
 whatsapp_message_wa_template_id_fkey                            | whatsapp_message                                              | FOREIGN KEY (wa_template_id) REFERENCES whatsapp_template(id) ON DELETE SET NULL
 whatsapp_message_unique_msg_uid                                 | whatsapp_message                                              | UNIQUE (msg_uid)
 whatsapp_preview_pkey                                           | whatsapp_preview                                              | PRIMARY KEY (id)
 whatsapp_preview_write_uid_fkey                                 | whatsapp_preview                                              | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 whatsapp_preview_create_uid_fkey                                | whatsapp_preview                                              | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 whatsapp_preview_wa_template_id_fkey                            | whatsapp_preview                                              | FOREIGN KEY (wa_template_id) REFERENCES whatsapp_template(id) ON DELETE SET NULL
 whatsapp_template_pkey                                          | whatsapp_template                                             | PRIMARY KEY (id)
 whatsapp_template_write_uid_fkey                                | whatsapp_template                                             | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 whatsapp_template_create_uid_fkey                               | whatsapp_template                                             | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 whatsapp_template_report_id_fkey                                | whatsapp_template                                             | FOREIGN KEY (report_id) REFERENCES ir_act_report_xml(id) ON DELETE SET NULL
 whatsapp_template_model_id_fkey                                 | whatsapp_template                                             | FOREIGN KEY (model_id) REFERENCES ir_model(id) ON DELETE CASCADE
 whatsapp_template_wa_account_id_fkey                            | whatsapp_template                                             | FOREIGN KEY (wa_account_id) REFERENCES whatsapp_account(id) ON DELETE CASCADE
 whatsapp_template_unique_name_account_template                  | whatsapp_template                                             | UNIQUE (template_name, lang_code, wa_account_id)
 whatsapp_template_button_wa_template_id_fkey                    | whatsapp_template_button                                      | FOREIGN KEY (wa_template_id) REFERENCES whatsapp_template(id) ON DELETE CASCADE
 whatsapp_template_button_pkey                                   | whatsapp_template_button                                      | PRIMARY KEY (id)
 whatsapp_template_button_write_uid_fkey                         | whatsapp_template_button                                      | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 whatsapp_template_button_unique_name_per_template               | whatsapp_template_button                                      | UNIQUE (name, wa_template_id)
 whatsapp_template_button_create_uid_fkey                        | whatsapp_template_button                                      | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 whatsapp_template_variable_write_uid_fkey                       | whatsapp_template_variable                                    | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 whatsapp_template_variable_name_type_template_unique            | whatsapp_template_variable                                    | UNIQUE (name, line_type, wa_template_id, button_id)
 whatsapp_template_variable_pkey                                 | whatsapp_template_variable                                    | PRIMARY KEY (id)
 whatsapp_template_variable_button_id_fkey                       | whatsapp_template_variable                                    | FOREIGN KEY (button_id) REFERENCES whatsapp_template_button(id) ON DELETE CASCADE
 whatsapp_template_variable_wa_template_id_fkey                  | whatsapp_template_variable                                    | FOREIGN KEY (wa_template_id) REFERENCES whatsapp_template(id) ON DELETE CASCADE
 whatsapp_template_variable_create_uid_fkey                      | whatsapp_template_variable                                    | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 wizard_ir_model_menu_create_write_uid_fkey                      | wizard_ir_model_menu_create                                   | FOREIGN KEY (write_uid) REFERENCES res_users(id) ON DELETE SET NULL
 wizard_ir_model_menu_create_menu_id_fkey                        | wizard_ir_model_menu_create                                   | FOREIGN KEY (menu_id) REFERENCES ir_ui_menu(id) ON DELETE CASCADE
 wizard_ir_model_menu_create_create_uid_fkey                     | wizard_ir_model_menu_create                                   | FOREIGN KEY (create_uid) REFERENCES res_users(id) ON DELETE SET NULL
 wizard_ir_model_menu_create_pkey                                | wizard_ir_model_menu_create                                   | PRIMARY KEY (id)
 x_project_task_res_partner_rel_pkey                             | x_project_task_res_partner_rel                                | PRIMARY KEY (project_task_id, res_partner_id)
 x_project_task_res_partner_rel_project_task_id_fkey             | x_project_task_res_partner_rel                                | FOREIGN KEY (project_task_id) REFERENCES project_task(id) ON DELETE CASCADE
 x_project_task_res_partner_rel_res_partner_id_fkey              | x_project_task_res_partner_rel                                | FOREIGN KEY (res_partner_id) REFERENCES res_partner(id) ON DELETE CASCADE
(4808 rows)

