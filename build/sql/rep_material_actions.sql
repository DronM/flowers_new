-- View: rep_material_actions

DROP VIEW rep_material_actions;

CREATE OR REPLACE VIEW rep_material_actions AS 
	SELECT
		ra.date_time,
		--салон
		ra.store_id,
		st.name AS store_descr,
		
		--поставка
		ra.doc_procurement_id,
		doc_descr('material_procurement',
			proc.number::text,
			proc.date_time) AS doc_procurement_descr,

		--группа
		m.material_group_id,
		mg.name AS material_group_descr,

		--материал
		ra.material_id,
		m.name AS material_descr,
		
		--документ движения
		ra.doc_id AS ra_doc_id,
		CASE ra.doc_type
			WHEN 'material_disposal' THEN
				doc_descr(ra.doc_type,
					doc_material_disposals.number::text,
					doc_material_disposals.date_time)
			WHEN 'material_procurement' THEN
				doc_descr(ra.doc_type,
					doc_material_procurements.number::text,
					doc_material_procurements.date_time)
			WHEN 'production' THEN
				doc_descr(ra.doc_type,
					doc_productions.number::text,
					doc_productions.date_time)
			WHEN 'sale' THEN
				doc_descr(ra.doc_type,
					doc_sales.number::text,
					doc_sales.date_time)
		END AS ra_doc_descr,
		
		--количество
		CASE ra.deb
			WHEN TRUE THEN ra.quant
			ELSE 0
		END AS quant_deb,
		CASE ra.deb
			WHEN TRUE THEN 0
			ELSE ra.quant
		END AS quant_kred,
		
		--стоимость
		CASE ra.deb
			WHEN TRUE THEN ra.cost
			ELSE 0
		END AS cost_deb,
		CASE ra.deb
			WHEN TRUE THEN 0
			ELSE ra.cost
		END AS cost_kred
		
	FROM ra_materials AS ra
	LEFT JOIN materials AS m ON m.id=ra.material_id
	LEFT JOIN stores AS st ON st.id=ra.store_id
	LEFT JOIN material_groups AS mg ON mg.id=m.material_group_id
	LEFT JOIN doc_material_procurements AS proc ON proc.id=ra.doc_procurement_id
	--списание материалов
	LEFT JOIN doc_material_disposals
		ON ra.doc_type='material_disposal' AND doc_material_disposals.id=ra.doc_id
	--поступление материалов
	LEFT JOIN doc_material_procurements
		ON ra.doc_type='material_procurement' AND doc_material_procurements.id=ra.doc_id
	--Выпуск продукции
	LEFT JOIN doc_productions
		ON ra.doc_type='production' AND doc_productions.id=ra.doc_id
	--Продажа
	LEFT JOIN doc_sales
		ON ra.doc_type='sale' AND doc_sales.id=ra.doc_id
		
	ORDER BY ra.date_time
	;
ALTER TABLE rep_material_actions OWNER TO bellagio;