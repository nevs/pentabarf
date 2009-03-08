
CREATE OR REPLACE VIEW view_own_events_participant AS
SELECT
  event.event_id,
  event.conference_id,
  (event.start_time + conference.day_change)::interval AS start_time,
  event.conference_day,
  event.conference_room_id,
  conference_room.conference_room,
  event.event_state,
  event.event_state_progress,
  event_state_localized.translated,
  event_state_localized.name AS event_state_name,
  event_state_progress_localized.name AS event_state_progress_name,
  event.title,
  event.subtitle,
  event.duration,
  array_to_string(ARRAY(
    SELECT view_person.person_id
      FROM
        event_person
        INNER JOIN view_person USING (person_id)
      WHERE
        event_person.event_role IN ('speaker','moderator') AND
        event_person.event_role_state = 'confirmed' AND
        event_person.event_id = event.event_id
      ORDER BY view_person.name, event_person.person_id
    ), E'\n'::text) AS speaker_ids,
  array_to_string(ARRAY(
    SELECT view_person.name
      FROM
        event_person
        INNER JOIN view_person USING (person_id)
      WHERE
        event_person.event_role IN ('speaker','moderator') AND
        event_person.event_role_state = 'confirmed' AND
        event_person.event_id = event.event_id
      ORDER BY view_person.name, event_person.person_id
    ), E'\n'::text) AS speakers,
  event_role_localized.event_role,
  event_role_localized.name AS event_role_name,
  event_role_state_localized.event_role_state,
  event_role_state_localized.name AS event_role_state_name,
  event_person.person_id
FROM
  event
  INNER JOIN event_person USING (event_id)
  INNER JOIN conference USING (conference_id)
  INNER JOIN event_state_localized USING (event_state)
  INNER JOIN event_state_progress_localized USING (event_state,event_state_progress,translated)
  INNER JOIN event_role_localized USING (event_role,translated)
  INNER JOIN event_role_state_localized USING (event_role,event_role_state,translated)
  INNER JOIN event_role ON (
    event_role.event_role = event_person.event_role AND
    event_role.participant = TRUE )
  LEFT OUTER JOIN conference_room USING (conference_room_id)
;

