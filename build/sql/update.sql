
			CREATE TYPE message_types AS ENUM (
			
				'error'			
			,
				'warning'			
			,
				'info'			
						
			);
			ALTER TYPE message_types OWNER TO bellagio;
		
	CREATE OR REPLACE FUNCTION enum_message_types_descr(message_types)
	RETURNS varchar AS $$
		SELECT
		CASE $1
			
			WHEN 'error'::message_types THEN 'Ошибка'
			
			WHEN 'warning'::message_types THEN 'Предупреждение'
			
			WHEN 'info'::message_types THEN 'Информация'
			
			ELSE '---'
		END;		
	$$ LANGUAGE sql;	
	ALTER FUNCTION enum_message_types_descr(message_types) OWNER TO bellagio;
	
	--list view
	CREATE OR REPLACE VIEW enum_list_message_types AS
	
		SELECT 'error'::message_types AS id, enum_message_types_descr('error'::message_types) AS descr
	
		UNION ALL
		
		SELECT 'warning'::message_types AS id, enum_message_types_descr('warning'::message_types) AS descr
	
		UNION ALL
		
		SELECT 'info'::message_types AS id, enum_message_types_descr('info'::message_types) AS descr
	;
	ALTER VIEW enum_list_message_types OWNER TO bellagio;
	
		CREATE TABLE messages
		(id int,message_type message_types NOT NULL,user_id int NOT NULL REFERENCES users(id),require_view bool,subject text NOT NULL,content text,importance_level int,date_time timestamp,CONSTRAINT messages_pkey PRIMARY KEY (id));
		
	CREATE INDEX messages_date_time_idx
	ON messages
	(date_time);

	CREATE INDEX messages_user_id_idx
	ON messages
	(user_id);

		ALTER TABLE messages OWNER TO bellagio;
	
		CREATE TABLE message_recipients
		(id int,message_id int NOT NULL REFERENCES messages(id),for_store_id int REFERENCES stores(id),for_role_id role_types,for_user_id int REFERENCES users(id),CONSTRAINT message_recipients_pkey PRIMARY KEY (id));
		
	CREATE INDEX message_recipients_user_message_idx
	ON message_recipients
	(message_id);

		ALTER TABLE message_recipients OWNER TO bellagio;
	
		CREATE TABLE message_views
		(id serial,message_id int NOT NULL REFERENCES messages(id),user_id int REFERENCES users(id),date_time timestamp,CONSTRAINT message_views_pkey PRIMARY KEY (id));
		
	CREATE INDEX message_recipients_user_message_idx
	ON message_views
	(message_id);

		ALTER TABLE message_views OWNER TO bellagio;
	


DROP VIEW bellagio.client_list_view;
DROP VIEW bellagio.client_dialog;
ALTER TABLE bellagio.clients DROP COLUMN phone_cel;

ALTER TABLE bellagio.clients ADD COLUMN tel character varying(11);


-- View: client_list_view

--DROP VIEW client_list_view;

CREATE OR REPLACE VIEW client_list_view AS 
	SELECT
		cl.id,
		cl.name,
		cl.tel,
		cl.email
	FROM clients AS cl
	ORDER BY cl.name
	;

ALTER TABLE client_list_view OWNER TO bellagio;
  
-- View client_dialog

--DROP VIEW client_dialog;

CREATE OR REPLACE VIEW client_dialog AS 
	SELECT
		cl.id,
		cl.name,
		cl.name_full,
		cl.tel,
		cl.email
	FROM clients AS cl
	;
ALTER TABLE client_dialog
  OWNER TO bellagio;
    
    
-- View: suppliers_list_view

--DROP VIEW suppliers_list_view;

CREATE OR REPLACE VIEW suppliers_list_view AS 
 SELECT suppliers.id,
    suppliers.name,
	suppliers.tel,
	suppliers.email
   FROM suppliers
   ORDER BY suppliers.name
  ;

ALTER TABLE suppliers_list_view
  OWNER TO bellagio;    
  
  
  
-- View: bellagio.user_list_view

-- DROP VIEW bellagio.user_list_view;

CREATE OR REPLACE VIEW user_list_view AS 
 SELECT u.id,
    u.name,
    bellagio.get_role_types_descr(u.role_id) AS role_descr,
    u.store_id,
    u.constrain_to_store,
    st.name AS store_descr
   FROM bellagio.users u
     LEFT JOIN bellagio.stores st ON st.id = u.store_id
  ORDER BY st.name,u.name;

ALTER TABLE bellagio.user_list_view
  OWNER TO bellagio;
  
  
  
-- View: product_list_view

--DROP VIEW product_list_view;

CREATE OR REPLACE VIEW product_list_view AS 
	SELECT
		products.id,
		products.name,
		products.price,
		products.for_sale
	FROM products
	ORDER BY products.name
	;

ALTER TABLE product_list_view OWNER TO bellagio;
  
  
  
  
-- Function: bellagio.product_list_with_balance(integer)

 DROP FUNCTION product_list_with_balance(integer);

CREATE OR REPLACE FUNCTION product_list_with_balance(IN in_store_id integer)
  RETURNS TABLE(
  	code text,
  	id integer,
  	name text,
  	price numeric,
  	total numeric,
  	quant numeric,
  	order_quant numeric,
  	quant_descr text,
  	ord_quant_descr text,
  	after_production_time text
  ) AS
$BODY$
	WITH data AS (
	SELECT 
		d_p.number::text AS code,
		p.id AS id,
		p.name::text AS name,
		d_p.price AS price,
		d_p.price*b_p.quant AS total,
		b_p.quant AS quant,
		b_ord.quant AS order_quant,
		CASE 
		WHEN b_p.quant IS NULL OR b_p.quant=0 THEN ''
		ELSE round(b_p.quant)::text
		END AS quant_descr,
		CASE 
		WHEN b_ord.quant IS NULL OR b_ord.quant=0 THEN ''
		ELSE round(b_ord.quant)::text
		END AS ord_quant_descr,

		--(SELECT product_current_fact_cost(d_p.id))  AS cost,
		--(SELECT product_current_fact_cost(d_p.id))*b_p.quant  AS cost_total,
		now()-d_p.date_time AS after_production_time

	FROM products AS p
	LEFT JOIN rg_products_balance(ARRAY[$1],'{}','{}') AS b_p
	ON b_p.product_id=p.id
	LEFT JOIN rg_product_orders_balance(ARRAY[$1],'{}','{}') AS b_ord
	ON b_ord.product_id=p.id 
	LEFT JOIN doc_productions AS d_p ON d_p.id=b_p.doc_production_id
	WHERE p.for_sale=TRUE AND b_p.quant<>0
	--ORDER BY p.name
	)
	SELECT
		data.code,
		data.id,
		data.name,
		data.price,
		data.total AS total,
		data.quant,
		data.order_quant,
		data.quant_descr,
		data.ord_quant_descr,

		--format_money(data.cost),
		--format_money(data.cost_total),
		interval_descr(data.after_production_time)
	FROM data

	UNION ALL

	SELECT
		NULL,
		NULL,
		NULL,
		NULL,
		SUM(agg.total) AS total,
		NULL,
		NULL,
		NULL,
		NULL,

		--NULL,
		--format_money(SUM(agg.cost_total)),
		interval_descr(AVG(agg.after_production_time))
	FROM data AS agg;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION bellagio.product_list_with_balance(integer)
  OWNER TO bellagio;
  
  
  
-- View: doc_productions_list_view

DROP VIEW doc_productions_list_view;

CREATE OR REPLACE VIEW doc_productions_list_view AS 
	SELECT
		doc_p.id,
		doc_p.number,
		doc_p.date_time, 
		
		doc_p.processed, 
		
		doc_p.store_id,
		doc_p.on_norm,
		
		st.name AS store_descr, 
		
		doc_p.user_id,
		u.name AS user_descr,
		
		doc_p.product_id, 
		p.name AS product_descr,
		doc_p.quant,
		ROUND(doc_p.price*doc_p.quant,2) AS price,
		
		t_mat.sm AS mat_sum,
		
		t_mat.cost AS mat_cost,
		
		/*
		COALESCE(
		(SELECT (b.quant>0) FROM rg_products_balance(
			ARRAY[doc_p.store_id],
			ARRAY[doc_p.product_id],
			ARRAY[doc_p.id]) AS b
		),false) AS rest,
		*/
		
		(doc_p.price*doc_p.quant)-t_mat.cost AS income,
		ROUND((doc_p.price*doc_p.quant)/t_mat.cost*100-100,2) AS income_percent,
		
		doc_p.florist_comment,
		
		now()-doc_p.date_time AS after_prod_interval
		
	FROM doc_productions doc_p
	LEFT JOIN products p ON p.id = doc_p.product_id
	LEFT JOIN users u ON u.id = doc_p.user_id
	LEFT JOIN stores st ON st.id = doc_p.store_id
   
	LEFT JOIN (
		SELECT
			SUM(m.price*t.quant) AS sm,
			t.doc_id,
			(SELECT SUM(ra.cost) FROM ra_materials ra WHERE ra.doc_id=t.doc_id AND ra.doc_type='production') AS cost
		FROM doc_productions_t_materials as t
		LEFT JOIN materials AS m ON m.id=t.material_id
		LEFT JOIN doc_productions AS h ON h.id=t.doc_id
		GROUP BY t.doc_id
   	) t_mat ON t_mat.doc_id = doc_p.id
   
  ORDER BY doc_p.date_time;

ALTER TABLE doc_productions_list_view
  OWNER TO bellagio;
  
-- ******************* update 09/09/2016 12:37:44 ******************

			CREATE TYPE def_date_types AS ENUM (
			
				'cur_shift'			
			,
				'cur_date'			
			,
				'cur_week'			
			,
				'cur_month'			
			,
				'cur_quarter'			
			,
				'cur_year'			
			,
				'info'			
						
			);
			ALTER TYPE def_date_types OWNER TO bellagio;
		
	CREATE OR REPLACE FUNCTION enum_def_date_types_descr(def_date_types)
	RETURNS varchar AS $$
		SELECT
		CASE $1
			
			WHEN 'cur_shift'::def_date_types THEN 'Текущая смена'
			
			WHEN 'cur_date'::def_date_types THEN 'Текущая дата'
			
			WHEN 'cur_week'::def_date_types THEN 'Текущая неделя'
			
			WHEN 'cur_month'::def_date_types THEN 'Текущий месяц'
			
			WHEN 'cur_quarter'::def_date_types THEN 'Текущий квартал'
			
			WHEN 'cur_year'::def_date_types THEN 'Текущий год'
			
			WHEN 'info'::def_date_types THEN 'Информация'
			
			ELSE '---'
		END;		
	$$ LANGUAGE sql;	
	ALTER FUNCTION enum_def_date_types_descr(def_date_types) OWNER TO bellagio;
	
	--list view
	CREATE OR REPLACE VIEW enum_list_def_date_types AS
	
		SELECT 'cur_shift'::def_date_types AS id, enum_def_date_types_descr('cur_shift'::def_date_types) AS descr
	
		UNION ALL
		
		SELECT 'cur_date'::def_date_types AS id, enum_def_date_types_descr('cur_date'::def_date_types) AS descr
	
		UNION ALL
		
		SELECT 'cur_week'::def_date_types AS id, enum_def_date_types_descr('cur_week'::def_date_types) AS descr
	
		UNION ALL
		
		SELECT 'cur_month'::def_date_types AS id, enum_def_date_types_descr('cur_month'::def_date_types) AS descr
	
		UNION ALL
		
		SELECT 'cur_quarter'::def_date_types AS id, enum_def_date_types_descr('cur_quarter'::def_date_types) AS descr
	
		UNION ALL
		
		SELECT 'cur_year'::def_date_types AS id, enum_def_date_types_descr('cur_year'::def_date_types) AS descr
	
		UNION ALL
		
		SELECT 'info'::def_date_types AS id, enum_def_date_types_descr('info'::def_date_types) AS descr
	;
	ALTER VIEW enum_list_def_date_types OWNER TO bellagio;
	
		CREATE TABLE template_params
		(id serial,template  varchar(100),user_id int REFERENCES users(id),param  varchar(100),val text,CONSTRAINT template_params_pkey PRIMARY KEY (id));
		
	CREATE INDEX template_params_template_user_idx
	ON template_params
	(template,user_id);

		ALTER TABLE template_params OWNER TO bellagio;
  
  
  
-- Function: quater_start(timestamp with time zone)

-- DROP FUNCTION quater_start(timestamp with time zone);

CREATE OR REPLACE FUNCTION quater_start(timestamp with time zone)
  RETURNS timestamp with time zone AS
$BODY$
	SELECT
		(EXTRACT( YEAR FROM $1)::text
		||'-'||
		CASE
			WHEN EXTRACT(MONTH FROM $1)<4 THEN '01'
			WHEN EXTRACT(MONTH FROM $1)<7 THEN '04'
			WHEN EXTRACT(MONTH FROM $1)<10 THEN '07'
			ELSE '10'
		END
		||'-01 00:00:00')::timestampTZ
	;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION quater_start(timestamp with time zone)
  OWNER TO bellagio;
  
  
  
ALTER TABLE users ADD COLUMN phone_cel varchar(11)  ;

DROP VIEW user_view;

CREATE OR REPLACE VIEW user_view AS 
	SELECT
		u.id,
		u.name,
		u.email,
		u.phone_cel,
		u.role_id,
		u.constrain_to_store,
		u.store_id,
		st.name AS store_descr,
		u.cash_register_id,
		cshr.name AS cash_register_descr
	FROM users u
	LEFT JOIN stores st ON st.id = u.store_id
	LEFT JOIN cash_registers cshr ON cshr.id = u.cash_register_id
	ORDER BY u.name;

ALTER TABLE user_view
  OWNER TO bellagio;
  

--constant value table
		CREATE TABLE IF NOT EXISTS const_def_material_group
		(name text, descr text, val  int);
		ALTER TABLE const_def_material_group OWNER TO bellagio;
		INSERT INTO const_def_material_group (name,descr,val) VALUES (
			'Группа материалов по умолчанию',
			'Группа материалов для открытия по умолчанию в журналах',
			null
		);
	
		--constant get value
		CREATE OR REPLACE FUNCTION const_def_material_group_val()
		RETURNS  int AS
		$BODY$
			SELECT val::int AS val FROM const_def_material_group LIMIT 1;
		$BODY$
		LANGUAGE sql VOLATILE COST 100;
		ALTER FUNCTION const_def_material_group_val() OWNER TO bellagio;
		
		--constant set value
		CREATE OR REPLACE FUNCTION const_def_material_group_set_val(int)
		RETURNS void AS
		$BODY$
			UPDATE const_def_material_group SET val=$1;
		$BODY$
		LANGUAGE sql VOLATILE COST 100;
		ALTER FUNCTION const_def_material_group_set_val(int) OWNER TO bellagio;
		
		--edit view: all keys and descr
		CREATE OR REPLACE VIEW const_def_material_group_view AS
		SELECT t.name,t.descr
		,t.val::text AS val_descr
		FROM const_def_material_group AS t
		
		;
		ALTER VIEW const_def_material_group_view OWNER TO bellagio;
	  
	  
-- Function: material_list_with_balance(integer, integer, timestamp without time zone)

DROP FUNCTION material_list_with_balance(integer, integer, timestamp without time zone);

CREATE OR REPLACE FUNCTION material_list_with_balance(IN in_store_id integer, IN in_group_id integer, IN in_date_time timestamp without time zone)
  RETURNS TABLE(
  	id integer,
  	name text,
  	material_group_id integer,
  	material_group_descr text,
  	price numeric,
  	main_quant numeric,
  	main_total numeric,
  	procur_avg_time interval
  	) AS
$BODY$
		WITH data AS
		(
		WITH b_main_detail AS
			(SELECT
				rg_main.material_id,
				rg_main.quant AS quant,
				now()-doc.date_time AS procur_interval
			FROM rg_materials_balance(
				$3,
				ARRAY[$1],
				ARRAY['main'::stock_types],'{}','{}'
			) AS rg_main
			LEFT JOIN doc_material_procurements AS doc ON doc.id=rg_main.doc_procurement_id
			)
		SELECT 
			m.id AS id,
			m.name::text AS name,
			mg.id AS material_group_id,
			mg.name::text AS material_group_descr,
			m.price AS price,
			
			b_main.quant AS main_quant,
			m.price*b_main.quant AS main_total,			
			
				
			--after procurement average time
			(SELECT AVG(procur_interval) FROM b_main_detail WHERE b_main_detail.material_id=m.id) AS procur_avg_time
		FROM materials AS m
		LEFT JOIN 
			(SELECT b_main_detail.material_id,SUM(b_main_detail.quant) AS quant			
			FROM b_main_detail
			GROUP BY b_main_detail.material_id
			) AS b_main
		ON b_main.material_id=m.id

		LEFT JOIN material_groups As mg ON mg.id=m.material_group_id
		
		WHERE 
		--m.for_sale=TRUE
		b_main.quant<>0 AND
		($2=0 OR (($2>0) AND (m.material_group_id=$2)))
		ORDER BY m.name
		)
		
		SELECT 
			data.id,
			data.name,
			data.material_group_id,
			data.material_group_descr,
			data.price,
			data.main_quant,
			data.main_total,
			data.procur_avg_time
		FROM data
		
		UNION ALL
		
		SELECT
			NULL AS id,
			NULL AS name,
			NULL AS material_group_id,
			NULL AS material_group_descr,
			NULL AS price,
			NULL AS main_quant,
			round(SUM(agg.main_total),2) AS main_total,
			AVG(agg.procur_avg_time) AS procur_avg_time
		FROM data AS agg;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION material_list_with_balance(integer, integer, timestamp without time zone)
  OWNER TO bellagio;	  
  
  
-- View: doc_material_disposals_list_view

DROP VIEW doc_material_disposals_list_view;

CREATE OR REPLACE VIEW doc_material_disposals_list_view AS 
	SELECT
		doc.id,
		doc.number,
		doc.date_time,
		doc.processed,
		doc.store_id,
		st.name AS store_descr,
		doc.user_id,
		u.name AS user_descr,
		doc.explanation,
		ra.cost AS cost
		
	FROM doc_material_disposals doc
	LEFT JOIN users u ON u.id = doc.user_id
	LEFT JOIN stores st ON st.id = doc.store_id
	LEFT JOIN
		(SELECT
			ra.doc_id,
			ra.doc_type,
			sum(ra.cost) AS cost
		FROM ra_materials ra
		GROUP BY ra.doc_id,ra.doc_type
		) AS ra ON ra.doc_id = doc.id AND ra.doc_type='material_disposal'
	ORDER BY doc.date_time;

ALTER TABLE doc_material_disposals_list_view
  OWNER TO bellagio;  
  
  
-- View: doc_sales_list_view

DROP VIEW doc_sales_list_view;

CREATE OR REPLACE VIEW doc_sales_list_view AS 
	 SELECT doc.id,
	    doc.number,
	    doc.date_time,
	    doc.processed,
	    doc.store_id,
	    st.name AS store_descr,
	    doc.user_id,
	    u.name AS user_descr,
	    doc.payment_type,
	    get_payment_types_descr(doc.payment_type) AS payment_type_descr,
	    doc.payment_type_for_sale_id,
	    pts.name AS payment_type_for_sale_descr,
	    doc.client_id,
	    cl.name AS client_descr,
		CASE
		    WHEN doc.doc_client_order_id > 0 AND clo.delivery_type = 'courier'::delivery_types THEN true
		    ELSE false
		END AS delivery,
	    doc.total,
	    COALESCE(ra.cost, 0::numeric) + COALESCE(ra_p.cost, 0::numeric) AS cost,
	    COALESCE(doc.total, 0::numeric) - COALESCE(ra.cost, 0::numeric) AS income,
		CASE
		    WHEN (COALESCE(ra.cost, 0::numeric) + COALESCE(ra_p.cost, 0::numeric)) > 0::numeric THEN round(doc.total / (COALESCE(ra.cost, 0::numeric) + COALESCE(ra_p.cost, 0::numeric)) * 100::numeric - 100::numeric, 2)
		    ELSE 0::numeric
		END AS income_percent
	   FROM doc_sales doc
	     LEFT JOIN users u ON u.id = doc.user_id
	     LEFT JOIN stores st ON st.id = doc.store_id
	     LEFT JOIN payment_types_for_sale pts ON pts.id = doc.payment_type_for_sale_id
	     LEFT JOIN clients cl ON cl.id = doc.client_id
	     LEFT JOIN doc_client_orders clo ON clo.id = doc.doc_client_order_id
	     
	     LEFT JOIN ( SELECT ra_1.doc_id,
		    		sum(ra_1.cost) AS cost
		   FROM ra_materials ra_1
		  WHERE ra_1.doc_type = 'sale'::doc_types
		  GROUP BY ra_1.doc_id
		  ) ra ON ra.doc_id = doc.id
		  
	     LEFT JOIN ( SELECT ra_p_1.doc_id,
		    sum(ra_p_1.cost) AS cost
		  FROM ra_products ra_p_1
		  WHERE ra_p_1.doc_type = 'sale'::doc_types
		  GROUP BY ra_p_1.doc_id) ra_p ON ra_p.doc_id = doc.id
		  
	  ORDER BY doc.date_time;

ALTER TABLE doc_sales_list_view
  OWNER TO bellagio;
  
  
  
  
-- View: doc_expences_list

DROP VIEW doc_expences_list;

CREATE OR REPLACE VIEW doc_expences_list AS 
	SELECT
		doc.id,
		doc.number,
		doc.date_time,
		doc.processed,
		doc.store_id,
		st.name AS store_descr,
		doc.user_id,
		u.name AS user_descr,
		
		COALESCE(doc_lines.total,0) AS total
		
	FROM doc_expences doc
	LEFT JOIN users u ON u.id = doc.user_id
	LEFT JOIN stores st ON st.id = doc.store_id
	LEFT JOIN
		(SELECT
			t.doc_id,
			SUM(t.total) AS total
		FROM doc_expences_t_expence_types t
		GROUP BY t.doc_id
		) AS doc_lines ON doc_lines.doc_id=doc.id
	ORDER BY doc.date_time;

ALTER TABLE doc_expences_list OWNER TO bellagio;  

-- View: user_view

--DROP VIEW user_profile;

CREATE OR REPLACE VIEW user_profile AS 
	SELECT
		u.id,
		u.name,
		u.email,
		u.phone_cel
	FROM users u;

ALTER TABLE user_profile
  OWNER TO bellagio;
  
  
  
DROP VIEW doc_productions_t_tmp_materials_list_view;
DROP TABLE doc_productions_t_tmp_materials;

CREATE TABLE doc_productions_t_tmp_materials
(
  tmp_doc_id varchar(36) NOT NULL,
  line_number int NOT NULL,
  material_id integer NOT NULL,
  quant_norm numeric(19,3),
  quant numeric(19,3),
  quant_waste numeric(19,3),
  CONSTRAINT doc_productions_t_tmp_materials_pkey PRIMARY KEY (tmp_doc_id, line_number),
  CONSTRAINT doc_productions_t_tmp_materials_material_id_fkey FOREIGN KEY (material_id)
      REFERENCES materials (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE doc_productions_t_tmp_materials
  OWNER TO bellagio;

-- Trigger: doc_productions_t_tmp_materials_after on doc_productions_t_tmp_materials

-- DROP TRIGGER doc_productions_t_tmp_materials_after ON doc_productions_t_tmp_materials;

CREATE TRIGGER doc_productions_t_tmp_materials_after
  AFTER INSERT OR UPDATE OR DELETE
  ON doc_productions_t_tmp_materials
  FOR EACH ROW
  EXECUTE PROCEDURE doc_productions_t_tmp_materials_process();

-- Trigger: doc_productions_t_tmp_materials_before on doc_productions_t_tmp_materials

-- DROP TRIGGER doc_productions_t_tmp_materials_before ON doc_productions_t_tmp_materials;

CREATE TRIGGER doc_productions_t_tmp_materials_before
  BEFORE INSERT OR UPDATE OR DELETE
  ON doc_productions_t_tmp_materials
  FOR EACH ROW
  EXECUTE PROCEDURE doc_productions_t_tmp_materials_process();


CREATE OR REPLACE VIEW doc_productions_t_tmp_materials_list_view AS 
	SELECT doc_p_m.line_number,
	    doc_p_m.tmp_doc_id,
	    doc_p_m.material_id,
	    m.name AS material_descr,
	    doc_p_m.quant,
	    doc_p_m.quant_norm,
	    doc_p_m.quant_waste
	FROM doc_productions_t_tmp_materials doc_p_m
	LEFT JOIN materials m ON m.id = doc_p_m.material_id
	ORDER BY doc_p_m.line_number;

ALTER TABLE doc_productions_t_tmp_materials_list_view
  OWNER TO bellagio;
  
  
-- Function: doc_productions_t_tmp_materials_process()

-- DROP FUNCTION doc_productions_t_tmp_materials_process();

CREATE OR REPLACE FUNCTION doc_productions_t_tmp_materials_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		SELECT coalesce(MAX(t.line_number),0)+1 INTO NEW.line_number FROM doc_productions_t_tmp_materials AS t
		WHERE t.tmp_doc_id = NEW.tmp_doc_id;
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='INSERT') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		RETURN NEW;					
	ELSIF (TG_WHEN='AFTER' AND TG_OP='UPDATE') THEN
		RETURN NEW;									
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		UPDATE doc_productions_t_tmp_materials
		SET line_number = line_number - 1
		WHERE tmp_doc_id=OLD.tmp_doc_id AND line_number>OLD.line_number;
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_productions_t_tmp_materials_process()
  OWNER TO bellagio;
  
  
-- Function: doc_productions_before_write(integer, integer)

-- DROP FUNCTION doc_productions_before_write(integer, integer);

CREATE OR REPLACE FUNCTION doc_productions_before_write(in_tmp_doc_id varchar(32), in_doc_id integer)
  RETURNS void AS
$BODY$
BEGIN				
	
	--clear fact table
	DELETE FROM doc_productions_t_materials WHERE doc_id=in_doc_id;
	
	--copy data from temp to fact table
	INSERT INTO doc_productions_t_materials
	(doc_id,line_number,material_id,quant)
	(SELECT in_doc_id ,line_number,material_id,quant
	FROM doc_productions_t_tmp_materials
	WHERE tmp_doc_id=in_tmp_doc_id);
	
	--clear temp table
	DELETE FROM doc_productions_t_tmp_materials WHERE tmp_doc_id=in_tmp_doc_id;
	
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_productions_before_write(integer, integer)
  OWNER TO bellagio;
  
-- Function: doc_productions_before_open(integer, integer)

-- DROP FUNCTION doc_productions_before_open(integer, integer);

CREATE OR REPLACE FUNCTION doc_productions_before_open(in_tmp_doc_id varchar(32), in_doc_id integer)
  RETURNS void AS
$BODY$
BEGIN
	
	DELETE FROM doc_productions_t_tmp_materials WHERE tmp_doc_id=in_tmp_doc_id;
	
	IF (in_doc_id IS NOT NULL AND in_doc_id>0) THEN
		INSERT INTO doc_productions_t_tmp_materials
		(tmp_doc_id,line_number,material_id,quant)
		(SELECT in_tmp_doc_id
		,line_number,material_id,quant
		FROM doc_productions_t_materials
		WHERE doc_id=in_doc_id);
	END IF;
	
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_productions_before_open(integer, integer)
  OWNER TO bellagio;
  
