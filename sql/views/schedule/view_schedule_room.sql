CREATE OR REPLACE VIEW view_schedule_room AS
  SELECT
    conference_id,
    conference_room_id,
    conference_room,
    public,
    size,
    remark,
    rank
  FROM
    conference_room
  WHERE
    conference_room.public = TRUE
  ORDER BY rank, conference_room
;

