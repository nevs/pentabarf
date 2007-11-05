
-- returns all accepted speakers of accepted and confirmed events
CREATE OR REPLACE VIEW view_mail_accepted_speaker AS
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
             event.event_id = event_person.event_id )
         INNER JOIN conference ON (
             conference.conference_id = event.conference_id )
    WHERE
        event.event_state = 'accepted' AND
        event.event_state_progress = 'confirmed' AND
        event_person.event_role IN ('speaker', 'moderator') AND
        event_person.event_role_state = 'confirmed'
ORDER BY view_person.person_id, event.event_id
;

