
-- returns events followed by another event without a break in between
CREATE OR REPLACE FUNCTION conflict.conflict_event_without_break_after( INTEGER ) RETURNS SETOF conflict.conflict_event_event AS $$
-- Loop through all events
  SELECT
    e2.event_id AS event_id1,
    e1.event_id AS event_id2
  FROM event AS e1
    INNER JOIN conference_day USING(conference_id,conference_day_id)
    INNER JOIN (
      SELECT
        event.event_id,
        event.conference_id,
        event.conference_room_id,
        event.start_time,
        event.duration,
        conference_day.conference_day
      FROM event
        INNER JOIN conference_day USING(conference_id,conference_day_id)
    ) AS e2 ON (
      e1.conference_id = e2.conference_id AND
      e1.conference_room_id = e2.conference_room_id AND
      e1.start_time + conference_day.conference_day = e2.start_time + e2.conference_day + e2.duration
    )
  WHERE
    e1.conference_id = $1;
$$ LANGUAGE 'SQL';

