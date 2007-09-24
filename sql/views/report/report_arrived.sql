
CREATE OR REPLACE VIEW view_report_arrived AS
  SELECT view_person.person_id,
         view_person.name,
         person_travel.conference_id,
         person_travel.f_arrived
    FROM view_person
         INNER JOIN person_travel USING (person_id)
   WHERE EXISTS (SELECT 1
                   FROM event_person
                        INNER JOIN event ON (
                          event_person.event_id = event.event_id AND
                          event.event_state = 'accepted' AND
                          event.event_state_progress = 'confirmed' AND
                          event.conference_id = person_travel.conference_id)
                        INNER JOIN event_role ON (
                          event_person.event_role_id = event_role.event_role_id AND
                          event_role.tag IN ('speaker', 'moderator'))
                        INNER JOIN event_role_state ON (
                          event_role_state.event_role_state_id = event_person.event_role_state_id AND
                          event_role_state.tag = 'confirmed')
                  WHERE event_person.person_id = view_person.person_id)
   ORDER BY lower(name)
;

