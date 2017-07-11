-- Function: doc_material_procurements_del_act(in_doc_id int)

-- DROP FUNCTION doc_material_procurements_del_act(doc_material_procurements);

--DROP FUNCTION doc_material_procurements_del_act(in_doc_id int);
 
CREATE OR REPLACE FUNCTION doc_material_procurements_del_act(in_doc_id integer)
  RETURNS void AS
$$
	SELECT ra_materials_remove_acts('material_procurement'::doc_types,in_doc_id);
	
	SELECT seq_viol_materials_set_on_doc('material_procurement'::doc_types,in_doc_id);
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_material_procurements_del_act(in_doc_id int) OWNER TO bellagio;
