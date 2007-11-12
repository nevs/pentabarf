
-- returns all persons with events where slides are missing
CREATE OR REPLACE VIEW view_mail_missing_slides AS
  SELECT view_person.person_id,
         view_person.name,
         view_person.email,
         event.event_id,
         event.title AS event_title,
         event.subtitle AS event_subtitle,
         conference.conference_id,
         conference.acronym AS conference_acronym,
         conference.title AS conference_title
    FROM event_person
         INNER JOIN view_person ON (
             view_person.person_id = event_person.person_id AND
             view_person.email IS NOT NULL )
         INNER JOIN event ON (
             event.event_id = event_person.event_id AND
             event.slides = 't' )
         INNER JOIN conference ON (
             conference.conference_id = event.conference_id )
  WHERE NOT EXISTS (SELECT 1
                      FROM event_attachment
                     WHERE event_attachment.event_id = event.event_id AND
                           event_attachment.attachment_type = 'slides' ) AND
        event.event_state = 'accepted' AND
        event.event_state_progress = 'confirmed' AND
        event_person.event_role IN ('speaker','moderator') AND
        event_person.event_role_state = 'confirmed'
ORDER BY view_person.person_id, event.event_id
;

