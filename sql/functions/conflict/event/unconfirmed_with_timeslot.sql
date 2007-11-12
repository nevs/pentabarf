
CREATE OR REPLACE FUNCTION conflict.conflict_event_unconfirmed_with_timeslot(INTEGER) RETURNS SETOF conflict.conflict_event AS $$
  SELECT event_id
    FROM event
   WHERE event.conference_id = $1 AND
         event.event_state = 'accepted' AND
         event.event_state_progress <> 'confirmed' AND
         event.start_time IS NOT NULL AND
         event.conference_room IS NOT NULL
$$ LANGUAGE SQL;

