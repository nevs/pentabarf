
CREATE OR REPLACE VIEW view_own_events_participant AS
SELECT
  event.event_id,
  event.conference_id,
  event.event_state,
  event.event_state_progress,
  event_state_localized.language_id AS translated_id,
  event_state_localized.name AS event_state_name,
  event_state_progress_localized.name AS event_state_progress_name,
  event.title,
  event.subtitle,
  event_role.tag AS event_role,
  event_role_localized.name AS event_role_name,
  event_role_state.tag AS event_role_state,
  event_role_state_localized.name AS event_role_state_name,
  event_person.person_id
FROM
  event
  INNER JOIN event_person USING (event_id)
  INNER JOIN event_role ON (
    event_role.event_role_id = event_person.event_role_id AND
    event_role.tag IN ('speaker','moderator'))
  INNER JOIN event_role_state USING (event_role_state_id)
  INNER JOIN conference USING (conference_id)
  INNER JOIN event_state_localized USING (event_state)
  INNER JOIN event_state_progress_localized ON (
    event_state_progress_localized.event_state = event.event_state AND
    event_state_progress_localized.event_state_progress = event.event_state_progress AND
    event_state_progress_localized.language_id = event_state_localized.language_id )
  INNER JOIN event_role_localized ON (
    event_role_localized.event_role_id = event_person.event_role_id AND
    event_role_localized.language_id = event_state_localized.language_id )
  INNER JOIN event_role_state_localized ON (
    event_role_state_localized.event_role_state_id = event_person.event_role_state_id AND
    event_role_state_localized.language_id = event_state_localized.language_id )
;
