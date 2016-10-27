-- View: bellagio.user_list_view

-- DROP VIEW bellagio.user_list_view;

CREATE OR REPLACE VIEW user_list_view AS 
 SELECT u.id,
    u.name,
    bellagio.get_role_types_descr(u.role_id) AS role_descr,
    u.store_id,
    u.constrain_to_store,
    st.name AS store_descr
   FROM bellagio.users u
     LEFT JOIN bellagio.stores st ON st.id = u.store_id
  ORDER BY st.name,u.name;

ALTER TABLE bellagio.user_list_view
  OWNER TO bellagio;

