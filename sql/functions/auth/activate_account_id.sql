
CREATE OR REPLACE FUNCTION auth.activate_account_id( cur_account_id INTEGER ) RETURNS VOID AS $$
  DECLARE
    cur_person_id INTEGER;
  BEGIN
    -- delete all old activation strings for this account id
    DELETE FROM auth.account_activation WHERE account_activation.account_id = cur_account_id;

    INSERT INTO auth.account_role(account_id, role) VALUES (cur_account_id, 'submitter');
    SELECT INTO cur_person_id nextval(pg_get_serial_sequence('base.person','person_id'));
    INSERT INTO person(person_id,nickname,email) SELECT cur_person_id,login_name,email FROM auth.account WHERE account.account_id = cur_account_id;
    UPDATE auth.account SET person_id = cur_person_id WHERE account.account_id = cur_account_id;
    INSERT INTO person_transaction( person_id, changed_when, changed_by, f_create ) VALUES (cur_person_id, now(), cur_person_id, 't');

    RETURN;
  END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

