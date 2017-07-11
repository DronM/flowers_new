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


CREATE TYPE RefTypeKey AS (
    id  text,
    val	text
);


CREATE TYPE RefType AS (
    keys       RefTypeKey[],
    descr	text
);

-- Function: const_def_client_val()

 DROP FUNCTION const_def_client_val();

CREATE OR REPLACE FUNCTION const_def_client_val()
  --RETURNS reftype AS
  RETURNS int AS 
$BODY$
	SELECT val::Int AS val FROM const_def_store LIMIT 1;
	/*
	SELECT
		(
			ARRAY[('id',const_def_client.val::text)::RefTypeKey],
			clients.name::text
		)::RefType
	FROM const_def_client
	LEFT JOIN clients ON clients.id=val::int
	LIMIT 1;
	*/
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION const_def_client_val()
  OWNER TO bellagio;



--***************************** ИСПРАВЛЕНИЕ ЛОГА ДОКУМЕНТОВ
UPDATE doc_log
SET date_time = sub.date_time
FROM (
SELECT l.id,p.date_time FROM doc_log l
LEFT JOIN doc_productions p ON p.id=l.doc_id
WHERE l.doc_type='production' AND p.date_time<>l.date_time
) AS sub
WHERE sub.id=doc_log.id


