-- Function: doc_material_procurements_act(in_doc_id int)

-- DROP FUNCTION doc_material_procurements_act(doc_material_procurements);

-- DROP FUNCTION doc_material_procurements_act(in_doc_id int);
 
CREATE OR REPLACE FUNCTION doc_material_procurements_act(in_doc_id integer)
  RETURNS void AS
$$
	SELECT doc_material_procurements_del_act(in_doc_id);
	
	INSERT INTO ra_materials (
		date_time,
		deb,
		doc_type,
		doc_id,
		store_id,
		material_id,
		quant,cost)
	(SELECT
		doc.date_time,
		TRUE,
		'material_procurement'::doc_types,
		doc.id,
		doc.store_id,
		mat.material_id,
		mat.quant,
		mat.total
	FROM doc_material_procurements_t_materials AS mat
	LEFT JOIN doc_material_procurements AS doc ON mat.doc_id=doc.id
	WHERE mat.doc_id=in_doc_id AND doc.processed);
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_material_procurements_act(in_doc_id int) OWNER TO bellagio;
