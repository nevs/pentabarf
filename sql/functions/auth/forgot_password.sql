
CREATE OR REPLACE FUNCTION auth.forgot_password( p_account_id INTEGER, p_activation_string CHAR(64)) RETURNS INTEGER AS $$
  BEGIN

    PERFORM account_id FROM auth.account_password_reset WHERE account_id = p_account_id;
    IF FOUND THEN
      RAISE EXCEPTION 'This account has already been reset in the last 24 hours.';
    END IF;
    INSERT INTO auth.account_password_reset(account_id, activation_string, reset_time) VALUES (p_account_id, p_activation_string, now());

    RETURN p_account_id;
  END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

