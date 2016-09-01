WITH 
current_doc_log_id AS 
(SELECT id FROM doc_log WHERE doc_id=116 AND doc_type='sale'),

current_doc_material_ids AS 
(SELECT material_id FROM doc_sales_t_materials WHERE doc_id=116)

SELECT doc_log.doc_type,doc_log.doc_id
/*
CASE
	WHEN doc_type='sale' THEN doc_sales_t_materials.material_id
	WHEN doc_type='production' THEN doc_productions_t_materials.material_id
	WHEN doc_type='material_disposal' THEN doc_material_disposals_t_materials.material_id
	WHEN doc_type='material_procurement' THEN doc_material_procurements_t_materials.material_id
END AS t_material_id
*/
FROM doc_log

LEFT JOIN doc_sales_t_materials ON doc_sales_t_materials.doc_id=doc_log.doc_id
LEFT JOIN doc_productions_t_materials ON doc_productions_t_materials.doc_id=doc_log.doc_id
LEFT JOIN doc_material_disposals_t_materials ON doc_material_disposals_t_materials.doc_id=doc_log.doc_id
LEFT JOIN doc_material_procurements_t_materials ON doc_material_procurements_t_materials.doc_id=doc_log.doc_id

WHERE id>(SELECT id FROM current_doc_log_id)
AND doc_type IN ('production','material_procurement','material_disposal','sale')

AND (
CASE
	WHEN doc_type='sale' THEN doc_sales_t_materials.material_id = ANY(ARRAY(SELECT material_id FROM current_doc_material_ids))
	WHEN doc_type='production' THEN doc_productions_t_materials.material_id = ANY(ARRAY(SELECT material_id FROM current_doc_material_ids))
	WHEN doc_type='material_disposal' THEN doc_material_disposals_t_materials.material_id = ANY(ARRAY(SELECT material_id FROM current_doc_material_ids))
	WHEN doc_type='material_procurement' THEN doc_material_procurements_t_materials.material_id = ANY(ARRAY(SELECT material_id FROM current_doc_material_ids))
END	
)
GROUP BY doc_log.doc_type,doc_log.doc_id,doc_log.id
ORDER BY doc_log.id
