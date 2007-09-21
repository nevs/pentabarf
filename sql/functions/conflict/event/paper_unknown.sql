
CREATE OR REPLACE FUNCTION conflict_event_paper_unknown( conference_id INTEGER ) RETURNS SETOF conflict_event AS $$
      SELECT event_id
        FROM event
       WHERE event.conference_id = conference_id AND
             event.event_state = 'accepted' AND
             event.f_paper IS NULL
$$ LANGUAGE 'plpgsql';

