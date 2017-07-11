-- Function: material_list_with_balance(integer, integer)

--DROP FUNCTION material_list_for_sale(integer);

CREATE OR REPLACE FUNCTION material_list_for_sale(IN in_store_id integer)
  RETURNS TABLE(id integer, name text, price text, quant numeric, group_id int, group_name text, quant_descr text,item_type int) AS
$BODY$
	SELECT
		m.id,
		m.name::text,
		format_rub(m.price) AS price,
		coalesce(b.quant,0) AS quant,
		gr.id AS group_id,
		gr.name::text AS group_name,
		CASE 
			WHEN b.quant IS NULL OR b.quant=0 THEN ''
			ELSE round(b.quant)::text || ' шт.'
		END AS quant_descr,
		1 AS item_type
	FROM materials AS m
	LEFT JOIN 
		(SELECT rg.material_id,SUM(rg.quant) AS quant
		FROM rg_materials_balance(ARRAY[$1],'{}') AS rg
		GROUP BY rg.material_id
		) AS b
		ON b.material_id=m.id
	LEFT JOIN material_groups AS gr ON gr.id=m.material_group_id
	WHERE m.for_sale=TRUE AND m.price>0
	ORDER BY
		m.material_group_id,
		m.name;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION material_list_for_sale(integer)
  OWNER TO bellagio;
