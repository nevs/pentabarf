
CREATE OR REPLACE VIEW view_report_schedule_coordinator AS
  SELECT count(person_id) AS count,
         person_id,
         conference_id,
         name
    FROM event_person
         INNER JOIN event ON (
           event.event_id = event_person.event_id AND
           event.event_state = 'accepted' )
         INNER JOIN view_person USING (person_id)
   WHERE event_person.event_role = 'coordinator'
   GROUP BY person_id, name, conference_id
   ORDER BY count(person_id) DESC
;

