
CREATE OR REPLACE FUNCTION merge_person( primary_person INTEGER, secondary_person INTEGER ) RETURNS INTEGER AS $$
  DECLARE
  BEGIN
    UPDATE auth.person_role SET person_id = primary_person
      WHERE person_id = secondary_person AND
            role NOT IN ( SELECT role FROM auth.person_role WHERE person_id = primary_person );
    DELETE FROM auth.person_role WHERE person_id = secondary_person;
    UPDATE person_language SET person_id = primary_person
      WHERE person_id = secondary_person AND
            language_id NOT IN ( SELECT language_id FROM person_language WHERE person_id = primary_person );
    DELETE FROM person_language WHERE person_id = secondary_person;
    UPDATE person_transaction SET person_id = primary_person WHERE person_id = secondary_person;
    UPDATE person_transaction SET changed_by = primary_person WHERE changed_by = secondary_person;
    UPDATE person SET last_modified_by = primary_person WHERE last_modified_by = secondary_person;
    UPDATE person_phone SET person_id = primary_person WHERE person_id = secondary_person;
    UPDATE person_im SET person_id = primary_person WHERE person_id = secondary_person;
    UPDATE person_rating SET person_id = primary_person
      WHERE person_id = secondary_person AND
            evaluator_id NOT IN ( SELECT evaluator_id FROM person_rating WHERE person_id = primary_person);
    UPDATE person_travel SET person_id = primary_person
      WHERE person_id = secondary_person AND
        conference_id NOT IN ( SELECT conference_id FROM person_travel WHERE person_id = primary_person );
    UPDATE person_travel SET last_modified_by = primary_person WHERE last_modified_by = secondary_person;
    UPDATE person_image SET person_id = primary_person WHERE person_id = secondary_person;

    UPDATE event SET last_modified_by = primary_person WHERE last_modified_by = secondary_person;
    UPDATE event_transaction SET changed_by = primary_person WHERE changed_by = secondary_person;
    UPDATE event_person SET person_id = primary_person WHERE person_id = secondary_person;
    UPDATE event_person SET last_modified_by = primary_person WHERE last_modified_by = secondary_person;
    UPDATE event_attachment SET last_modified_by = primary_person WHERE last_modified_by = secondary_person;

    UPDATE conference SET last_modified_by = primary_person WHERE last_modified_by = secondary_person;
    UPDATE conference_transaction SET changed_by = primary_person WHERE changed_by = secondary_person;
    UPDATE conference_person SET person_id = primary_person
      WHERE person_id = secondary_person AND
            conference_id NOT IN ( SELECT conference_id FROM conference_person WHERE person_id = primary_person );
    UPDATE conference_person SET last_modified_by = primary_person WHERE last_modified_by = secondary_person;

    DELETE FROM person WHERE person_id = secondary_person;
    RETURN primary_person;
  END;
$$ LANGUAGE PLPGSQL;

