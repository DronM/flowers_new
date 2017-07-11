-- Function: template_params_set_value(in_template_param_id integer, in_user_id int,in_val text)

-- DROP FUNCTION template_params_set_value(in_template_param_id integer, in_user_id int,in_val text);

CREATE OR REPLACE FUNCTION template_params_set_value(in_template_param_id integer, in_user_id int,in_val text)
  RETURNS void AS
$$
BEGIN
    UPDATE template_param_vals set val = in_val WHERE template_param_id=in_template_param_id AND user_id=in_user_id;
    IF FOUND THEN
        RETURN;
    END IF;
    BEGIN
        INSERT INTO template_param_vals (template_param_id, user_id,val) VALUES (in_template_param_id, in_user_id, in_val);
    EXCEPTION WHEN OTHERS THEN
        UPDATE template_params set val = in_val WHERE template_param_id=in_template_param_id AND user_id=in_user_id;
    END;
    RETURN;
END;
$$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION template_params_set_value(in_template_param_id integer, in_user_id int,in_val text) OWNER TO bellagio;
