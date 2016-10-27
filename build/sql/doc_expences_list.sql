-- View: doc_expences_list

DROP VIEW doc_expences_list;

CREATE OR REPLACE VIEW doc_expences_list AS 
	SELECT
		doc.id,
		doc.number,
		doc.date_time,
		doc.processed,
		doc.store_id,
		st.name AS store_descr,
		doc.user_id,
		u.name AS user_descr,
		
		COALESCE(doc_lines.total,0) AS total
		
	FROM doc_expences doc
	LEFT JOIN users u ON u.id = doc.user_id
	LEFT JOIN stores st ON st.id = doc.store_id
	LEFT JOIN
		(SELECT
			t.doc_id,
			SUM(t.total) AS total
		FROM doc_expences_t_expence_types t
		GROUP BY t.doc_id
		) AS doc_lines ON doc_lines.doc_id=doc.id
	ORDER BY doc.date_time;

ALTER TABLE doc_expences_list OWNER TO bellagio;
