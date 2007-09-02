
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
         event.event_state_id,
         event.event_state_progress_id,
         event.event_type_id,
         event.language_id,
         event.room_id,
         event.day,
         (event.start_time + conference.day_change)::interval AS start_time,
         event.f_public,
         event_image.mime_type_id,
         mime_type.mime_type,
         mime_type.file_extension,
         view_event_state.language_id AS translated_id,
         view_event_state.tag AS event_state_tag,
         view_event_state.name AS event_state,
         view_event_state_progress.tag AS event_state_progress_tag,
         view_event_state_progress.name AS event_state_progress,
         view_room.tag AS room_tag,
         view_room.name AS room,
         conference_track.tag AS track,
         array_to_string(ARRAY(
           SELECT view_person.name
             FROM event_person
             INNER JOIN event_role ON (
               event_role.event_role_id = event_person.event_role_id AND
               (event_role.tag IN ('speaker','moderator') ) )
             INNER JOIN event_role_state ON (
               event_role_state.event_role_state_id = event_person.event_role_state_id AND 
               event_role_state.tag::text = 'confirmed' )
             INNER JOIN view_person USING (person_id)
             WHERE event_person.event_id = event.event_id), ', '::text) AS speakers
    FROM event
         INNER JOIN conference USING (conference_id)
         INNER JOIN view_event_state USING (event_state_id)
         INNER JOIN view_event_state_progress ON (
             view_event_state.language_id = view_event_state_progress.language_id AND
             event.event_state_progress_id = view_event_state_progress.event_state_progress_id)
         LEFT OUTER JOIN conference_track USING (conference_track_id)
         LEFT OUTER JOIN event_image USING (event_id)
         LEFT OUTER JOIN mime_type USING (mime_type_id)
         LEFT OUTER JOIN view_room ON (
             view_event_state.language_id = view_room.language_id AND
             event.room_id = view_room.room_id);

