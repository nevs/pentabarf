
-- create new account to be activated
-- the parameter are login_name, email_contact, password, activation_string
CREATE OR REPLACE FUNCTION create_account( p_login_name VARCHAR(32), p_email_contact VARCHAR(64), p_password TEXT, p_activation_string CHAR(64), p_conference_id INTEGER) RETURNS INTEGER AS $$
  DECLARE
    new_person_id INTEGER;
    binary_salt BYTEA;
    p_person RECORD;
  BEGIN

    SELECT INTO p_person person_id FROM person WHERE login_name = p_login_name;
    IF FOUND THEN
      RAISE EXCEPTION 'login name already in use.';
    END IF;

    SELECT INTO new_person_id nextval(pg_get_serial_sequence('person', 'person_id'));
    SELECT INTO binary_salt gen_random_bytes(8);
    INSERT INTO person(person_id, login_name, email_contact, password) VALUES (new_person_id, p_login_name, p_email_contact, encode(binary_salt, 'hex'::text) || md5(binary_salt||textsend(p_password)));

    INSERT INTO account_activation(person_id, activation_string, conference_id) VALUES (new_person_id, p_activation_string, CASE WHEN p_conference_id = 0 THEN NULL ELSE p_conference_id END);
    RETURN new_person_id;
  END;
$$ LANGUAGE plpgsql CALLED ON NULL INPUT;

