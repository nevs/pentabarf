CREATE OR REPLACE VIEW release.view_schedule_day AS
  SELECT
    conference_release_id,
    conference_id,
    conference_day_id,
    conference_day,
    name
  FROM
    release.conference_day
  WHERE
    conference_day.public = TRUE
  ORDER BY conference_day.conference_day
;

