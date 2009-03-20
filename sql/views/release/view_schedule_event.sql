CREATE OR REPLACE VIEW release.view_schedule_event AS
  SELECT
    event.event_id,
    event.conference_id,
    event.conference_release_id,
    event.slug,
    event.title,
    event.subtitle,
    event.abstract,
    event.description,
    event.conference_track_id,
    conference_track.conference_track,
    event.conference_day_id,
    view_schedule_day.conference_day,
    view_schedule_day.name AS conference_day_name,
    event.duration,
    event.start_time + conference.day_change AS start_time,
    (view_schedule_day.conference_day + event.start_time + conference.day_change)::timestamp AS start_datetime,
    (view_schedule_day.conference_day + event.start_time + conference.day_change + event.duration)::timestamp AS end_datetime,
    event.conference_room_id,
    view_schedule_room.conference_room,
    event_type_localized.event_type,
    event_type_localized.name AS event_type_name,
    language_localized.language,
    event_state_localized.translated,
    language_localized.name AS language_name,
    event_image.file_extension
  FROM release.event
    LEFT OUTER JOIN (
      SELECT
        event_id,
        file_extension
      FROM
        event_image
        INNER JOIN mime_type USING (mime_type)
    ) AS event_image USING (event_id)
    INNER JOIN event_state_localized USING (event_state)
    INNER JOIN release.conference USING (conference_release_id,conference_id)
    INNER JOIN release.view_schedule_room USING(conference_release_id, conference_room_id)
    INNER JOIN release.view_schedule_day USING(conference_release_id, conference_day_id)
    LEFT OUTER JOIN language_localized USING (language,translated)
    LEFT OUTER JOIN event_type_localized USING (event_type,translated)
    LEFT OUTER JOIN release.conference_track USING (conference_release_id,conference_track_id)
  WHERE
    event.event_state = 'accepted' AND
    event.event_state_progress = 'reconfirmed' AND
    event.public = 't' AND
    event.start_time IS NOT NULL AND
    event.conference_room_id IS NOT NULL
  ORDER BY title, subtitle
;

