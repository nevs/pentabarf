
CREATE OR REPLACE FUNCTION auth.reset_password( reset_string CHAR(64), new_password TEXT ) RETURNS INTEGER AS $$
  DECLARE
    cur_account_id INTEGER;
    binary_salt BYTEA;
  BEGIN
    SELECT INTO cur_account_id account_id FROM auth.password_reset_string WHERE activation_string = reset_string;
    IF NOT FOUND THEN
      RAISE EXCEPTION 'invalid reset string.';
    END IF;
    SELECT INTO binary_salt gen_random_bytes(8);
    UPDATE auth.account SET password = md5( binary_salt || textsend(new_password)), salt = encode(binary_salt,'hex'::text) WHERE account_id = cur_account_id;

    DELETE FROM auth.password_reset_string WHERE password_reset < now() + '-1 day' OR activation_string = reset_string;
    RETURN cur_account_id;
  END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

