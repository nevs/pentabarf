
CREATE OR REPLACE VIEW view_schedule_event AS
  SELECT event.event_id,
         event.conference_id,
         event.tag AS event_tag,
         event.title,
         event.subtitle,
         event.abstract,
         event.description,
         event.day,
         event.duration,
         event.start_time,
         (conference.start_date + event.day + '-1'::integer + event.start_time + conference.day_change)::timestamp AS start_datetime,
         (conference.start_date + event.day + '-1'::integer + event.start_time + conference.day_change + event.duration)::timestamp AS end_datetime,
         event.start_time + conference.day_change AS real_starttime,
         event.conference_room,
         event_type_localized.event_type,
         event_type_localized.name AS event_type_name,
         conference_track.conference_track_id,
         conference_track.tag AS conference_track,
         view_language.language_id,
         view_language.translated_id,
         view_language.name AS language,
         view_language.tag AS language_tag,
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
             event.f_public = 't' AND
             event.day IS NOT NULL AND
             event.start_time IS NOT NULL AND
             event.conference_room IS NOT NULL )
         INNER JOIN view_language USING (language_id)
         INNER JOIN conference USING (conference_id)
         INNER JOIN (
             SELECT person_id,
                    name
               FROM view_person
         ) AS speaker USING (person_id)
         LEFT OUTER JOIN conference_track USING (conference_track_id)
         LEFT OUTER JOIN event_type_localized ON (
             event_type_localized.event_type = event.event_type AND
             event_type_localized.language_id = view_language.translated_id)
    WHERE
      event_person.event_role IN ('speaker','moderator') AND
      event_person.event_role_state = 'confirmed'
;

