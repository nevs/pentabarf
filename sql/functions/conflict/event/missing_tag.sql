
-- returns all accepted events with missing tag
CREATE OR REPLACE FUNCTION conflict.conflict_event_missing_tag(INTEGER) RETURNS SETOF conflict.conflict_event AS $$
      SELECT event_id
        FROM event
        WHERE conference_id = $1 AND
              event_state = 'accepted' AND
              event.tag IS NULL
$$ LANGUAGE SQL;

