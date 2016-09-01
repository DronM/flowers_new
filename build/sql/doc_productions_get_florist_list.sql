-- Function: doc_productions_get_florist_list(integer, integer)

DROP FUNCTION doc_productions_get_florist_list(integer, integer);

CREATE OR REPLACE FUNCTION doc_productions_get_florist_list(IN in_login_id integer, IN in_store_id integer)
  RETURNS TABLE(line_number integer, login_id integer, material_id integer, material_descr text, quant numeric, quant_norm numeric, quant_waste numeric, quant_b_main numeric, quant_b_waste numeric) AS
$BODY$
BEGIN
	RETURN QUERY
	SELECT  doc_p_m.line_number,
		in_login_id AS login_id,
		doc_p_m.material_id, 
		m.name::text AS material_descr,
		COALESCE(ROUND(doc_p_m.quant),0),
		COALESCE(ROUND(doc_p_m.quant_norm),0),
		COALESCE(ROUND(doc_p_m.quant_waste),0),
		COALESCE(ROUND(b_main.quant), 0::numeric) AS quant_b_main, 
		COALESCE(ROUND(b_waste.quant), 0::numeric) AS quant_b_waste
	FROM doc_productions_t_tmp_materials doc_p_m
	LEFT JOIN materials m ON m.id = doc_p_m.material_id
	LEFT JOIN 
		(SELECT rg_main.material_id, SUM(rg_main.quant) AS quant, SUM(rg_main.cost) AS cost 
		FROM rg_materials_balance(ARRAY[in_store_id], ARRAY['main'::stock_types], '{}'::integer[],'{}'::integer[]) AS rg_main
		GROUP BY rg_main.material_id
		) AS b_main ON b_main.material_id = doc_p_m.material_id
	LEFT JOIN 
		(SELECT rg_waste.material_id, SUM(rg_waste.quant) AS quant, SUM(rg_waste.cost) AS cost 
		FROM rg_materials_balance(ARRAY[in_store_id], ARRAY['waste'::stock_types], '{}'::integer[],'{}'::integer[]) AS rg_waste
		GROUP BY rg_waste.material_id
		) AS b_waste ON b_waste.material_id = doc_p_m.material_id
	WHERE doc_p_m.login_id = in_login_id
	ORDER BY doc_p_m.line_number;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION doc_productions_get_florist_list(integer, integer)
  OWNER TO postgres;
