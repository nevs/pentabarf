
-- create new account to be activated
-- the parameter are login_name, email_contact, password, activation_string
CREATE OR REPLACE FUNCTION create_account( p_login_name VARCHAR(32), p_email_contact VARCHAR(64), p_password CHAR(48), p_activation_string CHAR(64), p_conference_id INTEGER) RETURNS INTEGER AS $$
  DECLARE
    new_person_id INTEGER;
    p_person RECORD;
  BEGIN
    -- cleanup obsolete activation stuff
    FOR p_person IN
      SELECT person_id FROM person WHERE person_id IN (SELECT person_id FROM account_activation WHERE account_creation < (now() + '-1 day')::timestamptz)
    LOOP
      DELETE FROM account_activation WHERE person_id = p_person.person_id;
      DELETE FROM person WHERE person_id = p_person.person_id AND NOT EXISTS ( SELECT 1 FROM person_transaction WHERE person_id = p_person.person_id);
    END LOOP;

    SELECT INTO p_person person_id FROM person WHERE login_name = p_login_name;
    IF FOUND THEN
      RAISE EXCEPTION 'login name already in use.';
    END IF;

    SELECT INTO p_person person_id, login_name FROM person WHERE email_contact = p_email_contact;
    IF FOUND AND p_person.login_name IS NOT NULL THEN
      RAISE EXCEPTION 'email address already in use.';
    ELSIF FOUND AND p_person.login_name IS NULL THEN
      new_person_id = p_person.person_id;
      UPDATE person SET login_name = p_login_name, password = p_password WHERE person_id = new_person_id;
    ELSE
      SELECT INTO new_person_id nextval(pg_get_serial_sequence('person', 'person_id'));
      INSERT INTO person(person_id, login_name, email_contact, password) VALUES (new_person_id, p_login_name, p_email_contact, p_password);
    END IF;

    INSERT INTO account_activation(person_id, activation_string, conference_id) VALUES (new_person_id, p_activation_string, CASE WHEN p_conference_id = 0 THEN NULL ELSE p_conference_id END);
    RETURN new_person_id;
  END;
$$ LANGUAGE plpgsql CALLED ON NULL INPUT;

