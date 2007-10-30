
-- returns all accepted events with inconsistent tag
CREATE OR REPLACE FUNCTION conflict.conflict_event_inconsistent_tag(INTEGER) RETURNS SETOF conflict.conflict_event AS $$
      SELECT event_id
        FROM event
       WHERE event.tag IS NOT NULL AND
             conference_id = $1 AND
             event.event_state = 'accepted' AND
             event.tag NOT SIMILAR TO E'[a-z0-9\\_]+'
$$ LANGUAGE SQL;

