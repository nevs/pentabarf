
-- returns all events with a language not in conference_language
CREATE OR REPLACE FUNCTION conflict.conflict_event_conference_language(INTEGER) RETURNS SETOF conflict.conflict_event AS $$
  SELECT
    event_id
  FROM
    event
  WHERE
    event.conference_id = $1 AND
    event.language_id IS NOT NULL AND
    NOT EXISTS (SELECT 1
      FROM conference_language
      WHERE conference_id = $1 AND
        language_id = event.language_id);
$$ LANGUAGE SQL;

