
CREATE OR REPLACE VIEW view_event_search_persons AS
  SELECT
         view_person.person_id,
         view_person.name,
         event_person.event_id,
         event_role.tag
    FROM event_person
         INNER JOIN event_role ON (
             event_role.event_role_id = event_person.event_role_id AND
             event_role.tag IN ('speaker','moderator') )
         INNER JOIN view_person ON (
             view_person.person_id = event_person.person_id )
ORDER BY lower( view_person.name );

