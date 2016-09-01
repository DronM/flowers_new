-- View: client_list_view

--DROP VIEW client_list_view;

CREATE OR REPLACE VIEW client_list_view AS 
	SELECT
		cl.id,
		cl.name,
		cl.phone_cel,
		cl.email
	FROM clients AS cl
	;

ALTER TABLE client_list_view OWNER TO bellagio;
  