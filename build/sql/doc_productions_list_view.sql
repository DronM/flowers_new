-- View: doc_productions_list_view

DROP VIEW doc_productions_list_view;

CREATE OR REPLACE VIEW doc_productions_list_view AS 
	SELECT
		doc_p.id,
		doc_p.number,
		doc_p.date_time, 
		
		doc_p.processed, 
		
		doc_p.store_id,
		doc_p.on_norm,
		
		st.name AS store_descr, 
		
		doc_p.user_id,
		u.name AS user_descr,
		
		doc_p.product_id, 
		p.name AS product_descr,
		doc_p.quant,
		ROUND(doc_p.price*doc_p.quant,2) AS price,
		
		t_mat.sm AS mat_sum,
		
		t_mat.cost AS mat_cost,
		
		/*
		COALESCE(
		(SELECT (b.quant>0) FROM rg_products_balance(
			ARRAY[doc_p.store_id],
			ARRAY[doc_p.product_id],
			ARRAY[doc_p.id]) AS b
		),false) AS rest,
		*/
		
		(doc_p.price*doc_p.quant)-t_mat.cost AS income,
		ROUND((doc_p.price*doc_p.quant)/t_mat.cost*100-100,2) AS income_percent,
		
		doc_p.florist_comment,
		
		now()-doc_p.date_time AS after_prod_interval
		
	FROM doc_productions doc_p
	LEFT JOIN products p ON p.id = doc_p.product_id
	LEFT JOIN users u ON u.id = doc_p.user_id
	LEFT JOIN stores st ON st.id = doc_p.store_id
   
	LEFT JOIN (
		SELECT
			SUM(m.price*t.quant) AS sm,
			t.doc_id,
			(SELECT SUM(ra.cost) FROM ra_materials ra WHERE ra.doc_id=t.doc_id AND ra.doc_type='production') AS cost
		FROM doc_productions_t_materials as t
		LEFT JOIN materials AS m ON m.id=t.material_id
		LEFT JOIN doc_productions AS h ON h.id=t.doc_id
		GROUP BY t.doc_id
   	) t_mat ON t_mat.doc_id = doc_p.id
   
  ORDER BY doc_p.date_time;

ALTER TABLE doc_productions_list_view
  OWNER TO bellagio;

