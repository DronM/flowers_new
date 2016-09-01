/*
INSERT INTO
doc_product_disposals
(date_time,store_id,doc_production_id,processed)
(
SELECT
	now()::timestamp,
	b.store_id,
	b.doc_production_id,
	true
FROM rg_products_balance('{}','{}','{}') b
WHERE
	doc_production_id NOT IN (
(SELECT id FROM doc_productions WHERE doc_productions.number='7443'),
(SELECT id FROM doc_productions WHERE doc_productions.number='7451'),
(SELECT id FROM doc_productions WHERE doc_productions.number='7444'),
(SELECT id FROM doc_productions WHERE doc_productions.number='7448'),
(SELECT id FROM doc_productions WHERE doc_productions.number='7447'),
(SELECT id FROM doc_productions WHERE doc_productions.number='7449'),
(SELECT id FROM doc_productions WHERE doc_productions.number='7450'),
(SELECT id FROM doc_productions WHERE doc_productions.number='7343'),
(SELECT id FROM doc_productions WHERE doc_productions.number='7446'),
(SELECT id FROM doc_productions WHERE doc_productions.number='7445')
)
--LIMIT 1
)

*/
UPDATE  doc_product_disposals SET processed=true where date_time>'2015-08-06'
--DELETE FROM doc_product_disposals where date_time>'2015-08-06'


--SELECT id FROM doc_productions WHERE number='8210'
SELECT
	materials.name,
	ra_materials.quant,
	ra_materials.cost,
	doc_material_procurements.number,
	date8_descr(doc_material_procurements.date_time::date),
	ra_materials.doc_procurement_id,
	(SELECT t.price FROM doc_material_procurements_t_materials t WHERE t.doc_id=ra_materials.doc_procurement_id AND t.material_id=ra_materials.material_id)
FROM ra_materials
LEFT JOIN materials ON materials.id=ra_materials.material_id
LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
WHERE doc_id=9363 AND doc_type='production'


SELECT
	p.name,
	d_p.number,
	date8_time5_descr(d_p.date_time),
	m.name,
	ra.quant,
	ra.cost
FROM rg_products_balance('{}','{}','{}') AS b
LEFT JOIN products AS p ON p.id=b.product_id
LEFT JOIN ra_materials AS ra ON ra.doc_type='production' AND ra.doc_id=b.doc_production_id
LEFT JOIN materials AS m ON m.id=ra.material_id
LEFT JOIN doc_productions AS d_p ON d_p.id=b.doc_production_id
WHERE ra.material_id = 656
ORDER BY p.name,m.name