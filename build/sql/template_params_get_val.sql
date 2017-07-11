--Changes predefined values to its actual values
--Possible predefined values:
--	cur_date_start
--	cur_date_end
--	cur_week_start
--	cur_week_end
--	cur_month_start
--	cur_month_end
--	cur_quarter_start
--	cur_quarter_end
--	cur_year_start
--	cur_year_end
--	cur_shift_start
--	cur_shift_end

-- Function: template_params_get_val(in_val text, in_val_type text)

-- DROP FUNCTION template_params_get_val(in_val text, in_val_type text);

CREATE OR REPLACE FUNCTION template_params_get_val(in_val text, in_val_type text)
  RETURNS text AS
$$
	SELECT
		CASE
			--cur_date
			WHEN in_val_type='DateTime' AND in_val = 'cur_date_start' THEN
				(now()::date + '00:00:00'::interval)::text
			WHEN in_val_type='DateTime' AND in_val = 'cur_date_end' THEN
				(now()::date + '23:59:59'::interval)::text
			WHEN in_val_type='Date' AND in_val = 'cur_date_start' THEN
				(now()::date)::text
			WHEN in_val_type='Date' AND in_val = 'cur_date_end' THEN
				(now()::date)::text
			
			--cur_week
			WHEN in_val_type='DateTime' AND in_val = 'cur_week_start' THEN
				(date_trunc('week', now()))::text
			WHEN in_val_type='DateTime' AND in_val = 'cur_week_end' THEN
				((date_trunc('week', now())+'1 week'::interval-'1 day'::interval)::date + '23:59:59'::interval)::text
			WHEN in_val_type='Date' AND in_val = 'cur_week_start' THEN
				(date_trunc('week', now()::date))::text
			WHEN in_val_type='Date' AND in_val = 'cur_week_end' THEN
				((date_trunc('week', now()::date)+'1 week'::interval-'1 day'::interval)::date)::text


			--cur_month
			WHEN in_val_type='DateTime' AND in_val = 'cur_month_start' THEN
				(date_trunc('month', now()))::text
			WHEN in_val_type='DateTime' AND in_val = 'cur_month_end' THEN
				((date_trunc('month', now())+'1 month'::interval-'1 day'::interval)::date + '23:59:59'::interval)::text
			WHEN in_val_type='Date' AND in_val = 'cur_month_start' THEN
				(date_trunc('month', now()::date))::text
			WHEN in_val_type='Date' AND in_val = 'cur_month_end' THEN
				((date_trunc('month', now()::date)+'1 month'::interval-'1 day'::interval)::date)::text
				
			
			--cur_quarter	
			WHEN in_val_type='DateTime' AND in_val = 'cur_quarter_start' THEN
				(quater_start(now()))::text
			WHEN in_val_type='DateTime' AND in_val = 'cur_quarter_end' THEN
				((quater_start(now())+'3 months'::interval-'1 day'::interval)::date + '23:59:59'::interval)::text
			WHEN in_val_type='Date' AND in_val = 'cur_quarter_start' THEN
				(quater_start(now()::date))::text
			WHEN in_val_type='Date' AND in_val = 'cur_quarter_end' THEN
				((quater_start(now()::date)+'3 months'::interval-'1 day'::interval)::date)::text
			
			
			--cur_year
			WHEN in_val_type='DateTime' AND in_val = 'cur_year_start' THEN
				(date_trunc('year', now()))::text
			WHEN in_val_type='DateTime' AND in_val = 'cur_year_end' THEN
				((date_trunc('year', now())+'1 year'::interval-'1 day'::interval)::date + '23:59:59'::interval)::text
			WHEN in_val_type='Date' AND in_val = 'cur_year_start' THEN
				(date_trunc('year', now()::date))::text
			WHEN in_val_type='date' AND in_val = 'cur_year_end' THEN
				((date_trunc('year', now()::date)+'1 year'::interval-'1 day'::interval)::date)::text

			--cur_shift
			WHEN in_val_type='DateTime' AND in_val = 'cur_shift_start' THEN
				(now()::date + const_shift_start_time_val())::text
			WHEN in_val_type='DateTime' AND in_val = 'cur_shift_end' THEN
				( (now()::date + const_shift_start_time_val()) + const_shift_length_time_val() - '1 second'::interval)::text
			WHEN in_val_type='Date' AND in_val = 'cur_shift_start' THEN
				(now()::date)::text
			WHEN in_val_type='Date' AND in_val = 'cur_shift_end' THEN
				(( (now()::date + const_shift_start_time_val()) + const_shift_length_time_val() - '1 second'::interval)::date)::text
				
				
			ELSE 
				in_val
		END
	;
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION template_params_get_val(in_val text, in_val_type text) OWNER TO bellagio;
