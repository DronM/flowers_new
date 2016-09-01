-- View: receipts_list_view

--DROP VIEW receipts_list_view;

CREATE OR REPLACE VIEW receipts_list_view AS 
 SELECT receipts.user_id,
    receipts.item_id,
    receipts.item_type,
        CASE
            WHEN receipts.item_type = 1 THEN receipts.item_name::text
            ELSE (receipts.item_name::text || ', код:'::text) || doc_prod.number::text
        END AS item_name,
    round(receipts.quant) AS quant,
    format_money(receipts.total) AS total_descr,
    receipts.total,
    receipts.doc_production_id,
	receipts.disc_percent,
	receipts.price_no_disc
   FROM receipts
     LEFT JOIN doc_productions doc_prod ON doc_prod.id = receipts.doc_production_id
  ORDER BY receipts.ord;

ALTER TABLE receipts_list_view
  OWNER TO bellagio;
