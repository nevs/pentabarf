
-- create new account to be activated
-- the parameter are login_name, email, password, activation_string
CREATE OR REPLACE FUNCTION auth.create_account( p_login_name VARCHAR(32), p_email VARCHAR(64), p_password TEXT, p_activation_string CHAR(64), p_conference_id INTEGER) RETURNS INTEGER AS $$
  DECLARE
    new_account_id INTEGER;
    binary_salt BYTEA;
  BEGIN

    PERFORM account_id FROM auth.account WHERE login_name = p_login_name;
    IF FOUND THEN
      RAISE EXCEPTION 'login name already in use.';
    END IF;

    SELECT INTO new_account_id nextval(pg_get_serial_sequence('auth.account', 'account_id'));
    SELECT INTO binary_salt gen_random_bytes(8);
    INSERT INTO auth.account(account_id, login_name, email, salt, password) VALUES (new_account_id, p_login_name, p_email, encode(binary_salt, 'hex'::text), md5(binary_salt||textsend(p_password)));

    INSERT INTO auth.account_activation(account_id, activation_string, conference_id) VALUES (new_account_id, p_activation_string, CASE WHEN p_conference_id = 0 THEN NULL ELSE p_conference_id END);
    RETURN new_account_id;
  END;
$$ LANGUAGE plpgsql;

