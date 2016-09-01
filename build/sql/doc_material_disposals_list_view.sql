-- View: doc_material_disposals_list_view

-- DROP VIEW doc_material_disposals_list_view;

CREATE OR REPLACE VIEW doc_material_disposals_list_view AS 
	SELECT
		doc.id,
		doc.number,
		doc.date_time,
		date8_time8_descr(doc.date_time) AS date_time_descr,
		doc.processed,
		doc.store_id,
		st.name AS store_descr,
		doc.user_id,
		u.name AS user_descr,
		doc.explanation,
		ra.cost AS cost,
		format_money(ra.cost) AS cost_descr
		
	FROM doc_material_disposals doc
	LEFT JOIN users u ON u.id = doc.user_id
	LEFT JOIN stores st ON st.id = doc.store_id
	LEFT JOIN
		(SELECT
			ra.doc_id,
			ra.doc_type,
			sum(ra.cost) AS cost
		FROM ra_materials ra
		GROUP BY ra.doc_id,ra.doc_type
		) AS ra ON ra.doc_id = doc.id AND ra.doc_type='material_disposal'
	ORDER BY doc.date_time;

ALTER TABLE doc_material_disposals_list_view
  OWNER TO bellagio;
