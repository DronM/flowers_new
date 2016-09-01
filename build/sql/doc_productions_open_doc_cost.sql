-- Function: doc_productions_open_doc_cost(integer)

--DROP FUNCTION doc_productions_open_doc_cost(int,int);

CREATE OR REPLACE FUNCTION doc_productions_open_doc_cost(IN in_store_id int,IN in_login_id int)
  RETURNS numeric AS
$BODY$
DECLARE res numeric(15,2);
BEGIN
	SELECT
		/*
		SUM( 
		CASE 
			WHEN rg.quant=0 THEN 0
			ELSE rg.cost/rg.quant*mat.quant
		END) INTO res
		*/
		COALESCE(SUM(m_list.price*mat.quant),0) INTO res
	FROM doc_productions_t_tmp_materials AS mat
	--LEFT JOIN rg_material_costs AS rg ON rg.store_id=in_store_id AND rg.material_id=mat.material_id AND rg.date_time=reg_current_balance_time()
	LEFT JOIN materials AS m_list ON m_list.id=mat.material_id
	WHERE mat.login_id=in_login_id;

	RETURN res;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_productions_open_doc_cost(int,int)
  OWNER TO postgres;
