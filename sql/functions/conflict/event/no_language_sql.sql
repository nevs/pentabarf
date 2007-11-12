
-- returns all accepted events with no language set
CREATE OR REPLACE FUNCTION conflict.conflict_event_no_language(INTEGER) RETURNS SETOF conflict.conflict_event AS $$
      SELECT event_id
        FROM event
       WHERE conference_id = $1 AND
             event_state = 'accepted' AND
             language IS NULL
$$ LANGUAGE SQL;

