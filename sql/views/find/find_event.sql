
CREATE OR REPLACE VIEW view_find_event AS
  SELECT event.event_id,
         event.conference_id,
         event.title,
         event.subtitle,
         event.abstract,
         event.description,
         event.duration,
         event.event_origin,
         event.conference_track,
         event.event_state,
         event.event_state_progress,
         event.event_type,
         event.language,
         event.conference_room,
         event.conference_day,
         (event.start_time + conference.day_change)::interval AS start_time,
         event.public,
         event_state_localized.translated,
         event_state_localized.name AS event_state_name,
         event_state_progress_localized.name AS event_state_progress_name,
         event_image.mime_type,
         mime_type.file_extension,
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
         INNER JOIN event_state_progress_localized USING (translated,event_state,event_state_progress)
         LEFT OUTER JOIN event_image USING (event_id)
         LEFT OUTER JOIN mime_type USING (mime_type);

