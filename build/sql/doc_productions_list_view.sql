-- View: doc_productions_list_view

DROP VIEW doc_productions_list_view;

CREATE OR REPLACE VIEW doc_productions_list_view AS 
	SELECT
		doc_p.id,
		doc_p.number,
		doc_p.date_time, 		
		doc_p.processed, 		
		doc_p.on_norm,
		
		doc_p.store_id,
		st.name AS store_descr, 
		
		doc_p.user_id,
		u.name AS user_descr,
		
		doc_p.product_id, 
		p.name AS product_descr,
		
		doc_p.quant,
		ROUND(doc_p.price*doc_p.quant,2) AS price,
		
		doc_p.material_retail_cost AS material_retail_cost,
		
		doc_p.material_cost AS material_cost,
		
		(doc_p.price*doc_p.quant)-doc_p.material_cost AS income,
		
		CASE WHEN doc_p.material_cost IS NOT NULL AND doc_p.material_cost>0 THEN
			ROUND((doc_p.price*doc_p.quant)/doc_p.material_cost*100-100,2)
		ELSE 0
		END
		AS income_percent,
		
		doc_p.florist_comment,
		
		now()-doc_p.date_time AS after_prod_interval
		
	FROM doc_productions doc_p
	LEFT JOIN products p ON p.id = doc_p.product_id
	LEFT JOIN users u ON u.id = doc_p.user_id
	LEFT JOIN stores st ON st.id = doc_p.store_id
   
  ORDER BY doc_p.date_time;

ALTER TABLE doc_productions_list_view
  OWNER TO bellagio;

