
-- create new account to be activated
-- the parameter are login_name, email_contact, password, activation_string
CREATE OR REPLACE FUNCTION create_account(varchar(32),varchar(64),char(48), char(64)) RETURNS INTEGER AS $$
  DECLARE
    cur_login_name ALIAS FOR $1;
    cur_email_contact ALIAS FOR $2;
    cur_password ALIAS FOR $3;
    cur_activation_string ALIAS FOR $4;
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

    INSERT INTO account_activation(person_id, activation_string) VALUES (new_person_id, cur_activation_string);
    RETURN new_person_id;
  END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

CREATE OR REPLACE FUNCTION activate_account(char(64)) RETURNS INTEGER AS $$
  DECLARE
    cur_activation_string ALIAS FOR $1;
    cur_person_id INTEGER;
    cur_person RECORD;
  BEGIN
    -- cleanup obsolete activation stuff
    FOR cur_person IN
      SELECT person_id FROM person WHERE person_id IN (SELECT person_id FROM account_activation WHERE account_creation < (now() + '-1 day')::timestamptz)
    LOOP
      DELETE FROM account_activation WHERE person_id = cur_person.person_id;
      DELETE FROM person WHERE person_id = cur_person.person_id AND NOT EXISTS ( SELECT 1 FROM person_transaction WHERE person_id = cur_person.person_id);
    END LOOP;

    SELECT INTO cur_person_id person_id FROM account_activation WHERE activation_string = cur_activation_string;
    IF FOUND THEN
      INSERT INTO person_role(person_id, role_id) VALUES (cur_person_id, (SELECT role_id FROM role WHERE tag = 'submitter'));
      INSERT INTO person_transaction( person_id, changed_when, changed_by, f_create ) VALUES (cur_person_id, now(), cur_person_id, 't');
      DELETE FROM account_activation WHERE activation_string = cur_activation_string;
    ELSE
      RAISE EXCEPTION 'invalid activation string';
    END IF;
    RETURN cur_person_id;
  END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

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

CREATE OR REPLACE FUNCTION account_reset_password( text, char(64), char(48) ) RETURNS INTEGER AS $$
  DECLARE
    cur_login_name ALIAS FOR $1;
    cur_activation_string ALIAS FOR $2;
    cur_password ALIAS FOR $3;
    cur_person_id INTEGER;
  BEGIN
    DELETE FROM activation_string_reset_password WHERE password_reset < now() + '-1 day';
    SELECT INTO cur_person_id person_id FROM activation_string_reset_password WHERE activation_string = cur_activation_string;
    IF NOT FOUND THEN
      RAISE EXCEPTION 'invalid activation string.';
    END IF;
    UPDATE person SET password = cur_password WHERE person_id = cur_person_id AND login_name = cur_login_name;

    RETURN cur_person_id;
  END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;


