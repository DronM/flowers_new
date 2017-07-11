-- View: doc_expences_t_tmp_expence_types_list

--DROP VIEW doc_expences_t_tmp_expence_types_list;

CREATE OR REPLACE VIEW doc_expences_t_tmp_expence_types_list AS 
	SELECT
		doc.view_id,
		doc.line_number,		
		doc.login_id,
		doc.expence_type_id,
		ext.name AS expence_type_descr,
		doc.expence_comment,
		doc.expence_date,
		doc.total
		
	FROM doc_expences_t_tmp_expence_types doc
	LEFT JOIN expence_types ext ON ext.id = doc.expence_type_id
	ORDER BY doc.line_number;

ALTER TABLE doc_expences_t_tmp_expence_types_list
  OWNER TO bellagio;
