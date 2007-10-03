
CREATE OR REPLACE FUNCTION auth.reset_password( reset_string CHAR(64), new_password TEXT ) RETURNS INTEGER AS $$
  DECLARE
    cur_person_id INTEGER;
  BEGIN
    SELECT INTO cur_person_id person_id FROM auth.password_reset_string WHERE activation_string = reset_string;
    IF NOT FOUND THEN
      RAISE EXCEPTION 'invalid reset string.';
    END IF;
    UPDATE person SET password = auth.hash_password( new_password ) WHERE person_id = cur_person_id;

    DELETE FROM auth.password_reset_string WHERE password_reset < now() + '-1 day' OR activation_string = reset_string;
    RETURN cur_person_id;
  END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

