
-- view for event_persons
CREATE OR REPLACE VIEW view_event_person AS
  SELECT event_person.event_person_id,
         event_person.event_id,
         event_person.person_id,
         event_person.event_role,
         event_person.event_role_state,
         event_person.remark,
         event_person.rank,
         event.title,
         event.subtitle,
         event.event_state,
         conference.conference_id,
         conference.acronym,
         view_person.name,
         event_role_localized.language_id AS translated_id,
         event_role_localized.name AS event_role_name,
         event_role_state_localized.name AS event_role_state_name
    FROM event_person
         INNER JOIN event USING (event_id)
         INNER JOIN conference USING (conference_id)
         INNER JOIN view_person USING (person_id)
         INNER JOIN event_role_localized USING (event_role)
         LEFT OUTER JOIN event_role_state_localized ON (
               event_person.event_role = event_role_state_localized.event_role AND
               event_person.event_role_state = event_role_state_localized.event_role_state AND
               event_role_localized.language_id = event_role_state_localized.language_id);

