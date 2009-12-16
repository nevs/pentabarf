
CREATE OR REPLACE FUNCTION auth.activate_account( activation_string char(64)) RETURNS INTEGER AS $$
  DECLARE
    cur_activation RECORD;
    cur_person_id INTEGER;
    activation_interval INTERVAL;
  BEGIN
    activation_interval = '-7 day';
    DELETE FROM auth.account WHERE account_id IN ( SELECT account_id FROM auth.account_activation WHERE account_creation < now() + activation_interval );
    SELECT INTO cur_activation account_id, conference_id FROM auth.account_activation WHERE account_activation.activation_string = activation_string;
    IF FOUND THEN
      INSERT INTO auth.account_role(account_id, role) VALUES (cur_activation.account_id, 'submitter');
      SELECT INTO cur_person_id nextval(pg_get_serial_sequence('base.person','person_id'));
      INSERT INTO person(person_id,nickname,email) SELECT cur_person_id,login_name,email FROM auth.account WHERE account.account_id = cur_activation.account_id;
      UPDATE auth.account SET person_id = cur_person_id WHERE account_id = cur_activation.account_id;
      INSERT INTO auth.account_settings(account_id,current_conference_id) VALUES (cur_activation.account_id, cur_activation.conference_id);
    ELSE
      PERFORM 1 FROM log.account_activation WHERE account_activation.activation_string = activation_string AND account_activation.log_operation = 'D';
      IF FOUND THEN
        RAISE EXCEPTION 'Your account has already been activated.';
      ELSE
        RAISE EXCEPTION 'Invalid activation string.';
      END IF;
    END IF;
    RETURN cur_activation.conference_id;
  END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

