-- View: doc_productions_materials_list_view

--DROP VIEW doc_productions_materials_list_view;

CREATE OR REPLACE VIEW doc_productions_materials_list_view AS 
 SELECT 
	doc_head.id,
	doc_head.date_time As date_time,
	date8_time8_descr(doc_head.date_time) AS date_time_descr,
	doc_head.number,

	doc_head.store_id,
	s.name AS store_descr,

	doc_head.user_id,
	u.name AS user_descr,
	
	doc_head.on_norm,

	doc_head.product_id AS product_id,
	p.name AS product_descr,

	format_money(doc_head.price * doc_head.quant) AS product_price_descr, 

	format_money(m.price * doc_lines.quant) AS material_sum_descr, 

	COALESCE(ra.cost,0) AS material_cost, 	
	format_money(COALESCE(ra.cost,0)) AS material_cost_descr, 
	
	CASE
		WHEN COALESCE(SUM(ra.cost) OVER (PARTITION BY ra.doc_id),0)=0 THEN 0
		ELSE
		ROUND(
		(doc_head.price * doc_head.quant)*
		(COALESCE(ra.cost,0)/COALESCE(SUM(ra.cost) OVER (PARTITION BY ra.doc_id),0))
		- COALESCE(ra.cost,0)
		,2)
	END	AS income,
	
	format_money(
	CASE
		WHEN COALESCE(SUM(ra.cost) OVER (PARTITION BY ra.doc_id),0)=0 THEN 0
		ELSE
		ROUND(
		(doc_head.price * doc_head.quant)*
		(COALESCE(ra.cost,0)/COALESCE(SUM(ra.cost) OVER (PARTITION BY ra.doc_id),0))
		- COALESCE(ra.cost,0)
		,2)
	END	
	) AS income_descr,
	
	CASE
		WHEN COALESCE(SUM(ra.cost) OVER (PARTITION BY ra.doc_id),0)=0
			OR COALESCE(ra.cost,0)=0 THEN 0
		ELSE
		ROUND(
		(doc_head.price * doc_head.quant)*
		(COALESCE(ra.cost,0)/COALESCE(SUM(ra.cost) OVER (PARTITION BY ra.doc_id),0))
		/ COALESCE(ra.cost,0)*100-100
		,2)
	END	AS income_percent,
	
	doc_lines.material_id,
	m.name AS material_descr,
	
	format_quant(doc_lines.quant) AS quant,
	doc_lines.quant_norm AS quant_norm
	
   FROM doc_productions_t_materials doc_lines
   LEFT JOIN ra_materials AS ra ON ra.doc_id = doc_lines.doc_id AND ra.doc_type='production'::doc_types AND doc_lines.material_id=ra.material_id
   LEFT JOIN doc_productions doc_head ON doc_head.id = doc_lines.doc_id
   LEFT JOIN stores s ON s.id = doc_head.store_id
   LEFT JOIN products p ON p.id = doc_head.product_id
   LEFT JOIN materials m ON m.id = doc_lines.material_id
   LEFT JOIN users u ON u.id = doc_head.user_id
  ORDER BY doc_head.date_time,doc_lines.line_number;

ALTER TABLE doc_productions_materials_list_view
  OWNER TO bellagio;

