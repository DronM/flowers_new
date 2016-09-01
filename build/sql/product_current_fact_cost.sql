-- DROP FUNCTION product_current_fact_cost(integer);

CREATE OR REPLACE FUNCTION product_current_fact_cost(in_doc_production_id integer)
  RETURNS numeric AS
$BODY$
DECLARE res numeric(15,2);
BEGIN
	IF (in_doc_production_id IS NULL OR in_doc_production_id=0) THEN
		RETURN 0;
	END IF;
	
	SELECT
		SUM( 
		CASE 
			WHEN rg.quant=0 THEN 0
			ELSE rg.cost/rg.quant*mat.quant
		END) INTO res
	FROM doc_productions_t_materials AS mat
	LEFT JOIN doc_productions AS doc ON doc.id=mat.doc_id
	LEFT JOIN rg_material_costs AS rg ON rg.store_id=doc.store_id AND rg.material_id=mat.material_id AND rg.date_time=reg_current_balance_time()
	WHERE mat.doc_id=in_doc_production_id;

	RETURN res;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION product_current_fact_cost(integer)
  OWNER TO postgres;
