CREATE OR REPLACE VIEW release.view_schedule_room AS
  SELECT
    conference_release_id,
    conference_id,
    conference_room_id,
    conference_room,
    public,
    size,
    remark,
    rank
  FROM
    release.conference_room
  WHERE
    conference_room.public = TRUE
  ORDER BY rank, conference_room
;

