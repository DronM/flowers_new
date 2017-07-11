-- Trigger: logins_trigger on logins

-- DROP TRIGGER logins_trigger ON logins;

CREATE TRIGGER logins_trigger
  AFTER UPDATE OR DELETE
  ON logins
  FOR EACH ROW
  EXECUTE PROCEDURE logins_process();
