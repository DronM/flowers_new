UPDATE doc_sales
	SET total_material_cost=sub.cost
FROM(
	SELECT
		ra.doc_id,
		SUM(ra.cost) AS cost
	FROM ra_materials ra
	WHERE ra.doc_type='sale'	
	GROUP BY ra.doc_id
) AS sub
WHERE doc_sales.id=sub.doc_id


--*****************
UPDATE doc_sales
	SET total_product_cost=sub.cost
FROM(

SELECT
	ra.doc_id,
	SUM(ra_m.cost) AS cost
	
FROM doc_sales_t_products AS items
LEFT JOIN ra_products AS ra ON ra.doc_id=items.doc_id AND ra.doc_type='sale' AND ra.product_id=items.product_id
LEFT JOIN (
	SELECT 
		ra_m.doc_id,
		ra_m.doc_type,
		SUM(ra_m.cost) AS cost
	FROM ra_materials AS ra_m
	GROUP BY ra_m.doc_id,ra_m.doc_type
) AS ra_m ON ra_m.doc_id=ra.doc_production_id AND ra_m.doc_type='production'
GROUP BY ra.doc_id
) AS sub

WHERE doc_sales.id=sub.doc_id