-- Function: teplate_params_get_list(template text, param text, user_id int)

--DROP FUNCTION teplate_params_get_list(template text, param text, user_id int);

CREATE OR REPLACE FUNCTION teplate_params_get_list(template text, param text, user_id int)
  RETURNS TABLE(
  param text,
  val text
  ) AS
$$
	SELECT DISTINCT ON (sub.param)
		sub.param::text,
		sub.val::text
	FROM (
		SELECT
			t1.param,
			t1.val,
			1 AS w
		FROM template_params t1 WHERE
				t1.template::text = $1
				AND t1.user_id=user_id
				AND ($2='' OR ($2<>'' AND t1.param::text = $2) )
				
		UNION ALL
		
		SELECT
			t2.param,
			t2.val,
			0 AS w
		FROM template_params t2 WHERE
			t2.template IS NULL
			AND t2.user_id IS NULL
			AND ($2='' OR ($2<>'' AND t2.param::text = $2) )
	) sub
	ORDER BY
		sub.param,
		sub.w desc;
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION teplate_params_get_list(template text, param text, user_id int) OWNER TO bellagio;

