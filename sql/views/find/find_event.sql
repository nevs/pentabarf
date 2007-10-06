
CREATE OR REPLACE VIEW view_find_event AS
  SELECT event.event_id,
         event.conference_id,
         event.title,
         event.subtitle,
         event.abstract,
         event.description,
         event.duration,
         event.event_origin_id,
         event.conference_track_id,
         event.event_state,
         event.event_state_progress,
         event.event_type,
         event.language_id,
         event.room_id,
         event.day,
         (event.start_time + conference.day_change)::interval AS start_time,
         event.f_public,
         event_state_localized.language_id AS translated_id,
         event_state_localized.name AS event_state_name,
         event_state_progress_localized.name AS event_state_progress_name,
         event_image.mime_type_id,
         mime_type.mime_type,
         mime_type.file_extension,
         view_room.tag AS room_tag,
         view_room.name AS room,
         conference_track.tag AS track,
         array_to_string(ARRAY(
           SELECT view_person.name
             FROM
               event_person
               INNER JOIN view_person USING (person_id)
             WHERE
               event_person.event_role IN ('speaker','moderator') AND
               event_person.event_role_state = 'confirmed' AND
               event_person.event_id = event.event_id
           ), ', '::text) AS speakers
    FROM event
         INNER JOIN conference USING (conference_id)
         INNER JOIN event_state_localized USING (event_state)
         INNER JOIN event_state_progress_localized ON (
             event_state_localized.language_id = event_state_progress_localized.language_id AND
             event.event_state = event_state_progress_localized.event_state AND
             event.event_state_progress = event_state_progress_localized.event_state_progress)
         LEFT OUTER JOIN conference_track USING (conference_track_id)
         LEFT OUTER JOIN event_image USING (event_id)
         LEFT OUTER JOIN mime_type USING (mime_type_id)
         LEFT OUTER JOIN view_room ON (
             event_state_localized.language_id = view_room.language_id AND
             event.room_id = view_room.room_id);

