
CREATE OR REPLACE FUNCTION auth.forgot_password( p_person_id INTEGER, p_activation_string CHAR(64)) RETURNS INTEGER AS $$
  DECLARE
    cur_person RECORD;
  BEGIN
    DELETE FROM auth.password_reset_string WHERE password_reset < now() + '-1 day';

    SELECT INTO cur_person person_id FROM auth.password_reset_string WHERE person_id = p_person_id;
    IF FOUND THEN
      RAISE EXCEPTION 'This account has already been reset in the last 24 hours.';
    END IF;
    INSERT INTO auth.password_reset_string(person_id, activation_string, password_reset) VALUES (p_person_id, p_activation_string, now());

    RETURN p_person_id;
  END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

