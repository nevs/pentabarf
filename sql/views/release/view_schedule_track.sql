CREATE OR REPLACE VIEW release.view_schedule_track AS
  SELECT
    conference_release_id,
    conference_id,
    conference_track_id,
    conference_track,
    rank
  FROM
    release.conference_track
  WHERE
    EXISTS (
      SELECT 1
      FROM
        release.view_schedule_event
      WHERE
        view_schedule_event.conference_release_id = conference_track.conference_release_id AND
        view_schedule_event.conference_track_id = conference_track.conference_track_id 
    )
  ORDER BY rank, conference_track
;

