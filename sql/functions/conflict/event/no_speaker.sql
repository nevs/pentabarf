
-- returns all confirmed events without confirmed speaker/moderator
CREATE OR REPLACE FUNCTION conflict_event_no_speaker(integer) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
-- Loop through all events
    FOR cur_event IN
      SELECT event_id 
        FROM event 
        WHERE event.conference_id = cur_conference_id AND
              event_state = 'accepted' AND
              event_state_progress = 'confirmed'
    LOOP
      IF NOT EXISTS (SELECT 1 FROM event_person 
                              INNER JOIN event_role USING (event_role_id) 
                              INNER JOIN event_role_state USING (event_role_state_id) 
                       WHERE event_person.event_id = cur_event.event_id AND
                             event_role.tag IN ('speaker', 'moderator') AND
                             event_role_state.tag = 'confirmed')
      THEN
        RETURN NEXT cur_event;
      END IF;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

