
-- merge two person entries
-- all entries of secondary_person will be moved to primary_person and 
-- secondary_person will be deleted afterwards
CREATE OR REPLACE FUNCTION merge_person( primary_person INTEGER, secondary_person INTEGER ) RETURNS INTEGER AS $$
  DECLARE
    primary_account_id INTEGER;
  BEGIN
    -- if primary has no account move the secondary account to primary
    UPDATE auth.account SET person_id = primary_person 
      WHERE person_id = secondary_person AND 
        NOT EXISTS(SELECT person_id FROM auth.account WHERE person_id = primary_person);

    SELECT INTO primary_account_id account_id FROM auth.account WHERE person_id = primary_person;

    -- copy roles from secondary account to primary account
    INSERT INTO auth.account_role(account_id,role) 
      SELECT primary_account_id, role 
        FROM auth.account INNER JOIN auth.account_role USING (account_id)
        WHERE account.person_id = secondary_person
      EXCEPT SELECT primary_account_id, role 
        FROM auth.account INNER JOIN auth.account_role USING (account_id)
        WHERE account.person_id = primary_person;

    -- copy conference roles from secondary account to primary account
    INSERT INTO auth.account_conference_role(account_id,conference_id,conference_role) 
      SELECT primary_account_id, conference_id, conference_role
        FROM auth.account INNER JOIN auth.account_conference_role USING (account_id)
        WHERE account.person_id = secondary_person
      EXCEPT SELECT primary_account_id, conference_id, conference_role
        FROM auth.account INNER JOIN auth.account_conference_role USING (account_id)
        WHERE account.person_id = primary_person;

    -- delete secondary account
    DELETE FROM auth.account WHERE person_id = secondary_person;

    UPDATE person_language SET person_id = primary_person
      WHERE person_id = secondary_person AND
            language NOT IN ( SELECT language FROM person_language WHERE person_id = primary_person );
    DELETE FROM person_language WHERE person_id = secondary_person;

    UPDATE person_transaction SET person_id = primary_person WHERE person_id = secondary_person;
    UPDATE person_transaction SET changed_by = primary_person WHERE changed_by = secondary_person;

    UPDATE person_availability SET person_id = primary_person WHERE person_id = secondary_person;
    UPDATE person_phone SET person_id = primary_person WHERE person_id = secondary_person;
    UPDATE person_im SET person_id = primary_person WHERE person_id = secondary_person;
    UPDATE person_rating SET person_id = primary_person
      WHERE person_id = secondary_person AND
            evaluator_id NOT IN ( SELECT evaluator_id FROM person_rating WHERE person_id = primary_person);
    UPDATE person_image SET person_id = primary_person WHERE person_id = secondary_person AND NOT EXISTS( SELECT 1 FROM person_image WHERE person_id = primary_person);

    UPDATE event_transaction SET changed_by = primary_person WHERE changed_by = secondary_person;
    UPDATE event_person SET person_id = primary_person WHERE person_id = secondary_person;

    UPDATE conference_transaction SET changed_by = primary_person WHERE changed_by = secondary_person;
    UPDATE conference_person SET person_id = primary_person
      WHERE person_id = secondary_person AND
            conference_id NOT IN ( SELECT conference_id FROM conference_person WHERE person_id = primary_person );

    DELETE FROM person WHERE person_id = secondary_person;
    RETURN primary_person;
  END;
$$ LANGUAGE PLPGSQL;

