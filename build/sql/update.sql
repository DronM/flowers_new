
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
  	after_production_time text,
  	doc_production_id int,
  	doc_production_date_time timestamp,
  	doc_production_number text,
  	store_id integer,
  	store_descr text
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
		0::numeric AS order_quant,

		--(SELECT product_current_fact_cost(d_p.id))  AS cost,
		--(SELECT product_current_fact_cost(d_p.id))*b_p.quant  AS cost_total,
		now()-d_p.date_time AS after_production_time,
		
		d_p.id AS doc_production_id,
		d_p.date_time AS doc_production_date_time,
		d_p.number::text AS doc_production_number,
		
		in_store_id AS store_id,
		st.name::text AS store_descr

	FROM products AS p
	LEFT JOIN rg_products_balance(ARRAY[$1],'{}','{}') AS b_p
	ON b_p.product_id=p.id
	LEFT JOIN doc_productions AS d_p ON d_p.id=b_p.doc_production_id
	LEFT JOIN stores AS st ON st.id=$1
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

		interval_descr(data.after_production_time),
		data.doc_production_id,
		data.doc_production_date_time,
		data.doc_production_number,
		
		data.store_id,
		data.store_descr
		
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

		--NULL,
		--format_money(SUM(agg.cost_total)),
		interval_descr(AVG(agg.after_production_time)),
		NULL,
		NULL,
		NULL,
		NULL,NULL
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
		doc_p.on_norm,
		
		doc_p.store_id,
		st.name AS store_descr, 
		
		doc_p.user_id,
		u.name AS user_descr,
		
		doc_p.product_id, 
		p.name AS product_descr,
		
		doc_p.quant,
		ROUND(doc_p.price*doc_p.quant,2) AS price,
		
		doc_p.material_retail_cost AS material_retail_cost,
		
		doc_p.material_cost AS material_cost,
		
		(doc_p.price*doc_p.quant)-doc_p.material_cost AS income,
		
		CASE WHEN doc_p.material_cost IS NOT NULL AND doc_p.material_cost>0 THEN
			ROUND((doc_p.price*doc_p.quant)/doc_p.material_cost*100-100,2)
		ELSE 0
		END
		AS income_percent,
		
		doc_p.florist_comment,
		
		now()-doc_p.date_time AS after_prod_interval
		
	FROM doc_productions doc_p
	LEFT JOIN products p ON p.id = doc_p.product_id
	LEFT JOIN users u ON u.id = doc_p.user_id
	LEFT JOIN stores st ON st.id = doc_p.store_id
   
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
	



-- ******************* update 09/11/2016 11:54:41 ******************

		CREATE TABLE template_params
		(id serial,template text,param text,param_type text,CONSTRAINT template_params_pkey PRIMARY KEY (id));
		
	CREATE INDEX template_params_template_idx
	ON template_params
	(template);

		ALTER TABLE template_params OWNER TO bellagio;
	
		CREATE TABLE template_param_vals
		(id serial,template_param_id int REFERENCES template_params(id),user_id int REFERENCES users(id),val text,CONSTRAINT template_param_vals_pkey PRIMARY KEY (id));
		
	CREATE INDEX template_param_vals_template_param_id_idx
	ON template_param_vals
	(template_param_id);

		ALTER TABLE template_param_vals OWNER TO bellagio;
  
  
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

CREATE OR REPLACE FUNCTION material_list_with_balance(
	in_store_id integer,
	in_group_id integer,
	in_date_time timestamp without time zone
)
  RETURNS TABLE(
  	id integer,
  	name text,
  	material_group_id integer,
  	material_group_descr text,
  	price numeric,
  	main_quant numeric,
  	main_total numeric,
  	store_id integer,
  	store_descr text
  	
  	) AS
$BODY$
		WITH data AS
		(
		WITH b_main_detail AS (
			SELECT
				rg_main.material_id,
				rg_main.quant AS quant,
				'00:00' AS procur_interval
			FROM rg_materials_balance(
				in_date_time,
				ARRAY[in_store_id],
				'{}'
			) AS rg_main
			)
		SELECT 
			m.id AS id,
			m.name::text AS name,
			mg.id AS material_group_id,
			mg.name::text AS material_group_descr,
			m.price AS price,
			
			b_main.quant AS main_quant,
			m.price*b_main.quant AS main_total,
			
			in_store_id AS store_id,
			st.name::text AS store_descr
			
		FROM materials AS m
		LEFT JOIN stores AS st ON st.id=in_store_id
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
		(in_group_id=0 OR ((in_group_id>0) AND (m.material_group_id=in_group_id)))
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
			data.store_id,
			data.store_descr
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
			NULL,NULL
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
  
  
  


--********************************* production 
DROP VIEW doc_productions_t_tmp_materials_list_view;
DROP TABLE doc_productions_t_tmp_materials;
DROP FUNCTION doc_productions_before_write(character varying,integer);
--DROP FUNCTION doc_productions_before_open(integer, integer);

CREATE TABLE doc_productions_t_tmp_materials
(
  view_id varchar(32) NOT NULL,
  line_number int NOT NULL,
  login_id int NOT NULL,
  material_id integer NOT NULL,
  quant_norm numeric(19,3),
  quant numeric(19,3),
  quant_waste numeric(19,3),
  CONSTRAINT doc_productions_t_tmp_materials_pkey PRIMARY KEY (view_id, line_number),
  CONSTRAINT doc_productions_t_tmp_materials_material_id_fkey FOREIGN KEY (material_id)
      REFERENCES materials (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT doc_productions_t_tmp_materials_login_id_fkey FOREIGN KEY (login_id)
      REFERENCES logins (id) MATCH SIMPLE
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
	    doc_p_m.view_id,
	    doc_p_m.login_id,
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


CREATE OR REPLACE FUNCTION doc_productions_t_tmp_materials_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		SELECT coalesce(MAX(t.line_number),0)+1 INTO NEW.line_number FROM doc_productions_t_tmp_materials AS t
		WHERE t.view_id = NEW.view_id;
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

 DROP FUNCTION doc_productions_before_write(integer, integer);

CREATE OR REPLACE FUNCTION doc_productions_before_write(in_view_id varchar(32), in_doc_id integer)
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
	WHERE view_id=in_view_id);
	
	--clear temp table
	DELETE FROM doc_productions_t_tmp_materials WHERE view_id=in_view_id;
	
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_productions_before_write(varchar(32), integer)
  OWNER TO bellagio;
  
-- Function: doc_productions_before_open(integer, integer)

-- DROP FUNCTION doc_productions_before_open(integer, integer);

CREATE OR REPLACE FUNCTION doc_productions_before_open(in_view_id varchar(32), in_login_id integer, in_doc_id integer)
  RETURNS void AS
$BODY$
BEGIN
	
	DELETE FROM doc_productions_t_tmp_materials WHERE view_id=in_view_id;
	
	IF (in_doc_id IS NOT NULL AND in_doc_id>0) THEN
		INSERT INTO doc_productions_t_tmp_materials
		(view_id,login_id,line_number,material_id,quant)
		(SELECT in_view_id,in_login_id,
		line_number,material_id,quant
		FROM doc_productions_t_materials
		WHERE view_id=in_view_id);
	END IF;
	
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_productions_before_open(varchar(32), integer, integer)
  OWNER TO bellagio;
  
  
--********* MATERIAL Procurement 



-- View: doc_material_procurements_list_view

DROP VIEW doc_material_procurements_list_view;

CREATE OR REPLACE VIEW doc_material_procurements_list_view AS 
	 SELECT
		doc.id,
		doc.number,
		doc.date_time, 
		doc.processed, 
	    doc.store_id,
		st.name AS store_descr,
		doc.user_id,
		u.name AS user_descr, 
	    doc.supplier_id,
		sup.name AS supplier_descr, 
	    (	SELECT
				COALESCE(sum(doc_m.total), 0::numeric) AS t
			FROM doc_material_procurements_t_materials doc_m
			WHERE doc_m.doc_id = doc.id
		) AS total
	   FROM doc_material_procurements doc
	   LEFT JOIN users u ON u.id = doc.user_id
	   LEFT JOIN stores st ON st.id = doc.store_id
	   LEFT JOIN suppliers sup ON sup.id = doc.supplier_id
	  ORDER BY doc.date_time;
	
ALTER TABLE doc_material_procurements_list_view OWNER TO bellagio;


-- Table: doc_material_procurements_t_tmp_materials

DROP VIEW doc_material_procurements_t_tmp_materials_list_view;
DROP TABLE doc_material_procurements_t_tmp_materials;

CREATE TABLE doc_material_procurements_t_tmp_materials
(  
view_id varchar(32) NOT NULL,
  line_number serial NOT NULL,
  login_id integer NOT NULL,
  material_id integer NOT NULL,
  quant numeric(19,3),
  price numeric(19,2),
  total numeric(19,2),
  CONSTRAINT doc_material_procurements_t_tmp_materials_pkey PRIMARY KEY (view_id, line_number),
  CONSTRAINT doc_material_procurements_t_tmp_materials_login_id_fkey FOREIGN KEY (login_id)
      REFERENCES logins (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT doc_material_procurements_t_tmp_materials_material_id_fkey FOREIGN KEY (material_id)
      REFERENCES materials (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE doc_material_procurements_t_tmp_materials
  OWNER TO bellagio;

-- Trigger: doc_material_procurements_t_tmp_materials_after on doc_material_procurements_t_tmp_materials

-- DROP TRIGGER doc_material_procurements_t_tmp_materials_after ON doc_material_procurements_t_tmp_materials;

CREATE TRIGGER doc_material_procurements_t_tmp_materials_after
  AFTER INSERT OR UPDATE OR DELETE
  ON doc_material_procurements_t_tmp_materials
  FOR EACH ROW
  EXECUTE PROCEDURE doc_material_procurements_t_tmp_materials_process();

-- Trigger: doc_material_procurements_t_tmp_materials_before on doc_material_procurements_t_tmp_materials

-- DROP TRIGGER doc_material_procurements_t_tmp_materials_before ON doc_material_procurements_t_tmp_materials;

CREATE TRIGGER doc_material_procurements_t_tmp_materials_before
  BEFORE INSERT OR UPDATE OR DELETE
  ON doc_material_procurements_t_tmp_materials
  FOR EACH ROW
  EXECUTE PROCEDURE doc_material_procurements_t_tmp_materials_process();



CREATE INDEX doc_productions_t_tmp_materials_login_id_idx
  ON doc_productions_t_tmp_materials
  USING btree
  (login_id);

CREATE INDEX doc_material_procurements_t_tmp_materials_login_id_idx
  ON doc_material_procurements_t_tmp_materials
  USING btree
  (login_id);


CREATE OR REPLACE VIEW doc_material_procurements_t_tmp_materials_list_view AS 
 SELECT doc.view_id,
    doc.line_number,
    doc.material_id,
    m.name AS material_descr,
    format_quant(doc.quant) AS quant,
    doc.price,
    doc.total
   FROM doc_material_procurements_t_tmp_materials doc
     LEFT JOIN materials m ON m.id = doc.material_id
  ORDER BY doc.line_number;

ALTER TABLE doc_material_procurements_t_tmp_materials_list_view
  OWNER TO bellagio;


DROP FUNCTION doc_material_to_wastes_before_open(integer, integer);
DROP FUNCTION doc_material_to_wastes_before_write(integer, integer);


DROP FUNCTION doc_material_procurements_before_open(integer, integer);

-- Function: doc_material_procurements_before_open(varchar(32),integer, integer)

-- DROP FUNCTION doc_material_procurements_before_open(varchar(32),integer, integer);

CREATE OR REPLACE FUNCTION doc_material_procurements_before_open(in_view_id varchar(32), in_login_id integer, in_doc_id integer)
  RETURNS void AS
$BODY$
BEGIN
	
	DELETE FROM doc_material_procurements_t_tmp_materials WHERE view_id=in_view_id;
	
	IF (in_doc_id IS NOT NULL AND in_doc_id>0) THEN
		INSERT INTO doc_material_procurements_t_tmp_materials
		(view_id,login_id,line_number,material_id,quant,price,total)
		(SELECT in_view_id,in_login_id
		,line_number,material_id,quant,price,total					
		FROM doc_material_procurements_t_materials
		WHERE doc_id=in_doc_id);
	END IF;
	
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_material_procurements_before_open(varchar(32),integer, integer)
  OWNER TO bellagio;




-- Table: doc_material_to_wastes_t_tmp_materials

DROP VIEW doc_material_to_wastes_t_tmp_materials_list_view;
DROP TABLE doc_material_to_wastes_t_tmp_materials;


-- Function: doc_material_procurements_t_tmp_materials_process()

-- DROP FUNCTION doc_material_procurements_t_tmp_materials_process();

CREATE OR REPLACE FUNCTION doc_material_procurements_t_tmp_materials_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		SELECT coalesce(MAX(t.line_number),0)+1 INTO NEW.line_number FROM doc_material_procurements_t_tmp_materials AS t WHERE t.view_id = NEW.view_id;
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
		UPDATE doc_material_procurements_t_tmp_materials
		SET line_number = line_number - 1
		WHERE view_id=OLD.view_id AND line_number>OLD.line_number;
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_material_procurements_t_tmp_materials_process()
  OWNER TO bellagio;



-- Function: doc_material_procurements_before_write(varchar(32), integer)

-- DROP FUNCTION doc_material_procurements_before_write(varchar(32), integer);

CREATE OR REPLACE FUNCTION doc_material_procurements_before_write(in_view_id varchar(32), in_doc_id integer)
  RETURNS void AS
$BODY$
	--clear fact table
	DELETE FROM doc_material_procurements_t_materials WHERE doc_id=in_doc_id;
	
	--copy data from temp to fact table
	INSERT INTO doc_material_procurements_t_materials
	(doc_id,line_number,material_id,quant,price,total)
	(SELECT in_doc_id
	,line_number,material_id,quant,price,total					
	FROM doc_material_procurements_t_tmp_materials
	WHERE view_id=in_view_id);				
	
	--clear temp table
	DELETE FROM doc_material_procurements_t_tmp_materials WHERE view_id=in_view_id;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_material_procurements_before_write(varchar(32), integer)
  OWNER TO bellagio;


-- Table: doc_material_disposals_t_tmp_materials

DROP VIEW doc_material_disposals_t_tmp_materials_list_view;
DROP TABLE doc_material_disposals_t_tmp_materials;

CREATE TABLE doc_material_disposals_t_tmp_materials
(
  view_id varchar(32) NOT NULL,
  line_number serial NOT NULL,
  login_id integer NOT NULL,
  material_id integer NOT NULL,
  quant numeric(19,3),
  CONSTRAINT doc_material_disposals_t_tmp_materials_pkey PRIMARY KEY (view_id, line_number),
  CONSTRAINT doc_material_disposals_t_tmp_materials_login_id_fkey FOREIGN KEY (login_id)
      REFERENCES logins (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT doc_material_disposals_t_tmp_materials_material_id_fkey FOREIGN KEY (material_id)
      REFERENCES materials (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE doc_material_disposals_t_tmp_materials
  OWNER TO bellagio;

-- Trigger: doc_material_disposals_t_tmp_materials_after on doc_material_disposals_t_tmp_materials

-- DROP TRIGGER doc_material_disposals_t_tmp_materials_after ON doc_material_disposals_t_tmp_materials;

CREATE TRIGGER doc_material_disposals_t_tmp_materials_after
  AFTER INSERT OR UPDATE OR DELETE
  ON doc_material_disposals_t_tmp_materials
  FOR EACH ROW
  EXECUTE PROCEDURE doc_material_disposals_t_tmp_materials_process();

-- Trigger: doc_material_disposals_t_tmp_materials_before on doc_material_disposals_t_tmp_materials

-- DROP TRIGGER doc_material_disposals_t_tmp_materials_before ON doc_material_disposals_t_tmp_materials;

CREATE TRIGGER doc_material_disposals_t_tmp_materials_before
  BEFORE INSERT OR UPDATE OR DELETE
  ON doc_material_disposals_t_tmp_materials
  FOR EACH ROW
  EXECUTE PROCEDURE doc_material_disposals_t_tmp_materials_process();

CREATE INDEX doc_material_disposals_t_tmp_materials_login_id_idx
  ON doc_material_disposals_t_tmp_materials
  USING btree
  (login_id);
  
  
-- Function: doc_material_disposals_t_tmp_materials_process()

-- DROP FUNCTION doc_material_disposals_t_tmp_materials_process();

CREATE OR REPLACE FUNCTION doc_material_disposals_t_tmp_materials_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		SELECT coalesce(MAX(t.line_number),0)+1 INTO NEW.line_number
		FROM doc_material_disposals_t_tmp_materials AS t
		WHERE t.view_id = NEW.view_id;
		
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
		UPDATE doc_material_disposals_t_tmp_materials
		SET line_number = line_number - 1
		WHERE view_id=OLD.view_id AND line_number>OLD.line_number;
		RETURN OLD;
	END IF;
END;
$BODY$
LANGUAGE plpgsql VOLATILE COST 100;
ALTER FUNCTION doc_material_disposals_t_tmp_materials_process()
  OWNER TO bellagio;

-- Function: doc_material_disposals_before_open(varchar(32), integer, integer)

-- DROP FUNCTION doc_material_disposals_before_open(varchar(32), integer, integer);

CREATE OR REPLACE FUNCTION doc_material_disposals_before_open(in_view_id varchar(32), in_login_id integer, in_doc_id integer)
  RETURNS void AS
$BODY$
BEGIN
	
	DELETE FROM doc_material_disposals_t_tmp_materials WHERE view_id=in_view_id;
	
	IF (in_doc_id IS NOT NULL AND in_doc_id>0) THEN
		INSERT INTO doc_material_disposals_t_tmp_materials
		(view_id, login_id,line_number,material_id,quant)
		(SELECT in_view_id, in_login_id
		,line_number,material_id,quant					
		FROM doc_material_disposals_t_materials
		WHERE doc_id=in_doc_id);
	END IF;
	
END;
$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;
ALTER FUNCTION doc_material_disposals_before_open(varchar(32), integer, integer)
  OWNER TO bellagio;


-- Function: doc_material_disposals_before_write(varchar(32), integer)

-- DROP FUNCTION doc_material_disposals_before_write(varchar(32), integer);

CREATE OR REPLACE FUNCTION doc_material_disposals_before_write(in_view_id varchar(32), in_doc_id integer)
  RETURNS void AS
$BODY$
	--clear fact table
	DELETE FROM doc_material_disposals_t_materials WHERE doc_id=in_doc_id;
	
	--copy data from temp to fact table
	INSERT INTO doc_material_disposals_t_materials
	(doc_id,line_number,material_id,quant)
	(SELECT in_doc_id
	,line_number,material_id,quant					
	FROM doc_material_disposals_t_tmp_materials
	WHERE view_id=in_view_id);				
	
	--clear temp table
	DELETE FROM doc_material_disposals_t_tmp_materials WHERE view_id=in_view_id;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_material_disposals_before_write(varchar(32), integer)
  OWNER TO bellagio;


-- View: doc_material_disposals_t_tmp_materials_list_view

--DROP VIEW doc_material_disposals_t_tmp_materials_list_view;

CREATE OR REPLACE VIEW doc_material_disposals_t_tmp_materials_list_view AS 
	SELECT
		doc.view_id,
		doc.line_number,
		doc.material_id,
		m.name AS material_descr,
		doc.quant AS quant
	FROM doc_material_disposals_t_tmp_materials doc
	LEFT JOIN materials m ON m.id = doc.material_id
	ORDER BY doc.line_number;

ALTER TABLE doc_material_disposals_t_tmp_materials_list_view OWNER TO bellagio;



-- Table: doc_expences_t_tmp_expence_types

DROP VIEW doc_expences_t_tmp_expence_types_list;
DROP TABLE doc_expences_t_tmp_expence_types;

CREATE TABLE doc_expences_t_tmp_expence_types
(
  view_id varchar(32) NOT NULL,
  line_number integer NOT NULL,
  login_id integer NOT NULL,
  expence_type_id integer NOT NULL,
  expence_comment text,
  total numeric(15,2),
  expence_date date,
  CONSTRAINT doc_expences_t_tmp_expence_types_pkey PRIMARY KEY (view_id, line_number),
  CONSTRAINT doc_expences_t_tmp_expence_types_expence_type_id_fkey FOREIGN KEY (expence_type_id)
      REFERENCES expence_types (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT doc_expences_t_tmp_expence_types_login_id_fkey FOREIGN KEY (login_id)
      REFERENCES logins (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE doc_expences_t_tmp_expence_types
  OWNER TO bellagio;

-- Trigger: doc_expences_t_tmp_expence_types_after on doc_expences_t_tmp_expence_types

-- DROP TRIGGER doc_expences_t_tmp_expence_types_after ON doc_expences_t_tmp_expence_types;

CREATE TRIGGER doc_expences_t_tmp_expence_types_after
  AFTER INSERT OR UPDATE OR DELETE
  ON doc_expences_t_tmp_expence_types
  FOR EACH ROW
  EXECUTE PROCEDURE doc_expences_t_tmp_expence_types_process();

-- Trigger: doc_expences_t_tmp_expence_types_before on doc_expences_t_tmp_expence_types

-- DROP TRIGGER doc_expences_t_tmp_expence_types_before ON doc_expences_t_tmp_expence_types;

CREATE TRIGGER doc_expences_t_tmp_expence_types_before
  BEFORE INSERT OR UPDATE OR DELETE
  ON doc_expences_t_tmp_expence_types
  FOR EACH ROW
  EXECUTE PROCEDURE doc_expences_t_tmp_expence_types_process();



-- View: doc_expences_t_tmp_expence_types_list

--DROP VIEW doc_expences_t_tmp_expence_types_list;

CREATE OR REPLACE VIEW doc_expences_t_tmp_expence_types_list AS 
	SELECT
		doc.view_id,
		doc.line_number,		
		doc.login_id,
		doc.expence_type_id,
		ext.name AS expence_type_descr,
		doc.expence_comment,
		doc.expence_date,
		doc.total
		
	FROM doc_expences_t_tmp_expence_types doc
	LEFT JOIN expence_types ext ON ext.id = doc.expence_type_id
	ORDER BY doc.line_number;

ALTER TABLE doc_expences_t_tmp_expence_types_list
  OWNER TO bellagio;
  
  -- Index: doc_productions_t_tmp_materials_login_id_idx

-- DROP INDEX doc_productions_t_tmp_materials_login_id_idx;

CREATE INDEX doc_expences_t_tmp_expence_types_login_id_idx
  ON doc_expences_t_tmp_expence_types
  USING btree
  (login_id);



-- Function: doc_expences_t_tmp_expence_types_process()

-- DROP FUNCTION doc_expences_t_tmp_expence_types_process();

CREATE OR REPLACE FUNCTION doc_expences_t_tmp_expence_types_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		SELECT coalesce(MAX(t.line_number),0)+1 INTO NEW.line_number
		FROM doc_expences_t_tmp_expence_types AS t WHERE t.view_id = NEW.view_id;
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
		UPDATE doc_expences_t_tmp_expence_types
		SET line_number = line_number - 1
		WHERE view_id=OLD.view_id AND line_number>OLD.line_number;
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_expences_t_tmp_expence_types_process()
  OWNER TO bellagio;


DROP FUNCTION doc_expences_before_open(integer, integer);

-- Function: doc_expences_before_open(varchar(32), integer, integer)

-- DROP FUNCTION doc_expences_before_open(varchar(32), integer, integer);

CREATE OR REPLACE FUNCTION doc_expences_before_open(in_view_id varchar(32), in_login_id integer, in_doc_id integer)
  RETURNS void AS
$BODY$
	DELETE FROM doc_expences_t_tmp_expence_types WHERE view_id=in_view_id;
	
	INSERT INTO doc_expences_t_tmp_expence_types
	(view_id,login_id,expence_type_id,total,expence_comment,expence_date)
	(SELECT in_view_id,in_login_id,
	expence_type_id,total,expence_comment,expence_date					
	FROM doc_expences_t_expence_types
	WHERE doc_id=in_doc_id ORDER BY line_number);
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_expences_before_open(varchar(32), integer, integer)
  OWNER TO bellagio;


DROP FUNCTION doc_expences_before_write(integer, integer);


-- Function: doc_expences_before_write(varchar(32), integer)

-- DROP FUNCTION doc_expences_before_write(varchar(32), integer);

CREATE OR REPLACE FUNCTION doc_expences_before_write(in_view_id varchar(32), in_doc_id integer)
  RETURNS void AS
$BODY$
	
	--clear fact table
	DELETE FROM doc_expences_t_expence_types WHERE doc_id=$2;
	
	--copy data from temp to fact table
	INSERT INTO doc_expences_t_expence_types
	(doc_id,line_number,expence_type_id,total,expence_comment,expence_date)
	(SELECT in_doc_id
	,line_number,expence_type_id,total,expence_comment,expence_date
	FROM doc_expences_t_tmp_expence_types
	WHERE view_id=in_view_id);				
	
	--clear temp table
	DELETE FROM doc_expences_t_tmp_expence_types WHERE view_id=in_view_id;
	
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_expences_before_write(varchar(32), integer)
  OWNER TO bellagio;




-- Table: doc_sales_t_tmp_materials

DROP VIEW doc_sales_t_tmp_materials_list_view;
DROP TABLE doc_sales_t_tmp_materials;

CREATE TABLE doc_sales_t_tmp_materials
(
  view_id varchar(32) NOT NULL,
  line_number serial NOT NULL,
  login_id integer NOT NULL,
  material_id integer NOT NULL,
  quant numeric(19,3),
  price numeric(15,2),
  total numeric(15,2),
  disc_percent numeric(15,2),
  price_no_disc numeric(15,2),
  total_no_disc numeric(15,2),
  CONSTRAINT doc_sales_t_tmp_materials_pkey PRIMARY KEY (view_id, line_number),
  CONSTRAINT doc_sales_t_tmp_materials_login_id_fkey FOREIGN KEY (login_id)
      REFERENCES logins (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT doc_sales_t_tmp_materials_material_id_fkey FOREIGN KEY (material_id)
      REFERENCES materials (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE doc_sales_t_tmp_materials
  OWNER TO bellagio;

-- Trigger: doc_sales_t_tmp_materials_after on doc_sales_t_tmp_materials

-- DROP TRIGGER doc_sales_t_tmp_materials_after ON doc_sales_t_tmp_materials;

CREATE TRIGGER doc_sales_t_tmp_materials_after
  AFTER INSERT OR UPDATE OR DELETE
  ON doc_sales_t_tmp_materials
  FOR EACH ROW
  EXECUTE PROCEDURE doc_sales_t_tmp_materials_process();

-- Trigger: doc_sales_t_tmp_materials_before on doc_sales_t_tmp_materials

-- DROP TRIGGER doc_sales_t_tmp_materials_before ON doc_sales_t_tmp_materials;

CREATE TRIGGER doc_sales_t_tmp_materials_before
  BEFORE INSERT OR UPDATE OR DELETE
  ON doc_sales_t_tmp_materials
  FOR EACH ROW
  EXECUTE PROCEDURE doc_sales_t_tmp_materials_process();


-- View: doc_sales_t_tmp_materials_list_view

-- DROP VIEW doc_sales_t_tmp_materials_list_view;

CREATE OR REPLACE VIEW doc_sales_t_tmp_materials_list_view AS 
SELECT
	doc.view_id,
	doc.line_number,
	doc.login_id,
	doc.material_id,
	m.name AS material_descr,
	doc.quant AS quant,
	doc.price,
	doc.total,
	doc.disc_percent,
	doc.price_no_disc,
	doc.total_no_disc
FROM doc_sales_t_tmp_materials doc
LEFT JOIN materials m ON m.id = doc.material_id
ORDER BY doc.line_number;

ALTER TABLE doc_sales_t_tmp_materials_list_view
  OWNER TO bellagio;
  
  
  -- Table: doc_sales_t_tmp_products

DROP VIEW doc_sales_t_tmp_products_list_view;
DROP TABLE doc_sales_t_tmp_products;

CREATE TABLE doc_sales_t_tmp_products
(
  view_id varchar(32) NOT NULL,
  line_number serial NOT NULL,
  login_id integer NOT NULL,
  quant numeric(19,3),
  price numeric(15,2),
  total numeric(15,2),
  doc_production_id integer,
  disc_percent numeric(15,2),
  price_no_disc numeric(15,2),
  total_no_disc numeric(15,2),
  CONSTRAINT doc_sales_t_tmp_products_pkey PRIMARY KEY (view_id, line_number),
  CONSTRAINT doc_sales_t_tmp_products_doc_production_id_fkey FOREIGN KEY (doc_production_id)
      REFERENCES doc_productions (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT doc_sales_t_tmp_products_login_id_fkey FOREIGN KEY (login_id)
      REFERENCES logins (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE doc_sales_t_tmp_products
  OWNER TO bellagio;

-- Trigger: doc_sales_t_tmp_products_after on doc_sales_t_tmp_products

-- DROP TRIGGER doc_sales_t_tmp_products_after ON doc_sales_t_tmp_products;

CREATE TRIGGER doc_sales_t_tmp_products_after
  AFTER INSERT OR UPDATE OR DELETE
  ON doc_sales_t_tmp_products
  FOR EACH ROW
  EXECUTE PROCEDURE doc_sales_t_tmp_products_process();

-- Trigger: doc_sales_t_tmp_products_before on doc_sales_t_tmp_products

-- DROP TRIGGER doc_sales_t_tmp_products_before ON doc_sales_t_tmp_products;

CREATE TRIGGER doc_sales_t_tmp_products_before
  BEFORE INSERT OR UPDATE OR DELETE
  ON doc_sales_t_tmp_products
  FOR EACH ROW
  EXECUTE PROCEDURE doc_sales_t_tmp_products_process();




CREATE OR REPLACE VIEW doc_sales_t_tmp_products_list_view AS 
SELECT
	doc.view_id,
	doc.line_number,
	doc.login_id,
	doc_prod.product_id,
	p.name AS product_descr,
	doc.quant AS quant,
	doc.price,
	doc.total,
	doc.doc_production_id,
	doc.disc_percent,
	doc.price_no_disc,
	doc.total_no_disc,
	doc_prod.number AS doc_production_number,
	doc_prod.date_time AS doc_production_date_time
	
FROM doc_sales_t_tmp_products doc
LEFT JOIN doc_productions doc_prod ON doc_prod.id = doc.doc_production_id
LEFT JOIN products p ON p.id = doc_prod.product_id
ORDER BY doc.line_number;

ALTER TABLE doc_sales_t_tmp_products_list_view
  OWNER TO bellagio;  
  
-- Function: doc_sales_t_tmp_materials_process()

-- DROP FUNCTION doc_sales_t_tmp_materials_process();

CREATE OR REPLACE FUNCTION doc_sales_t_tmp_materials_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		SELECT coalesce(MAX(t.line_number),0)+1 INTO NEW.line_number
		FROM doc_sales_t_tmp_materials AS t WHERE t.view_id = NEW.view_id;
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
		UPDATE doc_sales_t_tmp_materials
		SET line_number = line_number - 1
		WHERE view_id=OLD.view_id AND line_number>OLD.line_number;
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_sales_t_tmp_materials_process()
  OWNER TO bellagio;
  
  
-- Function: doc_sales_t_tmp_products_process()

-- DROP FUNCTION doc_sales_t_tmp_products_process();

CREATE OR REPLACE FUNCTION doc_sales_t_tmp_products_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		SELECT coalesce(MAX(t.line_number),0)+1 INTO NEW.line_number
		FROM doc_sales_t_tmp_products AS t WHERE t.view_id = NEW.view_id;
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
		UPDATE doc_sales_t_tmp_products
		SET line_number = line_number - 1
		WHERE view_id=OLD.view_id AND line_number>OLD.line_number;
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_sales_t_tmp_products_process()
  OWNER TO bellagio;
  
  
DROP FUNCTION doc_sales_before_open(integer, integer);  



-- Function: doc_sales_before_write(varchar(32), integer)

-- DROP FUNCTION doc_sales_before_write(varchar(32), integer);

CREATE OR REPLACE FUNCTION doc_sales_before_write(in_view_id varchar(32), in_doc_id integer)
  RETURNS void AS
$BODY$
	--clear fact table
	DELETE FROM doc_sales_t_materials WHERE doc_id=in_doc_id;
	
	--copy data from temp to fact table
	INSERT INTO doc_sales_t_materials
	(doc_id,line_number,material_id,quant,price,total,
	disc_percent,price_no_disc,total_no_disc)
	(SELECT in_doc_id,
	line_number,material_id,quant,price,total,
	disc_percent,price_no_disc,total_no_disc
	FROM doc_sales_t_tmp_materials
	WHERE view_id=in_view_id);				
	
	--clear temp table
	DELETE FROM doc_sales_t_tmp_materials WHERE view_id=in_view_id;
	
	--clear fact table
	DELETE FROM doc_sales_t_products WHERE doc_id=in_doc_id;
	
	--copy data from temp to fact table
	INSERT INTO doc_sales_t_products
	(doc_id,line_number,product_id,doc_production_id,quant,price,total,
	disc_percent,price_no_disc,total_no_disc)
	(SELECT in_doc_id
	,t.line_number,doc_prod.product_id,t.doc_production_id,t.quant,t.price,t.total,
	t.disc_percent,t.price_no_disc,t.total_no_disc
	FROM doc_sales_t_tmp_products AS t
	LEFT JOIN doc_productions AS doc_prod ON doc_prod.id=t.doc_production_id
	WHERE view_id=in_view_id);				
	
	--clear temp table
	DELETE FROM doc_sales_t_tmp_products WHERE view_id=in_view_id;
	
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_sales_before_write(varchar(32), integer)
  OWNER TO bellagio;
  
  
  -- Function: doc_sales_before_open(varchar(32), integer, integer)

-- DROP FUNCTION doc_sales_before_open(varchar(32), integer, integer);

CREATE OR REPLACE FUNCTION doc_sales_before_open(in_view_id varchar(32), in_login_id integer, in_doc_id integer)
  RETURNS void AS
$BODY$
BEGIN
	
	DELETE FROM doc_sales_t_tmp_materials WHERE view_id=in_view_id;
	IF (in_doc_id IS NOT NULL AND in_doc_id>0) THEN
		INSERT INTO doc_sales_t_tmp_materials
		(view_id, login_id,line_number,material_id,quant,price,total,
		disc_percent,price_no_disc,total_no_disc)
		(SELECT in_view_id, in_login_id
		,line_number,material_id,quant,price,total,
		disc_percent,price_no_disc,total_no_disc
		FROM doc_sales_t_materials
		WHERE doc_id=in_doc_id);
	END IF;
	
	DELETE FROM doc_sales_t_tmp_products WHERE view_id=in_view_id;
	IF (in_doc_id IS NOT NULL AND in_doc_id>0) THEN
		INSERT INTO doc_sales_t_tmp_products
		(view_id, login_id,line_number,doc_production_id,quant,price,total,
		disc_percent,price_no_disc,total_no_disc)
		(SELECT in_view_id, in_login_id
		,line_number,doc_production_id,quant,price,total,
		disc_percent,price_no_disc,total_no_disc
		FROM doc_sales_t_products
		WHERE doc_id=in_doc_id);
	END IF;
	
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_sales_before_open(varchar(32), integer, integer)
  OWNER TO bellagio;
  
  
  
  
		--constant value table
		CREATE TABLE IF NOT EXISTS const_def_payment_type_for_sale
		(name text, descr text, val int);
		ALTER TABLE const_def_payment_type_for_sale OWNER TO bellagio;
		INSERT INTO const_def_payment_type_for_sale (name,descr,val) VALUES (
			'Тип оплаты по умолчанию',
			'Тип оплаты по умолчанию',
			null
		);
	
		--constant get value
		CREATE OR REPLACE FUNCTION const_def_payment_type_for_sale_val()
		RETURNS int AS
		$BODY$
			SELECT val::int AS val FROM const_def_payment_type_for_sale LIMIT 1;
		$BODY$
		LANGUAGE sql VOLATILE COST 100;
		ALTER FUNCTION const_def_payment_type_for_sale_val() OWNER TO bellagio;
		
		--constant set value
		CREATE OR REPLACE FUNCTION const_def_payment_type_for_sale_set_val(Int)
		RETURNS void AS
		$BODY$
			UPDATE const_def_payment_type_for_sale SET val=$1;
		$BODY$
		LANGUAGE sql VOLATILE COST 100;
		ALTER FUNCTION const_def_payment_type_for_sale_set_val(Int) OWNER TO bellagio;
		
		--edit view: all keys and descr
		CREATE OR REPLACE VIEW const_def_payment_type_for_sale_view AS
		SELECT t.name,t.descr
		
		,j.id AS val_id
		,j.name::text AS val_descr
		
		FROM const_def_payment_type_for_sale AS t
		
		LEFT JOIN payment_types_for_sale AS j
			ON j.id=t.val
		
		;
		ALTER VIEW const_def_payment_type_for_sale_view OWNER TO bellagio;
	
	  
	  
SELECT const_def_payment_type_for_sale_set_val(1);
	  
	  
	  
	  
		--constant value table
		CREATE TABLE IF NOT EXISTS const_def_client
		(name text, descr text, val int);
		ALTER TABLE const_def_client OWNER TO bellagio;
		INSERT INTO const_def_client (name,descr,val) VALUES (
			'Покупатель по умолчанию',
			'Розничный покупатель для всех продаж',
			null
		);
	
		--constant get value
		CREATE OR REPLACE FUNCTION const_def_client_val()
		RETURNS int AS
		$BODY$
			SELECT val::int AS val FROM const_def_client LIMIT 1;
		$BODY$
		LANGUAGE sql VOLATILE COST 100;
		ALTER FUNCTION const_def_client_val() OWNER TO bellagio;
		
		--constant set value
		CREATE OR REPLACE FUNCTION const_def_client_set_val(Int)
		RETURNS void AS
		$BODY$
			UPDATE const_def_client SET val=$1;
		$BODY$
		LANGUAGE sql VOLATILE COST 100;
		ALTER FUNCTION const_def_client_set_val(Int) OWNER TO bellagio;
		
		--edit view: all keys and descr
		CREATE OR REPLACE VIEW const_def_client_view AS
		SELECT t.name,t.descr
		
		,j.id AS val_id
		,j.name::text AS val_descr
		
		FROM const_def_client AS t
		
		LEFT JOIN clients AS j
			ON j.id=t.val
		
		;
		ALTER VIEW const_def_client_view OWNER TO bellagio;
	
		  
SELECT const_def_client_set_val(1);		  



ALTER TABLE const_def_client ADD COLUMN val_type text;
UPDATE const_def_client SET val_type='Ref';

ALTER TABLE const_cel_phone_for_sms ADD COLUMN val_type text;
UPDATE const_cel_phone_for_sms SET val_type='String';
ALTER TABLE const_def_material_group ADD COLUMN val_type text;
UPDATE const_def_material_group SET val_type='Ref';
ALTER TABLE const_def_payment_type_for_sale ADD COLUMN val_type text;
UPDATE const_def_payment_type_for_sale SET val_type='Ref';

ALTER TABLE const_def_store ADD COLUMN val_type text;
UPDATE const_def_store SET val_type='Ref';

ALTER TABLE const_doc_per_page_count ADD COLUMN val_type text;
UPDATE const_doc_per_page_count SET val_type='Int';

ALTER TABLE const_negat_material_balance_restrict ADD COLUMN val_type text;
UPDATE const_negat_material_balance_restrict SET val_type='Bool';

ALTER TABLE const_negat_product_balance_restrict ADD COLUMN val_type text;
UPDATE const_negat_product_balance_restrict SET val_type='Bool';

ALTER TABLE const_sale_item_cols ADD COLUMN val_type text;
UPDATE const_sale_item_cols SET val_type='Int';

ALTER TABLE const_shift_length_time ADD COLUMN val_type text;
UPDATE const_shift_length_time SET val_type='String';

ALTER TABLE const_shift_start_time ADD COLUMN val_type text;
UPDATE const_shift_start_time SET val_type='String';



		CREATE TABLE discounts
		(id serial,name  varchar(150),percent int,CONSTRAINT discounts_pkey PRIMARY KEY (id));
		
	CREATE INDEX discounts_name_idx
	ON discounts
	(name);

		ALTER TABLE discounts OWNER TO bellagio;

-- VIEW: discounts_list

--DROP VIEW discounts_list;

CREATE OR REPLACE VIEW discounts_list AS
	SELECT
		id,
		format('%s (%s %%)',name,percent) As descr,
		percent
	FROM discounts
	;
	
ALTER VIEW discounts_list OWNER TO bellagio;

INSERT INTO discounts(id, name, percent) VALUES (1, 'По карте', 0);



		--constant value table
		CREATE TABLE IF NOT EXISTS const_def_discount
		(name text, descr text, val int, val_type text);
		
		ALTER TABLE const_def_discount OWNER TO bellagio;
		
		INSERT INTO const_def_discount (name,descr,val,val_type) VALUES (		
			'Вид скидки по умолчанию',
			'Вид скидки для подстановки в чек по умолчанию',
			null,
			'Int'
		);
	
		--constant get value
		CREATE OR REPLACE FUNCTION const_def_discount_val()
		RETURNS int AS
		$BODY$
			SELECT val::int AS val FROM const_def_discount LIMIT 1;
		$BODY$
		LANGUAGE sql VOLATILE COST 100;
		ALTER FUNCTION const_def_discount_val() OWNER TO bellagio;
		
		--constant set value
		CREATE OR REPLACE FUNCTION const_def_discount_set_val(Int)
		RETURNS void AS
		$BODY$
			UPDATE const_def_discount SET val=$1;
		$BODY$
		LANGUAGE sql VOLATILE COST 100;
		ALTER FUNCTION const_def_discount_set_val(Int) OWNER TO bellagio;
		
		--edit view: all keys and descr
		CREATE OR REPLACE VIEW const_def_discount_view AS
		SELECT t.name,t.descr
		
		,j.id AS val_id
		
		
		,j.name::text AS val_descr,
		t.val_type AS val_type
		
		
		FROM const_def_discount AS t
		
		LEFT JOIN discounts AS j
			ON j.id=t.val
		
		;
		ALTER VIEW const_def_discount_view OWNER TO bellagio;

-- View: const_cel_phone_for_sms_view

-- DROP VIEW const_cel_phone_for_sms_view;

CREATE OR REPLACE VIEW const_cel_phone_for_sms_view AS 
 SELECT t.name,
    t.descr,
    t.val::text AS val_descr,
    t.val_type
   FROM const_cel_phone_for_sms t;

ALTER TABLE const_cel_phone_for_sms_view
  OWNER TO bellagio;
-- View: const_def_client_view

-- DROP VIEW const_def_client_view;

CREATE OR REPLACE VIEW const_def_client_view AS 
 SELECT t.name,
    t.descr,
    j.id AS val_id,
    j.name::text AS val_descr,
    t.val_type
   FROM const_def_client t
     LEFT JOIN clients j ON j.id = t.val;

ALTER TABLE const_def_client_view
  OWNER TO bellagio;

-- View: const_def_material_group_view

-- DROP VIEW const_def_material_group_view;

CREATE OR REPLACE VIEW const_def_material_group_view AS 
 SELECT t.name,
    t.descr,
    t.val::text AS val_descr,
    t.val_type
   FROM const_def_material_group t;

ALTER TABLE const_def_material_group_view
  OWNER TO bellagio;

-- View: const_def_payment_type_for_sale_view

-- DROP VIEW const_def_payment_type_for_sale_view;

CREATE OR REPLACE VIEW const_def_payment_type_for_sale_view AS 
 SELECT t.name,
    t.descr,
    j.id AS val_id,
    j.name::text AS val_descr,
    t.val_type
   FROM const_def_payment_type_for_sale t
     LEFT JOIN payment_types_for_sale j ON j.id = t.val;

ALTER TABLE const_def_payment_type_for_sale_view
  OWNER TO bellagio;

-- View: const_def_store_view

-- DROP VIEW const_def_store_view;

CREATE OR REPLACE VIEW const_def_store_view AS 
 SELECT t.name,
    t.descr,
    j.id AS val_id,
    j.name::text AS val_descr,
    t.val_type
   FROM const_def_store t
     LEFT JOIN stores j ON j.id = t.val;

ALTER TABLE const_def_store_view
  OWNER TO bellagio;

-- View: const_doc_per_page_count_view

-- DROP VIEW const_doc_per_page_count_view;

CREATE OR REPLACE VIEW const_doc_per_page_count_view AS 
 SELECT t.name,
    t.descr,
    t.val::text AS val_descr
    ,t.val_type
   FROM const_doc_per_page_count t;

ALTER TABLE const_doc_per_page_count_view
  OWNER TO bellagio;

-- View: const_negat_material_balance_restrict_view

-- DROP VIEW const_negat_material_balance_restrict_view;

CREATE OR REPLACE VIEW const_negat_material_balance_restrict_view AS 
 SELECT t.name,
    t.descr,
    t.val::text AS val_descr,
    t.val_type
   FROM const_negat_material_balance_restrict t;

ALTER TABLE const_negat_material_balance_restrict_view
  OWNER TO bellagio;

-- View: const_negat_product_balance_restrict_view

-- DROP VIEW const_negat_product_balance_restrict_view;

CREATE OR REPLACE VIEW const_negat_product_balance_restrict_view AS 
 SELECT t.name,
    t.descr,
    t.val::text AS val_descr,
    t.val_type
   FROM const_negat_product_balance_restrict t;

ALTER TABLE const_negat_product_balance_restrict_view
  OWNER TO bellagio;

-- View: const_sale_item_cols_view

-- DROP VIEW const_sale_item_cols_view;

CREATE OR REPLACE VIEW const_sale_item_cols_view AS 
 SELECT t.name,
    t.descr,
    t.val::text AS val_descr,
    t.val_type
   FROM const_sale_item_cols t;

ALTER TABLE const_sale_item_cols_view
  OWNER TO bellagio;

-- View: const_shift_length_time_view

-- DROP VIEW const_shift_length_time_view;

CREATE OR REPLACE VIEW const_shift_length_time_view AS 
 SELECT t.name,
    t.descr,
    t.val::text AS val_descr,
    t.val_type
   FROM const_shift_length_time t;

ALTER TABLE const_shift_length_time_view
  OWNER TO bellagio;

-- View: const_shift_start_time_view

-- DROP VIEW const_shift_start_time_view;

CREATE OR REPLACE VIEW const_shift_start_time_view AS 
 SELECT t.name,
    t.descr,
    t.val::text AS val_descr,
    t.val_type
   FROM const_shift_start_time t;

ALTER TABLE const_shift_start_time_view
  OWNER TO bellagio;


	
ALTER TABLE doc_sales ADD COLUMN discount_id int REFERENCES discounts(id);	


--SELECT const_def_discount_set_val(1)


		CREATE TABLE disc_cards
		(id serial,discount_id int REFERENCES discounts(id),barcode text,CONSTRAINT disc_cards_pkey PRIMARY KEY (id));
		
	CREATE INDEX disc_cards_barcode_idx
	ON disc_cards
	(barcode);

		ALTER TABLE disc_cards OWNER TO bellagio;
	
		ALTER TABLE clients ADD COLUMN disc_card_id int REFERENCES disc_cards(id);



-- View: client_list_view

--DROP VIEW client_list_view;

CREATE OR REPLACE VIEW client_list_view AS 
	SELECT
		cl.id,
		cl.name,
		cl.tel,
		cl.email,
		disc_cards.id AS disc_card_id,
		disc_cards.barcode AS disc_card_barcode,
		discounts.percent AS disc_card_percent,
		discounts.id AS discount_id
		
	FROM clients AS cl
	LEFt JOIN disc_cards ON disc_cards.id=cl.disc_card_id
	LEFt JOIN discounts ON disc_cards.discount_id=discounts.id
	
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
		cl.email,
		disc_cards.id AS disc_card_id,
		disc_cards.barcode AS disc_card_barcode,
		discounts.percent AS disc_card_percent
		
	FROM clients AS cl
	LEFt JOIN disc_cards ON disc_cards.id=cl.disc_card_id
	LEFt JOIN discounts ON disc_cards.discount_id=discounts.id
	
	ORDER BY cl.name;
	;
ALTER TABLE client_dialog
  OWNER TO bellagio;
    
    
    
/**********************************************************
**********************************************************/
--DROP VIEW doc_productions_list_view;
DROP VIEW doc_material_disposals_materials_list_view;
DROP VIEW doc_product_disposals_materials_list_view;
DROP VIEW doc_productions_materials_list_view;
DROP VIEW doc_sales_materials_list_view;
DROP VIEW ra_materials_list_view;
DROP VIEW rep_material_actions;
DROP VIEW doc_material_disposals_list_view;
DROP VIEW doc_sales_list_view;
DROP VIEW doc_productions_list_view;

ALTER TABLE ra_materials DROP COLUMN stock_type;
ALTER TABLE ra_materials DROP COLUMN doc_procurement_id;

ALTER TABLE rg_materials DROP COLUMN stock_type;
ALTER TABLE rg_materials DROP COLUMN doc_procurement_id;
/*******************************************************/

-- Function: ra_materials_add_act(ra_materials)

-- DROP FUNCTION ra_materials_add_act(ra_materials);

CREATE OR REPLACE FUNCTION ra_materials_add_act(reg_act ra_materials)
  RETURNS void AS
$BODY$
			BEGIN
				INSERT INTO ra_materials
				(date_time,doc_type,doc_id
				,deb
				,store_id
				,material_id
				,quant
				,cost				
				)
				VALUES (
				reg_act.date_time,reg_act.doc_type,reg_act.doc_id
				,reg_act.deb
				,reg_act.store_id
				,reg_act.material_id
				,reg_act.quant
				,reg_act.cost				
				);
			END;
			$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100;
ALTER FUNCTION ra_materials_add_act(ra_materials)
  OWNER TO bellagio;
    
    
-- Function: ra_materials_remove_acts(doc_types, integer)

-- DROP FUNCTION ra_materials_remove_acts(doc_types, integer);

CREATE OR REPLACE FUNCTION ra_materials_remove_acts(in_doc_type doc_types, in_doc_id integer)
  RETURNS void AS
$BODY$
	DELETE FROM ra_materials
	WHERE doc_type=in_doc_type AND doc_id=in_doc_id;
$BODY$
  LANGUAGE sql VOLATILE STRICT
  COST 100;
ALTER FUNCTION ra_materials_remove_acts(doc_types, integer)
  OWNER TO bellagio;


DROP FUNCTION rg_materials_balance(integer[], stock_types[], integer[], integer[]);    

DROP FUNCTION rg_materials_balance(timestamp without time zone, integer[], stock_types[], integer[], integer[]);

DROP FUNCTION rg_materials_balance(doc_types, integer, integer[], stock_types[], integer[], integer[]);




ALTER TABLE doc_productions ADD COLUMN material_cost numeric;
ALTER TABLE doc_productions ADD COLUMN material_retail_cost numeric;

ALTER TABLE receipts ALTER COLUMN ord SET DEFAULT now();


_sale(integer);

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

 DROP FUNCTION product_list_for_sale(integer);

CREATE OR REPLACE FUNCTION product_list_for_sale(IN in_store_id integer)
  RETURNS TABLE(id integer, name text, price text, quant numeric, quant_descr text, code text, doc_production_id integer,item_type int) AS
$BODY$
	SELECT
		p.id,
		p.name::text || ',код:'||(b.code::text)::text,
		format_rub(d_p.price) AS price,
		coalesce(b.quant,0) AS quant,
		CASE 
			WHEN b.quant IS NULL OR b.quant=0 THEN ''
			ELSE round(b.quant)::text || ' шт.'
		END AS quant_descr,

		b.code::text,
		b.doc_production_id,
		
		0 AS item_type
		
	FROM products AS p
	RIGHT JOIN
		(SELECT rg.product_id,rg.quant,doc_prod.number AS code,rg.doc_production_id AS doc_production_id
		FROM rg_products_balance(ARRAY[$1],'{}','{}') AS rg
		LEFT JOIN doc_productions AS doc_prod ON doc_prod.id=rg.doc_production_id
		) AS b
		ON b.product_id=p.id
	LEFT JOIN doc_productions AS d_p ON d_p.id=b.doc_production_id
	WHERE p.for_sale=TRUE AND d_p.price>0
	ORDER BY d_p.price;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION product_list_for_sale(integer)
  OWNER TO bellagio;  
  
  
/*
DROP VIEW ra_material_costs_list_view;
DROP FUNCTION ra_material_costs_add_act(ra_material_costs);
DROP TABLE ra_material_costs;
DROP TABLE rg_material_costs;

DROP VIEW ra_product_sales_list_view;
DROP FUNCTION ra_product_sales_add_act(ra_product_sales);
DROP TABLE ra_product_sales;
DROP TABLE rg_product_sales;

DROP FUNCTION ra_material_sales_add_act(ra_material_sales);
DROP VIEW ra_material_sales_list_view;
DROP TABLE ra_material_sales;
DROP TABLE rg_material_sales;

DROP FUNCTION ra_product_orders_add_act(ra_product_orders);
DROP VIEW ra_product_orders_list_view;
DROP TABLE ra_product_orders;
DROP TABLE rg_product_orders;

DELETE FROM rg_product_orders;

DELETE FROM rg_materials;
DELETE FROM rg_products;

DROP TRIGGER ra_materials_after ON ra_materials;
DROP TRIGGER ra_materials_before ON ra_materials;
DELETE FROM ra_materials;

CREATE TRIGGER ra_materials_after
  AFTER INSERT OR UPDATE OR DELETE
  ON ra_materials
  FOR EACH ROW
  EXECUTE PROCEDURE ra_materials_process();

CREATE TRIGGER ra_materials_before
  BEFORE INSERT OR UPDATE OR DELETE
  ON ra_materials
  FOR EACH ROW
  EXECUTE PROCEDURE ra_materials_process();


DROP TRIGGER ra_products_after ON ra_products;
DROP TRIGGER ra_products_before ON ra_products;
DELETE FROM ra_products;

CREATE TRIGGER ra_products_after
  AFTER INSERT OR UPDATE OR DELETE
  ON ra_products
  FOR EACH ROW
  EXECUTE PROCEDURE ra_products_process();

CREATE TRIGGER ra_products_before
  BEFORE INSERT OR UPDATE OR DELETE
  ON ra_products
  FOR EACH ROW
  EXECUTE PROCEDURE ra_products_process();

SELECT const_negat_product_balance_restrict_set_val(FALSE);
SELECT const_negat_material_balance_restrict_set_val(FALSE);
*/


DELETE FROM doc_log
 WHERE doc_type='doc_client_order';
DELETE FROM doc_client_orders;


CREATE TABLE doc_reprocess_stat
(
	doc_sequence doc_sequences NOT NULL PRIMARY KEY,
  start_time timestamp with time zone DEFAULT now(),
  update_time timestamp with time zone,
  end_time timestamp without time zone,
  count_total integer,
  count_done integer,
  time_to_go interval,
  doc_id integer,
  doc_type doc_types,
  error_message text,
  res boolean,
  user_id int references users (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE doc_reprocess_stat
  OWNER TO bellagio;


DROP TABLE doc_actual_point;

ALTER TABLE doc_client_orders ALTER COLUMN processed SET DEFAULT FALSE;
ALTER TABLE doc_productions ALTER COLUMN processed SET DEFAULT FALSE;
ALTER TABLE doc_product_disposals ALTER COLUMN processed SET DEFAULT FALSE;
ALTER TABLE doc_material_disposals ALTER COLUMN processed SET DEFAULT FALSE;
ALTER TABLE doc_material_procurements ALTER COLUMN processed SET DEFAULT FALSE;
ALTER TABLE doc_sales ALTER COLUMN processed SET DEFAULT FALSE;
ALTER TABLE doc_expences ALTER COLUMN processed SET DEFAULT FALSE;


UPDATE doc_material_disposals
   SET processed=true
 WHERE NOT processed OR processed IS NULL;

UPDATE doc_product_disposals
   SET processed=true
 WHERE NOT processed OR processed IS NULL;

UPDATE doc_client_orders
   SET processed=true
 WHERE NOT processed OR processed IS NULL;

UPDATE doc_productions
   SET processed=true
 WHERE NOT processed OR processed IS NULL;

UPDATE doc_material_procurements
   SET processed=true
 WHERE NOT processed OR processed IS NULL;

UPDATE doc_sales
   SET processed=true
 WHERE NOT processed OR processed IS NULL;


UPDATE doc_expences
   SET processed=true
 WHERE NOT processed OR processed IS NULL;


		--constant value table
		CREATE TABLE IF NOT EXISTS const_grid_refresh_interval
		(name text, descr text, val int,
			val_type text);
		ALTER TABLE const_grid_refresh_interval OWNER TO bellagio;
		INSERT INTO const_grid_refresh_interval (name,descr,val,val_type) VALUES (
			'Период обновления таблиц',
			'Период обновления таблиц в секундах',
			15,
			'Int'
		);
	
		--constant get value
		CREATE OR REPLACE FUNCTION const_grid_refresh_interval_val()
		RETURNS int AS
		$BODY$
			SELECT val::int AS val FROM const_grid_refresh_interval LIMIT 1;
		$BODY$
		LANGUAGE sql VOLATILE COST 100;
		ALTER FUNCTION const_grid_refresh_interval_val() OWNER TO bellagio;
		
		--constant set value
		CREATE OR REPLACE FUNCTION const_grid_refresh_interval_set_val(Int)
		RETURNS void AS
		$BODY$
			UPDATE const_grid_refresh_interval SET val=$1;
		$BODY$
		LANGUAGE sql VOLATILE COST 100;
		ALTER FUNCTION const_grid_refresh_interval_set_val(Int) OWNER TO bellagio;
		
		--edit view: all keys and descr
		CREATE OR REPLACE VIEW const_grid_refresh_interval_view AS
		SELECT t.name,t.descr
		,t.val::text AS val_descr,t.val_type
		FROM const_grid_refresh_interval AS t
		
		;
		ALTER VIEW const_grid_refresh_interval_view OWNER TO bellagio;

	
--SELECT doc_reprocess(NULL,NULL)	



ALTER TABLE doc_client_orders_t_materials ADD COLUMN disc_percent numeric(15,2);
ALTER TABLE doc_client_orders_t_materials ADD COLUMN price_no_disc numeric(15,2);
ALTER TABLE doc_client_orders_t_products ADD COLUMN disc_percent numeric(15,2);
ALTER TABLE doc_client_orders_t_products ADD COLUMN price_no_disc numeric(15,2);

-- Table: doc_client_orders_t_tmp_materials

DROP VIEW doc_client_orders_t_tmp_materials_list;
DROP TABLE doc_client_orders_t_tmp_materials;

CREATE TABLE doc_client_orders_t_tmp_materials
(
  view_id varchar(32),
  line_number integer NOT NULL,
  login_id integer NOT NULL,
  material_id integer NOT NULL,
  quant numeric(19,3),
  price numeric(15,2),
  total numeric(15,2),
  disc_percent numeric(15,2),
  price_no_disc numeric(15,2),
  CONSTRAINT doc_client_orders_t_tmp_materials_pkey PRIMARY KEY (view_id, line_number),
  CONSTRAINT doc_client_orders_t_tmp_materials_login_id_fkey FOREIGN KEY (login_id)
      REFERENCES logins (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT doc_client_orders_t_tmp_materials_material_id_fkey FOREIGN KEY (material_id)
      REFERENCES materials (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE doc_client_orders_t_tmp_materials
  OWNER TO bellagio;

-- Trigger: doc_client_orders_t_tmp_materials_after on doc_client_orders_t_tmp_materials

-- DROP TRIGGER doc_client_orders_t_tmp_materials_after ON doc_client_orders_t_tmp_materials;

CREATE TRIGGER doc_client_orders_t_tmp_materials_after
  AFTER INSERT OR UPDATE OR DELETE
  ON doc_client_orders_t_tmp_materials
  FOR EACH ROW
  EXECUTE PROCEDURE doc_client_orders_t_tmp_materials_process();

-- Trigger: doc_client_orders_t_tmp_materials_before on doc_client_orders_t_tmp_materials

-- DROP TRIGGER doc_client_orders_t_tmp_materials_before ON doc_client_orders_t_tmp_materials;

CREATE TRIGGER doc_client_orders_t_tmp_materials_before
  BEFORE INSERT OR UPDATE OR DELETE
  ON doc_client_orders_t_tmp_materials
  FOR EACH ROW
  EXECUTE PROCEDURE doc_client_orders_t_tmp_materials_process();

CREATE OR REPLACE VIEW doc_client_orders_t_tmp_materials_list AS 
	SELECT 
		doc_lines.*,
		m.name AS material_descr
	FROM doc_client_orders_t_tmp_materials doc_lines
	LEFT JOIN materials m ON m.id = doc_lines.material_id
	
	ORDER BY doc_lines.line_number;

ALTER TABLE doc_client_orders_t_tmp_materials_list
  OWNER TO bellagio;


-- Table: doc_client_orders_t_tmp_products

DROP VIEW doc_client_orders_t_tmp_products_list;
DROP TABLE doc_client_orders_t_tmp_products;

CREATE TABLE doc_client_orders_t_tmp_products
(
  view_id varchar(32),
  line_number integer NOT NULL,
  login_id integer NOT NULL,
  quant numeric(19,3),
  price numeric(15,2),
  total numeric(15,2),
  disc_percent numeric(15,2),
  price_no_disc numeric(15,2),
  product_id integer,
  CONSTRAINT doc_client_orders_t_tmp_products_pkey PRIMARY KEY (view_id, line_number),
  CONSTRAINT doc_client_orders_t_tmp_products_login_id_fkey FOREIGN KEY (login_id)
      REFERENCES logins (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT doc_client_orders_t_tmp_products_product_id_fkey FOREIGN KEY (product_id)
      REFERENCES products (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE doc_client_orders_t_tmp_products
  OWNER TO bellagio;

-- Trigger: doc_client_orders_t_tmp_products_after on doc_client_orders_t_tmp_products

-- DROP TRIGGER doc_client_orders_t_tmp_products_after ON doc_client_orders_t_tmp_products;

CREATE TRIGGER doc_client_orders_t_tmp_products_after
  AFTER INSERT OR UPDATE OR DELETE
  ON doc_client_orders_t_tmp_products
  FOR EACH ROW
  EXECUTE PROCEDURE doc_client_orders_t_tmp_products_process();

-- Trigger: doc_client_orders_t_tmp_products_before on doc_client_orders_t_tmp_products

-- DROP TRIGGER doc_client_orders_t_tmp_products_before ON doc_client_orders_t_tmp_products;

CREATE TRIGGER doc_client_orders_t_tmp_products_before
  BEFORE INSERT OR UPDATE OR DELETE
  ON doc_client_orders_t_tmp_products
  FOR EACH ROW
  EXECUTE PROCEDURE doc_client_orders_t_tmp_products_process();

-- View: doc_client_orders_t_tmp_products_list

--DROP VIEW doc_client_orders_t_tmp_products_list;

CREATE OR REPLACE VIEW doc_client_orders_t_tmp_products_list AS 
	SELECT 
		doc_lines.*,
		p.name AS product_descr
	FROM doc_client_orders_t_tmp_products doc_lines
	LEFT JOIN products p ON p.id = doc_lines.product_id
	ORDER BY doc_lines.line_number;

ALTER TABLE doc_client_orders_t_tmp_products_list
  OWNER TO bellagio;

-- Function: doc_client_orders_before_write(in_view_id varchar(32), in_doc_id integer)

 DROP FUNCTION doc_client_orders_before_write(in_view_id varchar(32), in_doc_id integer);

CREATE OR REPLACE FUNCTION doc_client_orders_before_write(in_view_id varchar(32), in_doc_id integer)
  RETURNS void AS
$BODY$
	
	--clear fact table
	DELETE FROM doc_client_orders_t_materials WHERE doc_id=in_doc_id;
	
	--copy data from temp to fact table
	INSERT INTO doc_client_orders_t_materials
	(doc_id,line_number,material_id,quant,price,total,disc_percent,price_no_disc)
	(SELECT in_doc_id
	,line_number,material_id,quant,price,total,disc_percent,price_no_disc					
	FROM doc_client_orders_t_tmp_materials
	WHERE view_id=in_view_id);
	
	--clear temp table
	DELETE FROM doc_client_orders_t_tmp_materials WHERE view_id=in_view_id;
	
	--clear fact table
	DELETE FROM doc_client_orders_t_products WHERE doc_id=in_doc_id;
	
	--copy data from temp to fact table
	INSERT INTO doc_client_orders_t_products
	(doc_id,line_number,product_id,quant,price,total,disc_percent,price_no_disc)
	(SELECT in_doc_id
	,t.line_number,t.product_id,t.quant,t.price,t.total,t.disc_percent,t.price_no_disc					
	FROM doc_client_orders_t_tmp_products AS t
	WHERE view_id=in_view_id);				
	
	--clear temp table
	DELETE FROM doc_client_orders_t_tmp_products WHERE view_id=in_view_id;
	
	UPDATE 	doc_client_orders
	SET total =
		coalesce((SELECT sum(t.total) FROM doc_client_orders_t_products t),0)+
		coalesce((SELECT sum(t.total) FROM doc_client_orders_t_materials t),0)
	WHERE id=in_doc_id;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_client_orders_before_write(in_view_id varchar(32), in_doc_id integer)
  OWNER TO bellagio;  
DROP FUNCTION doc_client_orders_before_open(integer, integer);  

-- Function: doc_client_orders_before_open(varchar(32),integer, integer)

-- DROP FUNCTION doc_client_orders_before_open(varchar(32),integer, integer);

CREATE OR REPLACE FUNCTION doc_client_orders_before_open(in_view_id varchar(32), in_login_id integer, in_doc_id integer)
  RETURNS void AS
$BODY$
--BEGIN
	DELETE FROM doc_client_orders_t_tmp_materials WHERE view_id=in_view_id;
	--IF (in_doc_id IS NOT NULL AND in_doc_id>0) THEN
		INSERT INTO doc_client_orders_t_tmp_materials
		(view_id,login_id,line_number,material_id,quant,price,total,disc_percent,price_no_disc)
		(SELECT in_view_id,in_login_id
		,line_number,material_id,quant,price,total,disc_percent,price_no_disc
		FROM doc_client_orders_t_materials
		WHERE doc_id=in_doc_id);
	--END IF;
	
	DELETE FROM doc_client_orders_t_tmp_products WHERE view_id=in_view_id;
	--IF (in_doc_id IS NOT NULL AND in_doc_id>0) THEN
		INSERT INTO doc_client_orders_t_tmp_products
		(view_id,login_id,line_number,product_id,quant,price,total,disc_percent,price_no_disc)
		(SELECT in_view_id,in_login_id
		,line_number,product_id,quant,price,total,disc_percent,price_no_disc					
		FROM doc_client_orders_t_products
		WHERE doc_id=in_doc_id);
	--END IF;
				
--END;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_client_orders_before_open(varchar(32),integer, integer)
  OWNER TO bellagio;

CREATE INDEX doc_client_orders_client_order_state_idx
  ON doc_client_orders
  USING btree
  (client_order_state);


-- Function: doc_client_orders_t_tmp_materials_process()

-- DROP FUNCTION doc_client_orders_t_tmp_materials_process();

CREATE OR REPLACE FUNCTION doc_client_orders_t_tmp_materials_process()
  RETURNS trigger AS
$BODY$
			BEGIN
				IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
					SELECT coalesce(MAX(t.line_number),0)+1 INTO NEW.line_number FROM doc_client_orders_t_tmp_materials AS t WHERE t.view_id = NEW.view_id;
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
					UPDATE doc_client_orders_t_tmp_materials
					SET line_number = line_number - 1
					WHERE view_id=OLD.view_id AND line_number>OLD.line_number;
					RETURN OLD;
				END IF;
			END;
			$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_client_orders_t_tmp_materials_process()
  OWNER TO bellagio;

-- Function: doc_client_orders_t_tmp_products_process()

-- DROP FUNCTION doc_client_orders_t_tmp_products_process();

CREATE OR REPLACE FUNCTION doc_client_orders_t_tmp_products_process()
  RETURNS trigger AS
$BODY$
			BEGIN
				IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
					SELECT coalesce(MAX(t.line_number),0)+1 INTO NEW.line_number FROM doc_client_orders_t_tmp_products AS t WHERE t.view_id = NEW.view_id;
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
					UPDATE doc_client_orders_t_tmp_products
					SET line_number = line_number - 1
					WHERE view_id=OLD.view_id AND line_number>OLD.line_number;
					RETURN OLD;
				END IF;
			END;
			$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_client_orders_t_tmp_products_process()
  OWNER TO bellagio;


		CREATE TABLE receipt_head
		(client_id int REFERENCES clients(id),discount_id int REFERENCES discounts(id),doc_client_order_id int REFERENCES doc_client_orders(id));
		
		ALTER TABLE receipt_head OWNER TO bellagio;


ALTER TABLE receipt_head ADD COLUMN user_id int REFERENCES users(id);

CREATE INDEX receipt_head_user_id_idx
  ON receipt_head
  USING btree
  (user_id);



		CREATE TABLE receipt_payment_types
		(user_id int REFERENCES users(id),dt timestamp,payment_type_for_sale_id int REFERENCES payment_types_for_sale(id),total  numeric(15,2),CONSTRAINT receipt_payment_types_pkey PRIMARY KEY (user_id,dt));
		
		ALTER TABLE receipt_payment_types OWNER TO bellagio;
	
		CREATE TABLE receipt_payment_types
		(payment_type_for_sale_id int REFERENCES payment_types_for_sale(id),total  numeric(2,2),user_id int REFERENCES users(id),CONSTRAINT receipt_payment_types_pkey PRIMARY KEY (user_id,payment_type_for_sale_id));
		
		ALTER TABLE receipt_payment_types OWNER TO bellagio;

CREATE OR REPLACE VIEW receipt_payment_types_list AS
	SELECT
		t.*,
		pt.name AS payment_type_for_sale_descr,
		pt.kkm_type_close AS kkm_type_close
	FROM receipt_payment_types t
	LEFT JOIN payment_types_for_sale AS pt ON pt.id=t.payment_type_for_sale_id
	ORDER BY t.user_id,t.dt
	;
	
ALTER VIEW receipt_payment_types_list OWNER TO bellagio;


DROP FUNCTION receipt_close(int,int,int,int,int);

CREATE OR REPLACE FUNCTION receipt_close(
	in_store_id int,
	in_user_id int,
	in_payment_type_for_sale_id int,
	in_client_id int,
	in_doc_client_order_id int
)
  RETURNS integer AS
$BODY$
DECLARE
	v_doc_id int;
BEGIN
	--head
	INSERT INTO doc_sales
	(	date_time,
		store_id,
		user_id,
		payment_type_for_sale_id,
		client_id,
		doc_client_order_id)
	VALUES (now(),$1,$2,$3,$4,$5)
	RETURNING id INTO v_doc_id;
	
	--table products
	INSERT INTO doc_sales_t_products
	(doc_id, product_id, doc_production_id,
	quant, price, total,
	disc_percent,price_no_disc,total_no_disc)
		(SELECT v_doc_id, p.item_id, p.doc_production_id,
			p.quant, ROUND(p.total/p.quant,2), p.total,
			p.disc_percent,p.price_no_disc,ROUND(p.price_no_disc*p.quant,2)
		FROM receipts AS p
		WHERE p.user_id=$2 AND p.item_type=0
		);
	
	--table materials
	INSERT INTO doc_sales_t_materials
	(doc_id, material_id,
	quant, price, total,
	disc_percent,price_no_disc,total_no_disc)
		(SELECT v_doc_id, m.item_id,
		m.quant, ROUND(m.total/m.quant,2), m.total,
		m.disc_percent,m.price_no_disc,ROUND(m.price_no_disc*m.quant,2)
		FROM receipts AS m
		WHERE m.user_id=$2 AND m.item_type=1
	);

	--process new doc
	UPDATE doc_sales SET processed=TRUE
	WHERE id=v_doc_id;
	
	DELETE FROM receipts WHERE user_id = $2;
	
	RETURN v_doc_id;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100 CALLED ON NULL INPUT;
ALTER FUNCTION receipt_close(int,int,int,int,int)
  OWNER TO bellagio;
  
ALTER TABLE receipt_payment_types ALTER COLUMN dt SET DEFAULT now();  


-- Function: receipt_insert_item(integer, integer, integer)

--DROP FUNCTION receipt_insert_item(integer, integer, integer, integer);

CREATE OR REPLACE FUNCTION receipt_insert_item(
		in_item_id integer,
		in_doc_production_id int,
		in_item_type integer,
		in_user_id integer
		)
  RETURNS void AS
$BODY$
DECLARE
	v_name text;
	v_price numeric(15,2);
	v_disc_percent numeric;
BEGIN
	IF in_item_type = 0 THEN
		SELECT p.name::text,d_p.price
		INTO v_name, v_price
		FROM doc_productions AS d_p
		LEFT JOIN products p ON p.id=d_p.product_id
		WHERE d_p.id=in_doc_production_id;
	ELSE
		SELECT name::text,price
		INTO v_name, v_price
		FROM materials
		WHERE id=in_item_id;
	END IF;

	SELECT d.percent INTO v_disc_percent
	FROM receipt_head h
	LEFT JOIN discounts AS d ON d.id=h.discount_id
	WHERE user_id=in_user_id;

	IF v_disc_percent IS NULL THEN
		v_disc_percent = 0;
	END IF;
	--RAISE EXCEPTION 'percent=%',v_disc_percent;

	UPDATE receipts
	SET quant = quant + 1,
		price_no_disc = v_price,
		disc_percent = v_disc_percent,		
		total = calc_total(v_price*(quant+1),v_disc_percent)
	WHERE
		user_id = in_user_id
		AND item_id = in_item_id
		AND item_type = in_item_type
		AND (in_item_type=1
			OR (in_item_type=0 AND in_doc_production_id=doc_production_id)
		);
	IF NOT FOUND THEN
		BEGIN
			INSERT INTO receipts
			(	user_id,
				item_id,
				doc_production_id,
				item_type,
				item_name,
				quant,
				disc_percent,
				price_no_disc,
				total
			)
			VALUES (
				in_user_id,
				in_item_id,
				in_doc_production_id,
				in_item_type,
				v_name,
				1,
				v_disc_percent,
				v_price,				
				calc_total(v_price,v_disc_percent)
			);
		EXCEPTION WHEN OTHERS THEN
			UPDATE receipts
			SET quant = quant + 1,
				price_no_disc = v_price,
				disc_percent = v_disc_percent,		
				total = calc_total(v_price*(quant+1),v_disc_percent)
			WHERE
				user_id = in_user_id
				AND item_id = in_item_id
				AND item_type = in_item_type
				AND (in_item_type=1
					OR (in_item_type=0 AND in_doc_production_id=doc_production_id)
				);
		END;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION receipt_insert_item(in_item_id integer, in_doc_production_id int, in_item_type integer, in_user_id integer)
  OWNER TO bellagio;
  
ALTER TABLE doc_sales DROP CONSTRAINT doc_sales_payment_type_for_sale_id_fkey;  


ALTER TABLE doc_sales_payment_types DROP COLUMN total;
ALTER TABLE doc_sales_payment_types ADD COLUMN total numeric(15,2);


		--constant value table
		CREATE TABLE IF NOT EXISTS const_session_live_time
		(name text, descr text, val interval,
			val_type text);
		ALTER TABLE const_session_live_time OWNER TO bellagio;
		INSERT INTO const_session_live_time (name,descr,val,val_type) VALUES (
			'Время жизни сессии',
			'Время, в течении которого сессия не будет удаляться на сервере',
			
				'48:00'
				,
			'Interval'
		);
	
		--constant get value
		CREATE OR REPLACE FUNCTION const_session_live_time_val()
		RETURNS interval AS
		$BODY$
			SELECT val::interval AS val FROM const_session_live_time LIMIT 1;
		$BODY$
		LANGUAGE sql VOLATILE COST 100;
		ALTER FUNCTION const_session_live_time_val() OWNER TO bellagio;
		
		--constant set value
		CREATE OR REPLACE FUNCTION const_session_live_time_set_val(Interval)
		RETURNS void AS
		$BODY$
			UPDATE const_session_live_time SET val=$1;
		$BODY$
		LANGUAGE sql VOLATILE COST 100;
		ALTER FUNCTION const_session_live_time_set_val(Interval) OWNER TO bellagio;
		
		--edit view: all keys and descr
		CREATE OR REPLACE VIEW const_session_live_time_view AS
		SELECT t.name,t.descr
		,t.val::text AS val_descr
		,t.val_type::text AS val_type
		FROM const_session_live_time AS t
		
		;
		ALTER VIEW const_session_live_time_view OWNER TO bellagio;
	

		CREATE OR REPLACE VIEW constants_list_view AS
		
		SELECT 'sale_item_cols' AS id,name,descr,val_descr,val_type FROM const_sale_item_cols_view
		UNION ALL
		
		SELECT 'def_store' AS id,name,descr,val_descr,val_type FROM const_def_store_view
		UNION ALL
		
		SELECT 'doc_per_page_count' AS id,name,descr,val_descr,val_type FROM const_doc_per_page_count_view
		UNION ALL
		
		SELECT 'grid_refresh_interval' AS id,name,descr,val_descr,val_type FROM const_grid_refresh_interval_view
		UNION ALL
		
		SELECT 'shift_length_time' AS id,name,descr,val_descr,val_type FROM const_shift_length_time_view
		UNION ALL
		
		SELECT 'shift_start_time' AS id,name,descr,val_descr,val_type FROM const_shift_start_time_view
		UNION ALL
		
		SELECT 'cel_phone_for_sms' AS id,name,descr,val_descr,val_type FROM const_cel_phone_for_sms_view
		UNION ALL
		
		SELECT 'negat_material_balance_restrict' AS id,name,descr,val_descr,val_type FROM const_negat_material_balance_restrict_view
		UNION ALL
		
		SELECT 'negat_product_balance_restrict' AS id,name,descr,val_descr,val_type FROM const_negat_product_balance_restrict_view
		UNION ALL
		
		SELECT 'def_material_group' AS id,name,descr,val_descr,val_type FROM const_def_material_group_view
		UNION ALL
		
		SELECT 'def_payment_type_for_sale' AS id,name,descr,val_descr,val_type FROM const_def_payment_type_for_sale_view
		UNION ALL
		
		SELECT 'def_client' AS id,name,descr,val_descr,val_type FROM const_def_client_view
		UNION ALL
		
		SELECT 'def_discount' AS id,name,descr,val_descr,val_type FROM const_def_discount_view
		UNION ALL
		
		SELECT 'session_live_time' AS id,name,descr,val_descr,val_type FROM const_session_live_time_view;
		ALTER VIEW constants_list_view OWNER TO bellagio;	
		
		
		
-- ОБНОВЛЕНИЕ ВИДОВ ОПЛАТ!!!
INSERT INTO doc_sales_payment_types
(doc_id,payment_type_for_sale_id,total)
(
SELECT d.id, coalesce(d.payment_type_for_sale_id,1),d.total FROM doc_sales d WHERE d.id NOT IN (SELECT t.doc_id FROM doc_sales_payment_types t)
)		


-- View: doc_client_orders_t_materials_list

--DROP VIEW doc_client_orders_t_materials_list;

CREATE OR REPLACE VIEW doc_client_orders_t_materials_list AS 
	SELECT 
		doc_lines.*,
		m.name AS material_descr
	FROM doc_client_orders_t_materials doc_lines
	LEFT JOIN materials m ON m.id = doc_lines.material_id
	
	ORDER BY doc_lines.line_number;

ALTER TABLE doc_client_orders_t_materials_list
  OWNER TO bellagio;


-- View: doc_client_orders_t_products_list

--DROP VIEW doc_client_orders_t_products_list;

CREATE OR REPLACE VIEW doc_client_orders_t_products_list AS 
	SELECT 
		doc_lines.*,
		p.name AS product_descr
	FROM doc_client_orders_t_products doc_lines
	LEFT JOIN products p ON p.id = doc_lines.product_id
	ORDER BY doc_lines.line_number;

ALTER TABLE doc_client_orders_t_products_list
  OWNER TO bellagio;




--*****************************************
-- Table: doc_log

DROP TABLE doc_log;

CREATE TABLE doc_log
(
	date_time timestamp without time zone,
  doc_type doc_types,
  doc_id integer,
  
  CONSTRAINT doc_log_pkey PRIMARY KEY (date_time)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE doc_log
  OWNER TO bellagio;

-- Index: doc_log_date_time_index

-- DROP INDEX doc_log_date_time_index;

CREATE INDEX doc_log_date_time_sec_idx
  ON doc_log
  USING btree
  (date_trunc('second',date_time));

-- Index: doc_log_doc_index

-- DROP INDEX doc_log_doc_index;

CREATE UNIQUE INDEX doc_log_doc_index
  ON doc_log
  USING btree
  (doc_type, doc_id);

SELECT doc_log_insert('production'::doc_types,t.id) FROM doc_productions t
SELECT doc_log_insert('product_disposal'::doc_types,t.id) FROM doc_product_disposals t
SELECT doc_log_insert('material_procurement'::doc_types,t.id) FROM doc_material_procurements t
SELECT doc_log_insert('material_disposal'::doc_types,t.id) FROM doc_material_disposals t
SELECT doc_log_insert('sale'::doc_types,t.id) FROM doc_sales t
SELECT doc_log_insert('expence'::doc_types,t.id) FROM doc_expence t
SELECT doc_log_insert('doc_client_order'::doc_types,t.id) FROM doc_client_order t


CREATE TYPE doc_sequences AS ENUM (

	'materials'			
			
);
ALTER TYPE doc_sequences OWNER TO bellagio;



CREATE TABLE seq_contents
(
	doc_sequence doc_sequences NOT NULL,
  doc_type doc_types NOT NULL,
  CONSTRAINT seq_contents_pkey PRIMARY KEY (doc_sequence,doc_type)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE seq_contents
  OWNER TO bellagio;

INSERT INTO seq_contents
VALUES
('materials','production'),
('materials','product_disposal'),
('materials','material_procurement'),
('materials','material_disposal'),
('materials','sale')
;



-- Table: seq_violations

-- DROP TABLE seq_violations;

CREATE TABLE seq_violations
(
  doc_sequence doc_sequences NOT NULL,
  date_time timestamp without time zone NOT NULL DEFAULT (now())::timestamp without time zone,
  doc_log_date_time timestamp without time zone,
  reprocessing boolean DEFAULT false,
  CONSTRAINT seq_violations_pkey PRIMARY KEY (doc_sequence)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE seq_violations
  OWNER TO bellagio;

-- VIEW: doc_reprocess_stat_list

--DROP VIEW doc_reprocess_stat_list;

CREATE OR REPLACE VIEW doc_reprocess_stat_list AS
	SELECT
		d.*,
		s.doc_log_date_time,
		s.date_time,
		s.reprocessing,
		
		CASE WHEN d.count_total IS NOT NULL AND d.count_total>0 THEN
			(d.count_done/d.count_total*100)::int
		ELSE 0::int
		END
		AS done_percent
		 
	FROM doc_reprocess_stat d
	FULL JOIN seq_violations AS s ON s.doc_sequence = d.doc_sequence
	;
	
ALTER VIEW doc_reprocess_stat_list OWNER TO bellagio;


UPDATE const_doc_per_page_count SET val=50;


ALTER TABLE doc_client_orders ADD COLUMN store_id integer references stores (id);
CREATE UNIQUE INDEX oc_client_order_store_number_idx
  ON doc_client_orders
  USING btree
  (store_id,number);


-- View: doc_client_orders_list

DROP VIEW doc_client_orders_list;

CREATE OR REPLACE VIEW doc_client_orders_list AS 
	SELECT
		d.id,
		d.number,
		d.processed,
		d.date_time,
		d.delivery_type,
		d.client_name,
		d.client_tel,

		d.recipient_type,
		d.recipient_name,
		d.recipient_tel,
		
		d.address,
		d.delivery_date,
		d.delivery_hour_id,
		dh.descr AS delivery_hour_descr,
		d.card,
		d.card_text,
		d.anonym_gift,
		
		d.delivery_note_type,
		d.delivery_comment,
		d.extra_comment,
		d.payment_type,
		
		d.client_order_state,
		
		d.payed,
		d.number_from_site,
		
		d.store_id,
		st.name AS store_descr,
		
		d.client_id,
		cl.name AS client_descr
	
	FROM doc_client_orders AS d
	LEFT JOIN delivery_hours_list AS dh ON dh.id=d.delivery_hour_id
	LEFT JOIN stores AS st ON st.id=d.store_id
	LEFT JOIN clients AS cl ON cl.id=d.client_id
	ORDER BY d.delivery_date;

ALTER TABLE doc_client_orders_list OWNER TO bellagio;



-- Function: receipt_fill_on_client_order(int,int,int)

--DROP FUNCTION receipt_fill_on_client_order(int,int,int);

CREATE OR REPLACE FUNCTION receipt_fill_on_client_order(
	in_store_id int,
	in_user_id int,
	in_doc_client_order_id int
)
  RETURNS void AS
$BODY$

	DELETE FROM receipts WHERE user_id = in_user_id;
	DELETE FROM receipt_head WHERE user_id = in_user_id;

	INSERT INTO receipt_head
		(client_id, doc_client_order_id, user_id)
	(SELECT
		t.client_id, in_doc_client_order_id, in_user_id
	FROM doc_client_orders t
	WHERE t.id = in_doc_client_order_id
	);

	--букеты
	INSERT INTO receipts
	(	user_id,
		item_id,item_type,item_name,
		doc_production_id,
		quant,price_no_disc,total,ord
	)
	(SELECT
		in_user_id,
		t.product_id,0,p.name::text,
		(SELECT b.doc_production_id
			FROM rg_products_balance(
				ARRAY[in_store_id],ARRAY[t.product_id],'{}'
			) AS b
		LEFT JOIN doc_productions AS d_pr
			ON d_pr.id=b.doc_production_id
		ORDER BY d_pr.date_time
		LIMIT 1
		),
		t.quant,t.price_no_disc,t.total,now()::timestamp
	FROM doc_client_orders_t_products t
	LEFT JOIN products p ON p.id=t.product_id
	WHERE t.doc_id=in_doc_client_order_id
	);
	
	--материалы
	INSERT INTO receipts
	(	user_id,
		item_id,item_type,item_name,
		doc_production_id,
		quant,price_no_disc,total,ord
	)
	(SELECT
		in_user_id,
		t.material_id,1,m.name::text,
		0,
		t.quant,t.price_no_disc,t.total,now()::timestamp
	FROM doc_client_orders_t_materials t
	LEFT JOIN materials m ON m.id=t.material_id
	WHERE t.doc_id=in_doc_client_order_id
	);
	
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION receipt_fill_on_client_order(int,int,int)
  OWNER TO bellagio;
  
/*  
ALTER TABLE const_cel_phone_for_sms ADD COLUMN ctrl_class text;
ALTER TABLE const_cel_phone_for_sms ADD COLUMN view_class text;
ALTER TABLE const_def_client ADD COLUMN ctrl_class text;
ALTER TABLE const_def_client ADD COLUMN view_class text;
ALTER TABLE const_def_discount ADD COLUMN ctrl_class text;
ALTER TABLE const_def_discount ADD COLUMN view_class text;
ALTER TABLE const_def_material_group ADD COLUMN ctrl_class text;
ALTER TABLE const_def_material_group ADD COLUMN view_class text;
ALTER TABLE const_def_payment_type_for_sale ADD COLUMN ctrl_class text;
ALTER TABLE const_def_payment_type_for_sale ADD COLUMN view_class text;
ALTER TABLE const_def_store ADD COLUMN ctrl_class text;
ALTER TABLE const_def_store ADD COLUMN view_class text;
ALTER TABLE const_doc_per_page_count ADD COLUMN ctrl_class text;
ALTER TABLE const_doc_per_page_count ADD COLUMN view_class text;
ALTER TABLE const_grid_refresh_interval ADD COLUMN ctrl_class text;
ALTER TABLE const_grid_refresh_interval ADD COLUMN view_class text;
ALTER TABLE const_negat_material_balance_restrict ADD COLUMN ctrl_class text;
ALTER TABLE const_negat_material_balance_restrict ADD COLUMN view_class text;
ALTER TABLE const_negat_product_balance_restrict ADD COLUMN ctrl_class text;
ALTER TABLE const_negat_product_balance_restrict ADD COLUMN view_class text;
ALTER TABLE const_sale_item_cols ADD COLUMN ctrl_class text;
ALTER TABLE const_sale_item_cols ADD COLUMN view_class text;
ALTER TABLE const_session_live_time ADD COLUMN ctrl_class text;
ALTER TABLE const_session_live_time ADD COLUMN view_class text;
ALTER TABLE const_shift_length_time ADD COLUMN ctrl_class text;
ALTER TABLE const_shift_length_time ADD COLUMN view_class text;
ALTER TABLE const_shift_start_time ADD COLUMN ctrl_class text;
ALTER TABLE const_shift_start_time ADD COLUMN view_class text;
*/

CREATE UNIQUE INDEX clients_disc_card_id_idx
  ON clients
  USING btree
  (disc_card_id);


-- View: constants_list_view

-- DROP VIEW constants_list_view;

CREATE OR REPLACE VIEW constants_list_view AS 
 SELECT 'sale_item_cols'::text AS id,
    const_sale_item_cols_view.name,
    const_sale_item_cols_view.descr,
    const_sale_item_cols_view.val_descr,
    const_sale_item_cols_view.val_type,
    0 AS val_id
   FROM const_sale_item_cols_view
UNION ALL
 SELECT 'def_store'::text AS id,
    const_def_store_view.name,
    const_def_store_view.descr,
    const_def_store_view.val_descr,
    const_def_store_view.val_type,
    const_def_store_view.val_id
   FROM const_def_store_view
UNION ALL
 SELECT 'doc_per_page_count'::text AS id,
    const_doc_per_page_count_view.name,
    const_doc_per_page_count_view.descr,
    const_doc_per_page_count_view.val_descr,
    const_doc_per_page_count_view.val_type,
    0 AS val_id
   FROM const_doc_per_page_count_view
UNION ALL
 SELECT 'grid_refresh_interval'::text AS id,
    const_grid_refresh_interval_view.name,
    const_grid_refresh_interval_view.descr,
    const_grid_refresh_interval_view.val_descr,
    const_grid_refresh_interval_view.val_type,
    0 AS val_id
   FROM const_grid_refresh_interval_view
UNION ALL
 SELECT 'shift_length_time'::text AS id,
    const_shift_length_time_view.name,
    const_shift_length_time_view.descr,
    const_shift_length_time_view.val_descr,
    const_shift_length_time_view.val_type,
    0 AS val_id
   FROM const_shift_length_time_view
UNION ALL
 SELECT 'shift_start_time'::text AS id,
    const_shift_start_time_view.name,
    const_shift_start_time_view.descr,
    const_shift_start_time_view.val_descr,
    const_shift_start_time_view.val_type,
    0 AS val_id
   FROM const_shift_start_time_view
UNION ALL
 SELECT 'cel_phone_for_sms'::text AS id,
    const_cel_phone_for_sms_view.name,
    const_cel_phone_for_sms_view.descr,
    const_cel_phone_for_sms_view.val_descr,
    const_cel_phone_for_sms_view.val_type,
    0 AS val_id
   FROM const_cel_phone_for_sms_view
UNION ALL
 SELECT 'negat_material_balance_restrict'::text AS id,
    const_negat_material_balance_restrict_view.name,
    const_negat_material_balance_restrict_view.descr,
    const_negat_material_balance_restrict_view.val_descr,
    const_negat_material_balance_restrict_view.val_type,
    0 AS val_id
   FROM const_negat_material_balance_restrict_view
UNION ALL
 SELECT 'negat_product_balance_restrict'::text AS id,
    const_negat_product_balance_restrict_view.name,
    const_negat_product_balance_restrict_view.descr,
    const_negat_product_balance_restrict_view.val_descr,
    const_negat_product_balance_restrict_view.val_type,
    0 AS val_id
   FROM const_negat_product_balance_restrict_view
UNION ALL
 SELECT 'def_material_group'::text AS id,
    const_def_material_group_view.name,
    const_def_material_group_view.descr,
    const_def_material_group_view.val_descr,
    const_def_material_group_view.val_type,
    0 AS val_id
   FROM const_def_material_group_view
UNION ALL
 SELECT 'def_payment_type_for_sale'::text AS id,
    const_def_payment_type_for_sale_view.name,
    const_def_payment_type_for_sale_view.descr,
    const_def_payment_type_for_sale_view.val_descr,
    const_def_payment_type_for_sale_view.val_type,
    const_def_payment_type_for_sale_view.val_id
   FROM const_def_payment_type_for_sale_view
UNION ALL
 SELECT 'def_client'::text AS id,
    const_def_client_view.name,
    const_def_client_view.descr,
    const_def_client_view.val_descr,
    const_def_client_view.val_type,
    const_def_client_view.val_id
   FROM const_def_client_view
UNION ALL
 SELECT 'def_discount'::text AS id,
    const_def_discount_view.name,
    const_def_discount_view.descr,
    const_def_discount_view.val_descr,
    const_def_discount_view.val_type,
    const_def_discount_view.val_id
   FROM const_def_discount_view
UNION ALL
 SELECT 'session_live_time'::text AS id,
    const_session_live_time_view.name,
    const_session_live_time_view.descr,
    const_session_live_time_view.val_descr,
    const_session_live_time_view.val_type,
    0 AS val_id
   FROM const_session_live_time_view;

ALTER TABLE constants_list_view
  OWNER TO bellagio;


ALTER TYPE client_order_states ADD VALUE 'checked';



--***********************************************************************
-- Function: rg_total_recalc_materials()

-- DROP FUNCTION rg_total_recalc_materials();

CREATE OR REPLACE FUNCTION rg_total_recalc_materials()
  RETURNS void AS
$BODY$  
DECLARE
	period_row RECORD;
	v_act_date_time timestamp without time zone;
	v_cur_period timestamp without time zone;
	
	CALC_DATE_TIME timestamp;
	ACT_DATE_TIME timestamp;
	v_loop_rg_period timestamp;
	v_loop_rg_period_prev timestamp;
	v_calc_interval interval;			  				
BEGIN
	ACT_DATE_TIME = reg_current_balance_time();
	
	--Текущий расчетный период
	CALC_DATE_TIME = rg_calc_period('material'::reg_types);
	
	--Самый старый период
	v_loop_rg_period = rg_period('material'::reg_types,
		(SELECT date_time FROM ra_materials ORDER BY date_time LIMIT 1));	
	-- интервал регистра
	v_calc_interval = rg_calc_interval('material'::reg_types);
	v_loop_rg_period_prev = v_loop_rg_period-v_calc_interval;
	
	--очистим остатки
	DELETE FROM rg_materials;	
	LOOP				
		--Расчет новых остатков
		
		INSERT INTO rg_materials
		(date_time,
		store_id,
		material_id,
		quant,
		cost
		)
		(
		SELECT 
			v_loop_rg_period,
			sb.store_id,
			sb.material_id,
			sum(sb.quant) AS quant,
			sum(sb.cost) AS cost
		FROM(
			(
			SELECT
				rg.store_id,
				rg.material_id,
				rg.quant AS quant,
				rg.cost As cost
			FROM rg_materials AS rg
			WHERE rg.date_time=v_loop_rg_period_prev
			)
			UNION
			(SELECT
				ra.store_id,
				ra.material_id,
				sum(
				CASE ra.deb
					WHEN TRUE THEN ra.quant
					ELSE ra.quant*(-1)
				END
				) AS quant,
				sum(
				CASE ra.deb
					WHEN TRUE THEN ra.cost
					ELSE ra.cost*(-1)
				END
				) AS cost
			FROM ra_materials AS ra
			WHERE ra.date_time<v_loop_rg_period+v_calc_interval
				AND ra.date_time>=v_loop_rg_period
			GROUP BY
				ra.store_id,
				ra.material_id
			)
		) AS sb		
		GROUP BY
			v_loop_rg_period,
			sb.store_id,
			sb.material_id
		HAVING sum(sb.quant)<>0 OR sum(sb.cost)<>0
		);
		
		v_loop_rg_period_prev = v_loop_rg_period;
		v_loop_rg_period = v_loop_rg_period + v_calc_interval;
		IF v_loop_rg_period > ACT_DATE_TIME THEN
			EXIT;  -- exit loop
		ELSIF v_loop_rg_period > CALC_DATE_TIME THEN
			--АКТУАЛЬНЫЕ ИТОГИ
			v_loop_rg_period = ACT_DATE_TIME;
		END IF;
		
		--RAISE 'Завершили период %',v_loop_rg_period;
	END LOOP;
END;	
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION rg_total_recalc_materials()
  OWNER TO bellagio;




-- Function: rg_material_set_custom_period(timestamp without time zone)

-- DROP FUNCTION reg_material_set_custom_period(timestamp without time zone);

CREATE OR REPLACE FUNCTION rg_materials_set_period(in_new_period timestamp without time zone)
  RETURNS void AS
$BODY$
DECLARE
	NEW_PERIOD timestamp without time zone;
	v_prev_current_period timestamp without time zone;
	v_current_period timestamp without time zone;
	CURRENT_PERIOD timestamp without time zone;
	TA_PERIOD timestamp without time zone;
	REG_INTERVAL interval;
BEGIN
	NEW_PERIOD = rg_calc_period_start('material'::reg_types, in_new_period);
	
	SELECT date_time INTO CURRENT_PERIOD FROM rg_calc_periods WHERE reg_type = 'material'::reg_types;
	
	TA_PERIOD = reg_current_balance_time();
	
	--iterate through all periods between CURRENT_PERIOD and NEW_PERIOD
	REG_INTERVAL = rg_calc_interval('material'::reg_types);
	
	v_prev_current_period = CURRENT_PERIOD;		
	
	LOOP
		v_current_period = v_prev_current_period + REG_INTERVAL;
		IF v_current_period > NEW_PERIOD THEN
			EXIT;  -- exit loop
		END IF;
		
		--clear period
		DELETE FROM rg_materials
		WHERE date_time = v_current_period;
		
		--new data
		INSERT INTO rg_materials
		(date_time
		
		,store_id
		,material_id
		,quant
		,cost						
		)
		(SELECT
				v_current_period
				
				,rg.store_id
				,rg.material_id
				,rg.quant
				,rg.cost				
			FROM rg_materials As rg
			WHERE (
			
			rg.quant<>0
			OR
			rg.cost<>0
										
			)
			AND (rg.date_time=v_prev_current_period)
		);

		v_prev_current_period = v_current_period;
	END LOOP;

	--new TA data
	DELETE FROM rg_materials
	WHERE date_time=TA_PERIOD;
	INSERT INTO rg_materials
	(date_time,store_id,material_id,quant,cost)
	(SELECT
			TA_PERIOD
		
		,store_id
		,material_id
		,quant
		,cost
		FROM rg_materials AS rg
		WHERE (
		
		rg.quant<>0
		OR
		rg.cost<>0
											
		)
		AND (rg.date_time=NEW_PERIOD)
	);

	DELETE FROM rg_materials WHERE (date_time>NEW_PERIOD)
	AND (date_time<>TA_PERIOD);

	--set new period
	UPDATE rg_calc_periods SET date_time = NEW_PERIOD
	WHERE reg_type='material'::reg_types;		
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION rg_materials_set_period(timestamp without time zone)
  OWNER TO bellagio;


ALTER TABLE cash_registers ADD COLUMN eq_server varchar(20);
ALTER TABLE cash_registers ADD COLUMN eq_port integer;
ALTER TABLE cash_registers ADD COLUMN eq_id varchar(20);



CREATE OR REPLACE FUNCTION rg_calc_interval(in_reg_type reg_types)
  RETURNS interval AS
$BODY$
			SELECT
				CASE $1
								
				WHEN 'material'::reg_types THEN '1 month'::interval
								
				WHEN 'product'::reg_types THEN '1 month'::interval
								
				WHEN 'client_order'::reg_types THEN '1 month'::interval
				
				END;
		$BODY$
  LANGUAGE sql IMMUTABLE
  COST 100;
ALTER FUNCTION rg_calc_interval(reg_types)
  OWNER TO bellagio;

		CREATE OR REPLACE FUNCTION rg_current_balance_time()
		  RETURNS timestamp without time zone AS
		$BODY$
			SELECT '3000-01-01 00:00:00'::timestamp without time zone;
		$BODY$
		  LANGUAGE sql IMMUTABLE COST 100;
		ALTER FUNCTION rg_current_balance_time() OWNER TO bellagio;

-- Function: rg_calc_period_start(reg_types, timestamp without time zone)

-- DROP FUNCTION rg_calc_period_start(reg_types, timestamp without time zone);

-- Function: rg_period(reg_types, timestamp without time zone)

-- DROP FUNCTION rg_period(reg_types, timestamp without time zone);

CREATE OR REPLACE FUNCTION rg_period(in_reg_type reg_types, in_date_time timestamp without time zone)
  RETURNS timestamp without time zone AS
$BODY$
	SELECT date_trunc('MONTH', in_date_time)::timestamp without time zone;
$BODY$
  LANGUAGE sql IMMUTABLE
  COST 100;
ALTER FUNCTION rg_period(reg_types, timestamp without time zone)
  OWNER TO bellagio;

-- Function: rg_period(reg_types, timestamp without time zone)

-- DROP FUNCTION rg_period(reg_types, timestamp without time zone);

CREATE OR REPLACE FUNCTION rg_calc_period(in_reg_type reg_types)
  RETURNS timestamp without time zone AS
$BODY$
	SELECT date_time FROM rg_calc_periods WHERE reg_type=$1;
$BODY$
  LANGUAGE sql STABLE
  COST 100;
ALTER FUNCTION rg_calc_period(reg_types)
  OWNER TO bellagio;


-- Function: rg_calc_period_end(reg_types, timestamp without time zone)

-- DROP FUNCTION rg_calc_period_end(reg_types, timestamp without time zone);

CREATE OR REPLACE FUNCTION rg_period_balance(in_reg_type reg_types, in_date_time timestamp without time zone)
  RETURNS timestamp without time zone AS
$BODY$
	SELECT
		date_trunc('month',in_date_time) + rg_calc_interval(in_reg_type) - '0.000001 second'::interval
$BODY$
  LANGUAGE sql IMMUTABLE
  COST 100;
ALTER FUNCTION rg_calc_period_end(reg_types, timestamp without time zone)
  OWNER TO bellagio;
  



-- Function: rg_materi
  
ALTER TABLE rg_products ADD COLUMN cost numeric(15,2);  



-- Table: sessions

 DROP TABLE sessions;

CREATE TABLE sessions
(
  id character(128) NOT NULL,
  data text NOT NULL,
  pub_key character varying(15),
  set_time timestamp without time zone NOT NULL
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sessions
  OWNER TO bellagio;

-- Index: sessions_pub_key_index

-- DROP INDEX sessions_pub_key_index;

CREATE INDEX sessions_pub_key_index
  ON sessions
  USING btree
  (pub_key COLLATE pg_catalog."default");

-- Index: sessions_set_time_idx

-- DROP INDEX sessions_set_time_idx;

CREATE INDEX sessions_set_time_idx
  ON sessions
  USING btree
  (set_time);

-- ******************* update 05/07/2017 06:56:17 ******************
CREATE TABLE variant_storages
		(user_id int REFERENCES users(id),storage_name text,variant_name text,data json,CONSTRAINT variant_storages_pkey PRIMARY KEY (user_id,storage_name,variant_name));
		
		ALTER TABLE variant_storages OWNER TO bellagio;
		
-- VIEW: variant_storages_list

--DROP VIEW variant_storages_list;

CREATE OR REPLACE VIEW variant_storages_list AS
	SELECT
		user_id,
		storage_name,
		variant_name,
		default_variant bool
	FROM variant_storages
	;
	
ALTER VIEW variant_storages_list OWNER TO ;		


﻿-- Function: variant_storages_upsert(in_user_id int, in_storage_name text, in_variant_name text, in_data text, in_default_variant boolean)

--DROP FUNCTION variant_storages_upsert(in_user_id int, in_storage_name text, in_variant_name text, in_data text, in_default_variant boolean);
CREATE OR REPLACE FUNCTION variant_storages_upsert(in_user_id int, in_storage_name text, in_variant_name text, in_data text, in_default_variant boolean)
  RETURNS void AS
$BODY$  
BEGIN
	IF in_default_variant THEN
		UPDATE variant_storages
		SET
			default_variant = FALSE
		WHERE
			user_id = in_user_id
			AND storage_name = in_storage_name
		;	
	END IF;
	
	UPDATE variant_storages
	SET
		--set_time = now(),
		data = in_data,
		default_variant = in_default_variant
	WHERE
		user_id = in_user_id
		AND storage_name = in_storage_name
		AND variant_name = in_variant_name
	;
	
	IF FOUND THEN
		RETURN;
	END IF;
	
	BEGIN
		INSERT INTO variant_storages (user_id, storage_name, variant_name, data, default_variant)
		VALUES(in_user_id, in_storage_name, in_variant_name, in_data, in_default_variant);
		
	EXCEPTION WHEN OTHERS THEN
		UPDATE variant_storages
		SET
			--set_time = now(),
			data = in_data,
			default_variant = in_default_variant
		WHERE
			user_id = in_user_id
			AND storage_name = in_storage_name
			AND variant_name = in_variant_name
		;
	END;
	
	RETURN;

END;	
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION variant_storages_upsert(in_user_id int, in_storage_name text, in_variant_name text, in_data text, in_default_variant boolean) OWNER TO ;
