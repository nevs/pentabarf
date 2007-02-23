
-- returns all accepted events with no conference track set
CREATE OR REPLACE FUNCTION conflict_event_no_track(INTEGER) RETURNS SETOF conflict_event AS $$
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
             conference_track_id IS NULL
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

