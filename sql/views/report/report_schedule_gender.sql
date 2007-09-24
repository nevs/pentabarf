
CREATE OR REPLACE VIEW view_report_schedule_gender AS
  SELECT DISTINCT ON (person_id, conference_id)
         person_id,
         conference_id,
         gender
    FROM event_person
         INNER JOIN person USING (person_id)
         INNER JOIN event USING (event_id)
         INNER JOIN event_role USING (event_role_id)
         INNER JOIN event_role_state USING (event_role_state_id)
   WHERE event.event_state = 'accepted' AND
         event_role.tag IN ('speaker','moderator') AND
         event_role_state.tag = 'confirmed'
;

