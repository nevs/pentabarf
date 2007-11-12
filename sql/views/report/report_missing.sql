
CREATE OR REPLACE VIEW view_report_missing AS
  SELECT view_person.person_id,
         view_person.name,
         conference_person.conference_id,
         conference_person_travel.arrived
    FROM view_person
         INNER JOIN conference_person USING (person_id)
         INNER JOIN conference_person_travel USING (conference_person_id)
   WHERE EXISTS (SELECT 1
                   FROM event_person
                        INNER JOIN event ON (
                          event_person.event_id = event.event_id AND
                          event.conference_id = conference_person.conference_id AND 
                          event.event_state = 'accepted' AND
                          event.event_state_progress = 'confirmed' )
                        INNER JOIN conference USING (conference_id)
                  WHERE event_person.person_id = view_person.person_id AND
                        event_person.event_role IN ('speaker','moderator') AND
                        event_person.event_role_state = 'confirmed' AND
                        conference.start_date + event.day + '-1 day'::INTERVAL + event.start_time + conference.day_change BETWEEN now() AND now() + '3 hour'::INTERVAL
                )
   ORDER BY lower(name)
;

