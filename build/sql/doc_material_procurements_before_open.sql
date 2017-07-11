-- Function: doc_material_procurements_before_open(varchar(32),integer, integer)

-- DROP FUNCTION doc_material_procurements_before_open(varchar(32),integer, integer);

CREATE OR REPLACE FUNCTION doc_material_procurements_before_open(in_view_id varchar(32), in_login_id integer, in_doc_id integer)
  RETURNS void AS
$BODY$
BEGIN
	--RAISE EXCEPTION 'in_login_id=%',in_login_id;
	DELETE FROM doc_material_procurements_t_tmp_materials WHERE view_id=in_view_id;
	
	IF (in_doc_id IS NOT NULL AND in_doc_id>0) THEN
		INSERT INTO doc_material_procurements_t_tmp_materials
		(view_id,login_id,line_number,material_id,quant,price,total)
		(SELECT in_view_id,in_login_id
		,line_number,material_id,quant,price,total					
		FROM doc_material_procurements_t_materials
		WHERE doc_id=in_doc_id);
	END IF;
	
END;
$BODY$
--plpgsql
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_material_procurements_before_open(varchar(32),integer, integer)
  OWNER TO bellagio;

