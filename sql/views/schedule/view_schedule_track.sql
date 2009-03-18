CREATE OR REPLACE VIEW view_schedule_track AS
  SELECT
    conference_id,
    conference_track_id,
    conference_track,
    rank
  FROM
    conference_track
  WHERE
    EXISTS( SELECT 1 FROM view_schedule_event WHERE view_schedule_event.conference_track_id = conference_track.conference_track_id )
  ORDER BY conference_track.rank
;

