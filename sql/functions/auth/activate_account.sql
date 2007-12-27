
CREATE OR REPLACE FUNCTION auth.activate_account( activation_string char(64)) RETURNS INTEGER AS $$
  DECLARE
    cur_activation RECORD;
    cur_person_id INTEGER;
    activation_interval INTERVAL;
  BEGIN
    activation_interval = '-1 day';
    SELECT INTO cur_activation account_id, conference_id FROM auth.account_activation WHERE account_activation.activation_string = activation_string AND account_creation > now() + activation_interval;
    IF FOUND THEN
      INSERT INTO auth.account_role(account_id, role) VALUES (cur_activation.account_id, 'submitter');
      SELECT INTO cur_person_id nextval(pg_get_serial_sequence('base.person','person_id'));
      INSERT INTO person(person_id,nickname,email) SELECT cur_person_id,login_name,email FROM auth.account WHERE account.account_id = cur_activation.account_id;
      UPDATE auth.account SET person_id = cur_person_id, current_conference_id = cur_activation.conference_id WHERE account_id = cur_activation.account_id;
      INSERT INTO person_transaction( person_id, changed_when, changed_by, f_create ) VALUES (cur_person_id, now(), cur_person_id, 't');
      DELETE FROM auth.account_activation WHERE account_activation.activation_string = activation_string OR account_creation < now() + activation_interval;
    ELSE
      RAISE EXCEPTION 'invalid activation string.';
    END IF;
    RETURN cur_activation.conference_id;
  END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

