-- Function: teplate_params_get_list(template text, user_id int)

--DROP FUNCTION teplate_params_get_list(template text, param text, user_id int);

--DROP FUNCTION teplate_params_get_list(in_template text, in_user_id int);

CREATE OR REPLACE FUNCTION teplate_params_get_list(in_template text, in_user_id int)
  RETURNS TABLE(
  	param text,
  	param_type text,
	val text
  ) AS
$$
	SELECT DISTINCT ON (sub.param)
		sub.param::text,
		sub.param_type,
		template_params_get_val(sub.val,sub.param_type)::text
	FROM (

		SELECT
			tp.param,
			tp.param_type,
			tpv.val,
			0 AS w
		FROM template_params AS tp
		LEFT JOIN template_param_vals AS tpv ON tp.id=tpv.template_param_id
		WHERE tp.template = in_template AND tpv.user_id = in_user_id

		UNION ALL

		SELECT
			tp.param,
			tp.param_type,
			tpv.val,
			1 AS w
		FROM template_params AS tp
		LEFT JOIN template_param_vals AS tpv ON tp.id=tpv.template_param_id
		WHERE tp.template IS NULL AND tpv.user_id=in_user_id

		UNION ALL

		SELECT
			tp.param,
			tp.param_type,
			tpv.val,
			2 AS w
		FROM template_params AS tp
		LEFT JOIN template_param_vals AS tpv ON tp.id=tpv.template_param_id
		WHERE tp.template IS NULL AND tpv.user_id IS NULL
	) sub
	ORDER BY
		sub.param,
		sub.w ASC;
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION teplate_params_get_list(in_template text, in_user_id int) OWNER TO bellagio;

