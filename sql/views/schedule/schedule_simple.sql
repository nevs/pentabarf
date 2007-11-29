CREATE OR REPLACE VIEW view_schedule_simple AS
SELECT
  event.event_id,
  event.conference_id,
  event.title,
  event.subtitle,
  event.abstract,
  event.description,
  event.conference_day,
  event.start_time,
  event.duration,
  conference_room.conference_room,
  event.start_time + conference.day_change AS "time",
  event.conference_day + event.start_time + conference.day_change::interval AS start_date,
  event.conference_day + event.start_time + conference.day_change::interval + event.duration AS end_date,
  array_to_string(ARRAY(
    SELECT view_person.name
      FROM event_person
      INNER JOIN view_person USING (person_id)
      WHERE
        event_person.event_role IN ('speaker','moderator') AND
        event_person.event_role_state = 'confirmed' AND
        event_person.event_id = event.event_id), ', '::text) AS speakers
FROM event
  INNER JOIN conference USING (conference_id)
  INNER JOIN conference_room USING (conference_id,conference_room)
WHERE
  event.conference_day IS NOT NULL AND
  event.start_time IS NOT NULL AND
  event.conference_room IS NOT NULL AND
  event.event_state = 'accepted' AND
  event.event_state_progress = 'confirmed'
;
