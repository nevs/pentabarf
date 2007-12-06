
CREATE OR REPLACE FUNCTION merge_person( primary_person INTEGER, secondary_person INTEGER ) RETURNS INTEGER AS $$
  BEGIN
    UPDATE auth.account SET person_id = primary_person WHERE person_id = secondary_person AND NOT EXISTS(SELECT person_id FROM auth.account WHERE person_id = primary_person);
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

