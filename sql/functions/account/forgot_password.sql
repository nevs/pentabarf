
CREATE OR REPLACE FUNCTION account_forgot_password(integer, char(64)) RETURNS INTEGER AS $$
  DECLARE
    cur_person_id ALIAS FOR $1;
    cur_activation_string ALIAS FOR $2;
    cur_person RECORD;
  BEGIN
    DELETE FROM activation_string_reset_password WHERE password_reset < now() + '-1 day';

    SELECT INTO cur_person person_id FROM activation_string_reset_password WHERE person_id = cur_person_id;
    IF FOUND THEN
      RAISE EXCEPTION 'This account has already been reset in the last 24 hours.';
    END IF;
    INSERT INTO activation_string_reset_password(person_id, activation_string, password_reset) VALUES (cur_person_id, cur_activation_string, now());

    RETURN cur_person_id;
  END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

