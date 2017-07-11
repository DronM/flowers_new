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
  
