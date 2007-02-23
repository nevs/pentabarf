
CREATE OR REPLACE VIEW view_event_person_simple_person AS
  SELECT event_person.person_id,
         event_person.event_id,
         view_person.name,
         event_role.event_role_id,
         event_role.tag AS event_role_tag,
         event_role_state.event_role_state_id,
         event_role_state.tag AS event_role_state_tag
    FROM event_person
         INNER JOIN view_person USING (person_id)
         INNER JOIN event_role USING (event_role_id)
         INNER JOIN event_role_state USING (event_role_state_id);

