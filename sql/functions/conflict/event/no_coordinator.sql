
-- returns all events without coordinator
CREATE OR REPLACE FUNCTION conflict.conflict_event_no_coordinator(integer) RETURNS setof conflict.conflict_event AS $$
  SELECT event_id FROM event
    WHERE event.conference_id = $1
      AND NOT EXISTS (SELECT 1 FROM event_person
        WHERE event_person.event_id = event.event_id AND
          event_role = 'coordinator');
$$ LANGUAGE SQL;

