
-- returns all persons with inconsistent public links
CREATE OR REPLACE FUNCTION conflict.conflict_person_inconsistent_public_link(integer) RETURNS SETOF conflict.conflict_person AS $$
  SELECT person_id
  FROM person
    INNER JOIN conference_person USING (person_id)
  WHERE conference_person.conference_id = $1 AND
    EXISTS (SELECT 1 FROM conference_person_link
      WHERE conference_person_id = conference_person.conference_person_id AND
        url NOT SIMILAR TO '[a-z]+:%')
$$ LANGUAGE SQL;

