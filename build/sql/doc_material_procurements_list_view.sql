-- View: doc_material_procurements_list_view

DROP VIEW doc_material_procurements_list_view;

CREATE OR REPLACE VIEW doc_material_procurements_list_view AS 
	 SELECT
		doc.id,
		doc.number,
		doc.date_time, 
		doc.processed, 
	    doc.store_id,
		st.name AS store_descr,
		doc.user_id,
		u.name AS user_descr, 
	    doc.supplier_id,
		sup.name AS supplier_descr
	    ,(	SELECT
				COALESCE(sum(doc_m.total), 0::numeric) AS t
			FROM doc_material_procurements_t_materials doc_m
			WHERE doc_m.doc_id = doc.id
	) AS total
	
	   FROM doc_material_procurements doc
	   LEFT JOIN users u ON u.id = doc.user_id
	   LEFT JOIN stores st ON st.id = doc.store_id
	   LEFT JOIN suppliers sup ON sup.id = doc.supplier_id
	  ORDER BY doc.date_time;
	
ALTER TABLE doc_material_procurements_list_view OWNER TO bellagio;

