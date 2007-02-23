
CREATE OR REPLACE FUNCTION conflict_event_accepted_without_timeslot(INTEGER) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event RECORD;
  BEGIN
    FOR cur_event IN
      SELECT event_id
        FROM event
             INNER JOIN event_state ON (
               event_state.event_state_id = event.event_state_id AND
               event_state.tag = 'accepted' )
             INNER JOIN event_state_progress ON (
               event_state_progress.event_state_progress_id = event.event_state_progress_id AND
               event_state_progress.tag = 'confirmed' )
       WHERE event.conference_id = cur_conference_id AND
             ( event.start_time IS NULL OR 
               event.room_id IS NULL )
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

