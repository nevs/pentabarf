
CREATE OR REPLACE FUNCTION auth.activate_account_id( cur_account_id INTEGER ) RETURNS VOID AS $$
  DECLARE
    cur_person_id INTEGER;
  BEGIN
    -- delete all old activation strings for this account id
    DELETE FROM auth.account_activation WHERE account_activation.account_id = cur_account_id;

    -- give account submitter role if the account has no role yet
    PERFORM account_id FROM auth.account_role WHERE account_role.account_id = cur_account_id;
    IF NOT FOUND THEN
      INSERT INTO auth.account_role(account_id, role) VALUES (cur_account_id, 'submitter');
    END IF;

    SELECT INTO cur_person_id nextval(pg_get_serial_sequence('base.person','person_id'));
    INSERT INTO person(person_id,nickname,email) SELECT cur_person_id,login_name,email FROM auth.account WHERE account.account_id = cur_account_id;
    UPDATE auth.account SET person_id = cur_person_id WHERE account.account_id = cur_account_id;

    RETURN;
  END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

