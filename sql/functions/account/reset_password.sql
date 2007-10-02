
CREATE OR REPLACE FUNCTION account_reset_password( text, char(64), char(48) ) RETURNS INTEGER AS $$
  DECLARE
    cur_login_name ALIAS FOR $1;
    cur_activation_string ALIAS FOR $2;
    cur_password ALIAS FOR $3;
    cur_person_id INTEGER;
  BEGIN
    DELETE FROM auth.password_reset_string WHERE password_reset < now() + '-1 day';
    SELECT INTO cur_person_id person_id FROM auth.password_reset_string WHERE activation_string = cur_activation_string;
    IF NOT FOUND THEN
      RAISE EXCEPTION 'invalid activation string.';
    END IF;
    UPDATE person SET password = cur_password WHERE person_id = cur_person_id AND login_name = cur_login_name;

    RETURN cur_person_id;
  END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

