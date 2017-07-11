-- Function: clients_ref(clients)

-- DROP FUNCTION clients_ref(clients);

CREATE OR REPLACE FUNCTION clients_ref(clients)
  RETURNS RefType AS
$$
	SELECT
		(
			ARRAY[('id',$1.id)::RefTypeKey],
			$1.name::text
		)::RefType
	;
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION clients_ref(clients) OWNER TO bellagio;
