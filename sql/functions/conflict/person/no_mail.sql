
-- returns all speaker/moderator without email
CREATE OR REPLACE FUNCTION conflict.conflict_person_no_email(integer) RETURNS SETOF conflict.conflict_person AS $$
      SELECT person_id FROM person
                            INNER JOIN event_person USING (person_id)
                            INNER JOIN event USING (event_id)
        WHERE person.email_contact IS NULL AND
              event.conference_id = $1;
$$ LANGUAGE SQL;

