
-- returns all accepted events with missing tag
CREATE OR REPLACE FUNCTION conflict_event_missing_tag(INTEGER) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
    FOR cur_event IN
      SELECT event_id 
        FROM event 
             INNER JOIN event_state USING (event_state_id)
        WHERE conference_id = cur_conference_id AND
              event_state.tag = 'accepted' AND
              event.tag IS NULL
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

