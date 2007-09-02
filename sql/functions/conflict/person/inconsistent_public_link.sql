
-- returns all persons with inconsistent public links
CREATE OR REPLACE FUNCTION conflict_person_inconsistent_public_link(integer) RETURNS SETOF conflict_person AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_conflict conflict_person%rowtype;
  BEGIN

    FOR cur_conflict IN
      SELECT person_id
        FROM person
             INNER JOIN conference_person USING (person_id)
       WHERE conference_person.conference_id = cur_conference_id AND
             EXISTS (SELECT 1 FROM conference_person_link
                             WHERE conference_person_id = conference_person.conference_person_id AND
                                   url NOT SIMILAR TO '[a-z]+:%')
    LOOP
      RETURN NEXT cur_conflict;
    END LOOP;

    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

