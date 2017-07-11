-- Function: logins_process()

-- DROP FUNCTION logins_process();

CREATE OR REPLACE FUNCTION logins_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_WHEN='AFTER' AND TG_OP='UPDATE') THEN
		IF NEW.date_time_out IS NOT NULL THEN
			DELETE FROM doc_client_orders_t_tmp_materials WHERE login_id=NEW.id;
			DELETE FROM doc_client_orders_t_tmp_products WHERE login_id=NEW.id;
			DELETE FROM doc_expences_t_tmp_expence_types WHERE login_id=NEW.id;
			DELETE FROM doc_material_disposals_t_tmp_materials WHERE login_id=NEW.id;
			--DELETE FROM doc_material_orders_t_tmp_materials WHERE login_id=NEW.id;
			DELETE FROM doc_material_procurements_t_tmp_materials WHERE login_id=NEW.id;
			DELETE FROM doc_productions_t_tmp_materials WHERE login_id=NEW.id;
			DELETE FROM doc_sales_t_tmp_materials WHERE login_id=NEW.id;
			DELETE FROM doc_sales_t_tmp_products WHERE login_id=NEW.id;
			DELETE FROM receipt_head WHERE user_id=NEW.user_id;
			DELETE FROM receipts WHERE user_id=NEW.user_id;
		END IF;
		
		RETURN NEW;
	ELSE 
		RETURN NEW;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION logins_process()
  OWNER TO bellagio;
