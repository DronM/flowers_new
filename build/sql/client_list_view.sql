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
  
