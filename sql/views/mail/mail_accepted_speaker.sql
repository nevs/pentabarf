
-- returns all accepted speakers of accepted and confirmed events
CREATE OR REPLACE VIEW view_mail_accepted_speaker AS
  SELECT view_person.person_id,
         view_person.name,
         view_person.email_contact,
         event.event_id,
         event.title AS event_title,
         event.subtitle AS event_subtitle,
         conference.conference_id,
         conference.acronym AS conference_acronym,
         conference.title AS conference_title
    FROM event_person
         INNER JOIN view_person ON (
             view_person.person_id = event_person.person_id AND
             view_person.email_contact IS NOT NULL )
         INNER JOIN event_role ON (
             event_role.event_role_id = event_person.event_role_id AND
             event_role.tag IN ('speaker', 'moderator') )
         INNER JOIN event_role_state ON (
             event_role_state.event_role_state_id = event_person.event_role_state_id AND
             event_role_state.event_role_id = event_person.event_role_id AND
             event_role_state.tag = 'confirmed' )
         INNER JOIN event ON (
             event.event_id = event_person.event_id )
         INNER JOIN event_state ON (
             event_state.event_state_id = event.event_state_id AND
             event_state.tag = 'accepted' )
         INNER JOIN event_state_progress ON (
             event_state_progress.event_state_progress_id = event.event_state_progress_id AND
             event_state_progress.event_state_id = event.event_state_id AND
             event_state_progress.tag = 'confirmed' )
         INNER JOIN conference ON (
             conference.conference_id = event.conference_id )
ORDER BY view_person.person_id, event.event_id
;

