
CREATE OR REPLACE FUNCTION conflict.conflict_event_paper_unknown( conference_id INTEGER ) RETURNS SETOF conflict.conflict_event AS $$
      SELECT event_id
        FROM event
       WHERE event.conference_id = $1 AND
             event.event_state = 'accepted' AND
             event.paper IS NULL
$$ LANGUAGE SQL;

