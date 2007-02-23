
-- create new account to be activated
-- the parameter are login_name, email_contact, password, activation_string
CREATE OR REPLACE FUNCTION create_account(varchar(32),varchar(64),char(48), char(64), integer) RETURNS INTEGER AS $$
  DECLARE
    cur_login_name ALIAS FOR $1;
    cur_email_contact ALIAS FOR $2;
    cur_password ALIAS FOR $3;
    cur_activation_string ALIAS FOR $4;
    cur_conference_id ALIAS FOR $5;
    new_person_id INTEGER;
    cur_person RECORD;
  BEGIN
    -- cleanup obsolete activation stuff
    FOR cur_person IN
      SELECT person_id FROM person WHERE person_id IN (SELECT person_id FROM account_activation WHERE account_creation < (now() + '-1 day')::timestamptz)
    LOOP
      DELETE FROM account_activation WHERE person_id = cur_person.person_id;
      DELETE FROM person WHERE person_id = cur_person.person_id AND NOT EXISTS ( SELECT 1 FROM person_transaction WHERE person_id = cur_person.person_id);
    END LOOP;

    SELECT INTO cur_person person_id FROM person WHERE login_name = cur_login_name;
    IF FOUND THEN
      RAISE EXCEPTION 'login name already in use.';
    END IF;

    SELECT INTO cur_person person_id, login_name FROM person WHERE email_contact = cur_email_contact;
    IF FOUND AND cur_person.login_name IS NOT NULL THEN
      RAISE EXCEPTION 'email address already in use.';
    ELSIF FOUND AND cur_person.login_name IS NULL THEN
      new_person_id = cur_person.person_id;
      UPDATE person SET login_name = cur_login_name, password = cur_password WHERE person_id = new_person_id;
    ELSE
      SELECT INTO new_person_id nextval(pg_get_serial_sequence('person', 'person_id'));
      INSERT INTO person(person_id, login_name, email_contact, password) VALUES (new_person_id, cur_login_name, cur_email_contact, cur_password);
    END IF;

    INSERT INTO account_activation(person_id, activation_string, conference_id) VALUES (new_person_id, cur_activation_string, CASE WHEN cur_conference_id = 0 THEN NULL ELSE cur_conference_id END);
    RETURN new_person_id;
  END;
$$ LANGUAGE plpgsql CALLED ON NULL INPUT;

