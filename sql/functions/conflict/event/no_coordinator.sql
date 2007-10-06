
-- returns all events without coordinator
CREATE OR REPLACE FUNCTION conflict_event_no_coordinator(integer) RETURNS setof conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
    -- Loop through all events
    FOR cur_event IN
      SELECT event_id FROM event
        WHERE event.conference_id = cur_conference_id
    LOOP
      IF NOT EXISTS (SELECT 1 FROM event_person 
                       WHERE event_person.event_id = cur_event.event_id AND
                             event_role = 'coordinator')
      THEN
        RETURN NEXT cur_event;
      END IF;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

