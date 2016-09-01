-- View: materials_list_view

--DROP VIEW materials_list_view;

CREATE OR REPLACE VIEW materials_list_view AS 
 SELECT
	m.id,
	m.name,
	format_money(m.price) AS price,
	m.for_sale, 
    m.material_group_id,
	m.margin_percent::text||' %' AS margin_percent,
	0::numeric AS procur_quant,
	''::text AS procur_avg_price,
	''::text AS recom_price,
	''::text AS balance
	
 FROM materials AS m
 ORDER BY m.name;

ALTER TABLE materials_list_view
  OWNER TO bellagio;

