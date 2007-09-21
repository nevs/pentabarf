
-- returns all accepted events with no conference track set
CREATE OR REPLACE FUNCTION conflict_event_no_track(INTEGER) RETURNS SETOF conflict_event AS $$
      SELECT event_id
        FROM event
       WHERE conference_id = $1 AND
             event_state = 'accepted' AND
             conference_track_id IS NULL
$$ LANGUAGE SQL;

