-- Function: doc_material_disposals_before_write(varchar(32), integer)

-- DROP FUNCTION doc_material_disposals_before_write(varchar(32), integer);

CREATE OR REPLACE FUNCTION doc_material_disposals_before_write(in_view_id varchar(32), in_doc_id integer)
  RETURNS void AS
$BODY$
	--clear fact table
	DELETE FROM doc_material_disposals_t_materials WHERE doc_id=in_doc_id;
	
	--copy data from temp to fact table
	INSERT INTO doc_material_disposals_t_materials
	(doc_id,line_number,material_id,quant)
	(SELECT in_doc_id
	,line_number,material_id,quant					
	FROM doc_material_disposals_t_tmp_materials
	WHERE view_id=in_view_id);				
	
	--clear temp table
	DELETE FROM doc_material_disposals_t_tmp_materials WHERE view_id=in_view_id;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_material_disposals_before_write(varchar(32), integer)
  OWNER TO bellagio;

