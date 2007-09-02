
CREATE OR REPLACE FUNCTION activate_account(char(64)) RETURNS INTEGER AS $$
  DECLARE
    cur_activation_string ALIAS FOR $1;
    cur_person_id INTEGER;
    cur_person RECORD;
    cur_activation RECORD;
  BEGIN
    -- cleanup obsolete activation stuff
    FOR cur_person IN
      SELECT person_id FROM person WHERE person_id IN (SELECT person_id FROM account_activation WHERE account_creation < (now() + '-1 day')::timestamptz)
    LOOP
      DELETE FROM account_activation WHERE person_id = cur_person.person_id;
      DELETE FROM person WHERE person_id = cur_person.person_id AND NOT EXISTS ( SELECT 1 FROM person_transaction WHERE person_id = cur_person.person_id);
    END LOOP;

    SELECT INTO cur_activation person_id, conference_id FROM account_activation WHERE activation_string = cur_activation_string;
    IF FOUND THEN
      INSERT INTO person_role(person_id, role_id) VALUES (cur_activation.person_id, (SELECT role_id FROM role WHERE tag = 'submitter'));
      INSERT INTO person_transaction( person_id, changed_when, changed_by, f_create ) VALUES (cur_activation.person_id, now(), cur_activation.person_id, 't');
      DELETE FROM account_activation WHERE activation_string = cur_activation_string;
    ELSE
      RAISE EXCEPTION 'invalid activation string.';
    END IF;
    RETURN cur_activation.conference_id;
  END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

