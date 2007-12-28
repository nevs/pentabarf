
CREATE OR REPLACE VIEW view_schedule_event AS
  SELECT event.event_id,
         event.conference_id,
         event.tag AS event_tag,
         event.title,
         event.subtitle,
         event.abstract,
         event.description,
         event.conference_track,
         event.conference_day,
         event.duration,
         event.start_time,
         (event.conference_day + event.start_time + conference.day_change)::timestamp AS start_datetime,
         (event.conference_day + event.start_time + conference.day_change + event.duration)::timestamp AS end_datetime,
         event.start_time + conference.day_change AS real_starttime,
         event.conference_room,
         event_type_localized.event_type,
         event_type_localized.name AS event_type_name,
         language_localized.language,
         language_localized.translated,
         language_localized.name AS language_name,
         speaker.person_id,
         speaker.name,
         event_image.file_extension
    FROM event_person
         LEFT OUTER JOIN (
             SELECT event_id,
                    file_extension
               FROM event_image
                    INNER JOIN mime_type USING (mime_type)
         ) AS event_image USING (event_id)
         INNER JOIN event ON (
             event.event_id = event_person.event_id AND
             event.event_state = 'accepted' AND
             event.event_state_progress = 'confirmed' AND
             event.public = 't' AND
             event.start_time IS NOT NULL )
         INNER JOIN event_state_localized USING (event_state)
         LEFT OUTER JOIN language_localized USING (language,translated)
         INNER JOIN conference USING (conference_id)
         INNER JOIN conference_room ON (
             event.conference_id = conference_room.conference_id AND
             event.conference_room = conference_room.conference_room AND
             conference_room.public = 't' )
         INNER JOIN conference_day ON (
             event.conference_id = conference_day.conference_id AND
             event.conference_day = conference_day.conference_day AND
             conference_day.public = 't' )
         INNER JOIN (
             SELECT person_id,
                    name
               FROM view_person
         ) AS speaker USING (person_id)
         LEFT OUTER JOIN event_type_localized USING (event_type,translated)
    WHERE
      event_person.event_role IN ('speaker','moderator') AND
      event_person.event_role_state = 'confirmed'
;

