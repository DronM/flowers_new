-- View: doc_expences_expence_types_list

--DROP VIEW doc_expences_expence_types_list;

CREATE OR REPLACE VIEW doc_expences_expence_types_list AS 
 SELECT 
	doc_head.id,
	doc_head.date_time As date_time,
	date8_time8_descr(doc_head.date_time) AS date_time_descr,
	doc_head.number,

	doc_head.store_id,
	s.name AS store_descr,

	doc_head.user_id,
	u.name AS user_descr,

	doc_lines.expence_type_id,
	expt.name AS expence_type_descr,
	
	doc_lines.total AS total,
	doc_lines.expence_comment,
	get_month_str(doc_lines.expence_date) AS expence_month
	
   FROM doc_expences_t_expence_types doc_lines
   LEFT JOIN doc_expences doc_head ON doc_head.id = doc_lines.doc_id
   LEFT JOIN stores s ON s.id = doc_head.store_id
   LEFT JOIN expence_types expt ON expt.id = doc_lines.expence_type_id
   LEFT JOIN users u ON u.id = doc_head.user_id
  ORDER BY
	doc_head.date_time,
	doc_lines.line_number;

ALTER TABLE doc_expences_expence_types_list OWNER TO bellagio;

