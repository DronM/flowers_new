-- View: user_view

-- DROP VIEW user_view;

CREATE OR REPLACE VIEW user_view AS 
	SELECT
		u.id,
		u.name,
		u.email,
		u.role_id,
		u.constrain_to_store,
		get_role_types_descr(u.role_id) AS role_descr,
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
