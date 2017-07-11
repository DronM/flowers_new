


-- ******************* update 05/07/2017 06:56:17 ******************
CREATE TABLE variant_storages
		(user_id int REFERENCES users(id),storage_name text,variant_name text,data json,CONSTRAINT variant_storages_pkey PRIMARY KEY (user_id,storage_name,variant_name));
		
		ALTER TABLE variant_storages OWNER TO bellagio;


-- ******************* update 08/07/2017 09:58:04 ******************
ALTER TABLE variant_storages ADD COLUMN default_variant bool,;