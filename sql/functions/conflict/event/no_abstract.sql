
CREATE OR REPLACE FUNCTION conflict.conflict_event_no_abstract(INTEGER) RETURNS SETOF conflict.conflict_event AS $$
  SELECT
    event_id
  FROM event
  WHERE
    event.abstract IS NULL AND
    event.conference_id = $1;
$$ LANGUAGE SQL;

