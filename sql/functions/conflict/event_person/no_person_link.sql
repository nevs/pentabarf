
-- returns event_persons which have a public event role
-- that do not have a link
CREATE OR REPLACE FUNCTION conflict.conflict_event_person_no_person_link(integer) RETURNS SETOF conflict.conflict_event_person AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event RECORD;
    cur_speaker RECORD;
    cur_conflict conflict.conflict_event_person%rowtype;
  BEGIN

-- Loop through all event_persons
    FOR cur_speaker IN
      SELECT event_id, person_id, conference_id
        FROM event_person
        INNER JOIN event_role USING (event_role)
        INNER JOIN event USING (event_id)
        WHERE event_role.event_role IN ('speaker','moderator') AND
              event_role_state = 'confirmed' AND
              event.conference_id = cur_conference_id AND
              event.language IS NOT NULL
    LOOP
      IF NOT EXISTS (SELECT 1 FROM conference_person_link INNER JOIN conference_person USING(conference_person_id) WHERE person_id = cur_speaker.person_id AND conference_id = cur_speaker.conference_id )
      THEN
        cur_conflict.person_id := cur_speaker.person_id;
        cur_conflict.event_id := cur_speaker.event_id;
        RETURN NEXT cur_conflict;
      END IF;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

