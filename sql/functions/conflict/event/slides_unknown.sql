
CREATE OR REPLACE FUNCTION conflict_event_slides_unknown( conference_id INTEGER ) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_event RECORD;
  BEGIN
    FOR cur_event IN
      SELECT event_id
        FROM event
             INNER JOIN event_state ON (
                 event_state.event_state_id = event.event_state_id AND 
                 event_state.tag = 'accepted' )
       WHERE event.conference_id = conference_id AND
             event.f_slides IS NULL
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
  END;
$$ LANGUAGE 'plpgsql';

