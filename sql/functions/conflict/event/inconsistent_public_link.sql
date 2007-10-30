
-- returns all events with inconsistent public links
CREATE OR REPLACE FUNCTION conflict.conflict_event_inconsistent_public_link(INTEGER) RETURNS SETOF conflict.conflict_event AS $$
  SELECT event_id
  FROM event
  WHERE conference_id = $1 AND
    EXISTS (SELECT 1 FROM event_link
      WHERE event_id = event.event_id AND
        url NOT SIMILAR TO '[a-z]+:%');
$$ LANGUAGE SQL;

