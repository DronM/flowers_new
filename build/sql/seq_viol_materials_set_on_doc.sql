-- Function: seq_viol_materials_set_on_doc(in_doc_type doc_types, in_doc_id integer)

-- DROP FUNCTION seq_viol_materials_set_on_doc(in_doc_type doc_types, in_doc_id integer)

CREATE OR REPLACE FUNCTION seq_viol_materials_set_on_doc(in_doc_type doc_types, in_doc_id integer)
  RETURNS void AS
$$
	SELECT seq_violation_set_on_doc('materials',in_doc_type, in_doc_id);

$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION seq_viol_materials_set_on_doc(in_doc_type doc_types, in_doc_id integer) OWNER TO bellagio;
