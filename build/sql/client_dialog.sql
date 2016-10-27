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
	ORDER BY cl.name;
	;
ALTER TABLE client_dialog
  OWNER TO bellagio;
  
