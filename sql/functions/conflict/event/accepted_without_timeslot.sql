
CREATE OR REPLACE FUNCTION conflict.conflict_event_accepted_without_timeslot(INTEGER) RETURNS SETOF conflict.conflict_event AS $$
      SELECT event_id
        FROM event
       WHERE event.conference_id = $1 AND
             event.event_state = 'accepted' AND
             event.event_state_progress = 'confirmed' AND
             ( event.start_time IS NULL OR
               event.conference_room IS NULL )
$$ LANGUAGE SQL;

