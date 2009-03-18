CREATE OR REPLACE VIEW view_schedule_day AS
  SELECT
    conference_id,
    conference_day_id,
    conference_day,
    name
  FROM
    conference_day
  WHERE
    conference_day.public = TRUE
  ORDER BY conference_day.conference_day
;

