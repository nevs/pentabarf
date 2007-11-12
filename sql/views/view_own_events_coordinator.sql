
CREATE OR REPLACE VIEW view_own_events_coordinator AS
SELECT
  event.event_id,
  event.conference_id,
  event.event_state,
  event.event_state_progress,
  event_state_localized.translated,
  event_state_localized.name AS event_state_name,
  event_state_progress_localized.name AS event_state_progress_name,
  event.title,
  event.subtitle,
  event_role_localized.event_role AS event_role,
  event_role_localized.name AS event_role_name,
  ''::text AS event_role_state,
  ''::text AS event_role_state_name,
  event_person.person_id
FROM
  event
  INNER JOIN event_person ON (
    event_person.event_id = event.event_id AND
    event_person.event_role = 'coordinator' )
  INNER JOIN conference USING (conference_id)
  INNER JOIN event_state_localized USING (event_state)
  INNER JOIN event_state_progress_localized USING (event_state,event_state_progress,translated)
  INNER JOIN event_role_localized USING (event_role,translated)
;

