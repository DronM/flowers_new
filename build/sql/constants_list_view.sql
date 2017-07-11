-- View: constants_list_view

-- DROP VIEW constants_list_view;

CREATE OR REPLACE VIEW constants_list_view AS 
 SELECT 'sale_item_cols'::text AS id,
    const_sale_item_cols_view.name,
    const_sale_item_cols_view.descr,
    const_sale_item_cols_view.val_descr,
    const_sale_item_cols_view.val_type,
    0 AS val_id
   FROM const_sale_item_cols_view
UNION ALL
 SELECT 'def_store'::text AS id,
    const_def_store_view.name,
    const_def_store_view.descr,
    const_def_store_view.val_descr,
    const_def_store_view.val_type,
    const_def_store_view.val_id
   FROM const_def_store_view
UNION ALL
 SELECT 'doc_per_page_count'::text AS id,
    const_doc_per_page_count_view.name,
    const_doc_per_page_count_view.descr,
    const_doc_per_page_count_view.val_descr,
    const_doc_per_page_count_view.val_type,
    0 AS val_id
   FROM const_doc_per_page_count_view
UNION ALL
 SELECT 'grid_refresh_interval'::text AS id,
    const_grid_refresh_interval_view.name,
    const_grid_refresh_interval_view.descr,
    const_grid_refresh_interval_view.val_descr,
    const_grid_refresh_interval_view.val_type,
    0 AS val_id
   FROM const_grid_refresh_interval_view
UNION ALL
 SELECT 'shift_length_time'::text AS id,
    const_shift_length_time_view.name,
    const_shift_length_time_view.descr,
    const_shift_length_time_view.val_descr,
    const_shift_length_time_view.val_type,
    0 AS val_id
   FROM const_shift_length_time_view
UNION ALL
 SELECT 'shift_start_time'::text AS id,
    const_shift_start_time_view.name,
    const_shift_start_time_view.descr,
    const_shift_start_time_view.val_descr,
    const_shift_start_time_view.val_type,
    0 AS val_id
   FROM const_shift_start_time_view
UNION ALL
 SELECT 'cel_phone_for_sms'::text AS id,
    const_cel_phone_for_sms_view.name,
    const_cel_phone_for_sms_view.descr,
    const_cel_phone_for_sms_view.val_descr,
    const_cel_phone_for_sms_view.val_type,
    0 AS val_id
   FROM const_cel_phone_for_sms_view
UNION ALL
 SELECT 'negat_material_balance_restrict'::text AS id,
    const_negat_material_balance_restrict_view.name,
    const_negat_material_balance_restrict_view.descr,
    const_negat_material_balance_restrict_view.val_descr,
    const_negat_material_balance_restrict_view.val_type,
    0 AS val_id
   FROM const_negat_material_balance_restrict_view
UNION ALL
 SELECT 'negat_product_balance_restrict'::text AS id,
    const_negat_product_balance_restrict_view.name,
    const_negat_product_balance_restrict_view.descr,
    const_negat_product_balance_restrict_view.val_descr,
    const_negat_product_balance_restrict_view.val_type,
    0 AS val_id
   FROM const_negat_product_balance_restrict_view
UNION ALL
 SELECT 'def_material_group'::text AS id,
    const_def_material_group_view.name,
    const_def_material_group_view.descr,
    const_def_material_group_view.val_descr,
    const_def_material_group_view.val_type,
    0 AS val_id
   FROM const_def_material_group_view
UNION ALL
 SELECT 'def_payment_type_for_sale'::text AS id,
    const_def_payment_type_for_sale_view.name,
    const_def_payment_type_for_sale_view.descr,
    const_def_payment_type_for_sale_view.val_descr,
    const_def_payment_type_for_sale_view.val_type,
    const_def_payment_type_for_sale_view.val_id
   FROM const_def_payment_type_for_sale_view
UNION ALL
 SELECT 'def_client'::text AS id,
    const_def_client_view.name,
    const_def_client_view.descr,
    const_def_client_view.val_descr,
    const_def_client_view.val_type,
    const_def_client_view.val_id
   FROM const_def_client_view
UNION ALL
 SELECT 'def_discount'::text AS id,
    const_def_discount_view.name,
    const_def_discount_view.descr,
    const_def_discount_view.val_descr,
    const_def_discount_view.val_type,
    const_def_discount_view.val_id
   FROM const_def_discount_view
UNION ALL
 SELECT 'session_live_time'::text AS id,
    const_session_live_time_view.name,
    const_session_live_time_view.descr,
    const_session_live_time_view.val_descr,
    const_session_live_time_view.val_type,
    0 AS val_id
   FROM const_session_live_time_view;

ALTER TABLE constants_list_view
  OWNER TO bellagio;

