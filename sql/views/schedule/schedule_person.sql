
CREATE OR REPLACE VIEW view_schedule_person AS
  SELECT view_person.person_id,
         view_person.name,
         speaker.event_id,
         speaker.title,
         speaker.subtitle,
         speaker.conference_id,
         conference_person.conference_person_id,
         conference_person.abstract,
         conference_person.description,
         conference_person.email_public,
         person_image.f_public,
         person_image.file_extension
    FROM view_person
         LEFT OUTER JOIN (
             SELECT person_id,
                    f_public,
                    file_extension
               FROM person_image
                    INNER JOIN mime_type USING (mime_type_id)
              WHERE f_public = 't'
         ) AS person_image USING (person_id)
         INNER JOIN (
             SELECT event_person.person_id,
                    event.conference_id,
                    event.event_id,
                    event.title,
                    event.subtitle
               FROM event_person
                    INNER JOIN event ON (
                        event_person.event_id = event.event_id AND
                        event.event_state = 'accepted' AND
                        event.event_state_progress = 'confirmed' AND
                        event.f_public = 't' AND
                        event.day IS NOT NULL AND
                        event.start_time IS NOT NULL AND
                        event.room_id IS NOT NULL )
                    INNER JOIN room ON (
                        event.room_id = room.room_id AND
                        room.f_public = 't' )
              WHERE event_person.event_role IN ('speaker','moderator') AND
                    event_person.event_role_state = 'confirmed'
         ) AS speaker USING (person_id)
         LEFT OUTER JOIN conference_person USING (person_id, conference_id)
;

