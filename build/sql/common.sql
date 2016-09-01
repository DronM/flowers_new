CREATE OR REPLACE FUNCTION date10_descr(date)
  RETURNS character varying AS
$BODY$
	SELECT to_char($1,'DD/MM/YYYY');
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION date10_descr(date) OWNER TO bellagio;

CREATE OR REPLACE FUNCTION date10_time6_descr(timestamp without time zone)
  RETURNS character varying AS
$BODY$
	SELECT to_char($1,'DD/MM/YYYY HH24:MI');
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION date10_time6_descr(timestamp without time zone)
  OWNER TO bellagio;

CREATE OR REPLACE FUNCTION date10_time8_descr(timestamp without time zone)
  RETURNS character varying AS
$BODY$
	SELECT to_char($1,'DD/MM/YYYY HH24:MI:SS');
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION date10_time8_descr(timestamp without time zone)
  OWNER TO bellagio;

CREATE OR REPLACE FUNCTION date5_time5_descr(timestamp without time zone)
  RETURNS character varying AS
$BODY$
	SELECT to_char($1,'DD/MM HH24:MI');
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION date5_time5_descr(timestamp without time zone)
  OWNER TO bellagio;

CREATE OR REPLACE FUNCTION date8_descr(date)
  RETURNS character varying AS
$BODY$
	SELECT to_char($1,'DD/MM/YY');
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION date8_descr(date)
  OWNER TO bellagio;

CREATE OR REPLACE FUNCTION date8_time5_descr(timestamp without time zone)
  RETURNS character varying AS
$BODY$
	SELECT to_char($1,'DD/MM/YY HH24:MI');
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION date8_time5_descr(timestamp without time zone)
  OWNER TO bellagio;
CREATE OR REPLACE FUNCTION date8_time8_descr(timestamp without time zone)
  RETURNS character varying AS
$BODY$
	SELECT to_char($1,'DD/MM/YY HH24:MI:SS');
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION date8_time8_descr(timestamp without time zone)
  OWNER TO bellagio;

CREATE OR REPLACE FUNCTION time5_descr(time without time zone)
  RETURNS character varying AS
$BODY$
	SELECT to_char($1,'HH24:MI');
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION time5_descr(time without time zone)
  OWNER TO bellagio;

CREATE OR REPLACE FUNCTION time5_descr(interval)
  RETURNS text AS
$BODY$
	SELECT to_char($1,'HH24:MI');
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION time5_descr(interval) OWNER TO bellagio;

CREATE OR REPLACE FUNCTION get_date_str_rus(date)
  RETURNS character varying AS
$BODY$
DECLARE
	v_months varchar[12];
BEGIN
	v_months[0] = '������';
	v_months[1] = '�������';
	v_months[2] = '�����';
	v_months[3] = '������';
	v_months[4] = '���';
	v_months[5] = '����';
	v_months[6] = '����';
	v_months[7] = '�������';
	v_months[8] = '��������';
	v_months[9] = '�������';
	v_months[10] = '������';
	v_months[11] = '�������';
	RETURN EXTRACT(DAY FROM $1) || ' ' || v_months[date_part('month',$1)-1] || ' ' || date_part('year',$1);
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION get_date_str_rus(date)
  OWNER TO bellagio;

CREATE OR REPLACE FUNCTION dow_descr(date)
  RETURNS character varying AS
$BODY$
	SELECT
		CASE EXTRACT(DOW FROM $1)
			WHEN 0 THEN '�����������'
			WHEN 1 THEN '�����������'
			WHEN 2 THEN '�������'
			WHEN 3 THEN '�����'
			WHEN 4 THEN '�������'
			WHEN 5 THEN '�������'
			ELSE '�������'
		END;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION dow_descr(date)
  OWNER TO bellagio;

CREATE OR REPLACE FUNCTION dow_descr_short(date)
  RETURNS character varying AS
$BODY$
	SELECT
		CASE EXTRACT(DOW FROM $1)
			WHEN 0 THEN '��'
			WHEN 1 THEN '��'
			WHEN 2 THEN '��'
			WHEN 3 THEN '��'
			WHEN 4 THEN '��'
			WHEN 5 THEN '��'
			ELSE '��'
		END;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION dow_descr_short(date)
  OWNER TO bellagio;

CREATE OR REPLACE FUNCTION get_month_rus(date)
  RETURNS character varying AS
$BODY$
DECLARE
	v_months varchar[12];
BEGIN
	v_months[0] = '������';
	v_months[1] = '�������';
	v_months[2] = '�����';
	v_months[3] = '������';
	v_months[4] = '���';
	v_months[5] = '����';
	v_months[6] = '����';
	v_months[7] = '�������';
	v_months[8] = '��������';
	v_months[9] = '�������';
	v_months[10] = '������';
	v_months[11] = '�������';
	RETURN v_months[date_part('month',$1)-1];
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION get_month_rus(date)
  OWNER TO postgres;

CREATE OR REPLACE FUNCTION date5_descr(date)
  RETURNS text AS
$BODY$
	SELECT to_char($1,'DD/MM/YY');
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION date5_descr(date) OWNER TO bellagio;


-- Function: date8_descr(date)

-- DROP FUNCTION date8_descr(date);

CREATE OR REPLACE FUNCTION format_money(numeric)
  RETURNS text AS
$BODY$
	SELECT to_char($1,'FM999 999.00');
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION format_money(numeric)
  OWNER TO bellagio;


CREATE OR REPLACE FUNCTION format_rub(numeric)
  RETURNS text AS
$BODY$
	SELECT format_money($1)||' �.';
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION format_rub(numeric) OWNER TO bellagio;



CREATE OR REPLACE FUNCTION interval_descr(IN in_interval interval)
  RETURNS text AS
$BODY$
	SELECT
		CASE 
		WHEN EXTRACT(DAY FROM $1)=0 THEN
			to_char($1,'HH24:MI')
		ELSE
			EXTRACT(DAY FROM $1) || ' ���.' || to_char($1,'HH24:MI')
		END;
		
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION interval_descr(interval)
  OWNER TO bellagio;



CREATE TABLE sessions
(
  id character(128) NOT NULL,
  set_time character(10) NOT NULL,
  data text NOT NULL,
  session_key character(128) NOT NULL,
  CONSTRAINT sessions_pkey PRIMARY KEY (id)
)
WITH (OIDS=FALSE);
ALTER TABLE sessions OWNER TO bellagio;
