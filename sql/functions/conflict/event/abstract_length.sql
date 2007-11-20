
CREATE OR REPLACE FUNCTION conflict.conflict_event_abstract_length(INTEGER) RETURNS SETOF conflict.conflict_event AS $$
  SELECT
    event_id
  FROM
    event
    INNER JOIN conference ON (
      conference.conference_id = event.conference_id AND
      conference.abstract_length IS NOT NULL )
  WHERE
    conference.conference_id = $1 AND
    length( event.abstract ) > conference.abstract_length;
$$ LANGUAGE SQL;

