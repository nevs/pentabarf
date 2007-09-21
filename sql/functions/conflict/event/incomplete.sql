
-- returns all accepted events with incomplete day/time/room
CREATE OR REPLACE FUNCTION conflict_event_incomplete(INTEGER) RETURNS SETOF conflict_event AS $$
  SELECT event_id
    FROM event
    WHERE conference_id = $1 AND
          event_state = 'accepted' AND
          event_state_progress = 'confirmed' AND
          (day IS NULL OR
           room_id IS NULL OR
           start_time IS NULL) AND
          (day IS NOT NULL OR
           room_id IS NOT NULL OR
           start_time IS NOT NULL)
$$ LANGUAGE SQL;

