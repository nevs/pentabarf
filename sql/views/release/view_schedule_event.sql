CREATE OR REPLACE VIEW release.view_schedule_event AS
  SELECT event.event_id,
         event.conference_id,
         event.slug,
         event.title,
         event.subtitle,
         event.abstract,
         event.description,
         event.conference_track_id,
         conference_track.conference_track,
         event.conference_day_id,
         conference_day.conference_day,
         conference_day.name AS conference_day_name,
         event.duration,
         event.start_time + conference.day_change AS start_time,
         (conference_day.conference_day + event.start_time + conference.day_change)::timestamp AS start_datetime,
         (conference_day.conference_day + event.start_time + conference.day_change + event.duration)::timestamp AS end_datetime,
         event.conference_room_id,
         conference_room.conference_room,
         event_type_localized.event_type,
         event_type_localized.name AS event_type_name,
         language_localized.language,
         event_state_localized.translated,
         language_localized.name AS language_name,
         event_image.file_extension
    FROM release.event
         LEFT OUTER JOIN (
             SELECT event_id,
                    file_extension
               FROM event_image
                    INNER JOIN mime_type USING (mime_type)
         ) AS event_image USING (event_id)
         INNER JOIN event_state_localized USING (event_state)
         INNER JOIN conference USING (conference_id)
         INNER JOIN conference_room ON (
             event.conference_room_id = conference_room.conference_room_id AND
             conference_room.public = 't' )
         INNER JOIN conference_day ON (
             event.conference_day_id = conference_day.conference_day_id AND
             conference_day.public = 't' )
         LEFT OUTER JOIN language_localized USING (language,translated)
         LEFT OUTER JOIN event_type_localized USING (event_type,translated)
         LEFT OUTER JOIN conference_track USING (conference_track_id)
    WHERE
      event.event_state = 'accepted' AND
      event.event_state_progress = 'reconfirmed' AND
      event.public = 't' AND
      event.start_time IS NOT NULL
;

