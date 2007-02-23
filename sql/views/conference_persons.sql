
-- returns the list of persons for the conference_page
CREATE OR REPLACE VIEW view_conference_persons AS
  SELECT
         view_person.person_id,
         view_person.name,
         view_event_role.tag AS event_role_tag,
         view_event_role.name AS event_role,
         view_event_role.language_id AS translated_id,
         event.conference_id
    FROM view_person
         INNER JOIN event_person ON (
             event_person.person_id = view_person.person_id )
         INNER JOIN event ON (
             event.event_id = event_person.event_id )
         INNER JOIN view_event_role ON (
               view_event_role.event_role_id = event_person.event_role_id AND
               view_event_role.tag IN ('speaker', 'moderator', 'coordinator') )
ORDER BY lower( view_person.name ), view_event_role.tag;

