
CREATE OR REPLACE FUNCTION auth.activate_account( activation_string char(64)) RETURNS INTEGER AS $$
  DECLARE
    cur_person_id INTEGER;
    cur_person RECORD;
    cur_activation RECORD;
  BEGIN

    SELECT INTO cur_activation person_id, conference_id FROM auth.account_activation WHERE account_activation.activation_string = activation_string AND account_creation > now() + '-1 day';
    IF FOUND THEN
      INSERT INTO auth.person_role(person_id, role) VALUES (cur_activation.person_id, 'submitter');
      INSERT INTO person_transaction( person_id, changed_when, changed_by, f_create ) VALUES (cur_activation.person_id, now(), cur_activation.person_id, 't');
      DELETE FROM auth.account_activation WHERE account_activation.activation_string = activation_string;
    ELSE
      RAISE EXCEPTION 'invalid activation string.';
    END IF;
    RETURN cur_activation.conference_id;
  END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

