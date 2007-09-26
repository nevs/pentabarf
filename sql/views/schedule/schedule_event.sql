
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
         view_room.language_id AS translated_id,
         view_event_type.event_type_id,
         view_event_type.name AS event_type,
         view_event_type.tag AS event_type_tag,
         conference_track.conference_track_id,
         conference_track.tag AS conference_track,
         view_language.language_id,
         view_language.name AS language,
         view_language.tag AS language_tag,
         speaker.person_id,
         speaker.name,
         event_image.file_extension,
         view_room.room_id,
         view_room.tag AS room_tag,
         view_room.name AS room
    FROM event_person
         LEFT OUTER JOIN (
             SELECT event_id,
                    file_extension
               FROM event_image
                    INNER JOIN mime_type USING (mime_type_id)
         ) AS event_image USING (event_id)
         INNER JOIN event ON (
             event.event_id = event_person.event_id AND
             event.event_state = 'accepted' AND
             event.event_state_progress = 'confirmed' AND
             event.f_public = 't' AND
             event.day IS NOT NULL AND
             event.start_time IS NOT NULL AND
             event.room_id IS NOT NULL )
         INNER JOIN conference USING (conference_id)
         INNER JOIN view_room ON (
             view_room.room_id = event.room_id AND
             view_room.f_public = 't' )
         INNER JOIN event_role ON (
             event_person.event_role_id = event_role.event_role_id AND
             event_role.tag IN ('speaker', 'moderator') )
         INNER JOIN event_role_state ON (
             event_person.event_role_state_id = event_role_state.event_role_state_id AND
             event_role_state.tag = 'confirmed' )
         INNER JOIN (
             SELECT person_id,
                    name
               FROM view_person
         ) AS speaker USING (person_id)
         LEFT OUTER JOIN conference_track USING (conference_track_id)
         LEFT OUTER JOIN view_event_type ON (
             view_event_type.event_type_id = event.event_type_id AND
             view_event_type.language_id = view_room.language_id)
         LEFT OUTER JOIN view_language ON (
             view_language.translated_id = view_room.language_id AND
             view_language.language_id = event.language_id )
;

