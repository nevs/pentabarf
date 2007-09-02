CREATE OR REPLACE VIEW view_schedule_simple AS
SELECT
  event.event_id,
  event.conference_id,
  event.title,
  event.subtitle,
  event.abstract,
  event.description,
  event."day",
  event.start_time,
  event.duration,
  room.room_id,
  room.short_name AS room,
  event.start_time + conference.day_change AS "time",
  conference.start_date + event."day"::integer + -1 + event.start_time + conference.day_change::interval AS start_date,
  conference.start_date + event."day"::integer + -1 + event.start_time + conference.day_change::interval + event.duration AS end_date,
  array_to_string(ARRAY(
    SELECT view_person.name
      FROM event_person
      INNER JOIN event_role ON (
        event_role.event_role_id = event_person.event_role_id AND
        (event_role.tag IN ('speaker','moderator') ) )
      INNER JOIN event_role_state ON (
        event_role_state.event_role_state_id = event_person.event_role_state_id AND 
        event_role_state.tag::text = 'confirmed' )
      INNER JOIN view_person USING (person_id)
      WHERE event_person.event_id = event.event_id), ', '::text) AS speakers
FROM event
  INNER JOIN event_state ON (
    event_state.event_state_id = event.event_state_id AND
    event_state.tag::text = 'accepted' )
  INNER JOIN event_state_progress ON (
    event_state_progress.event_state_progress_id = event.event_state_progress_id AND 
    event_state_progress.tag::text = 'confirmed' )
  INNER JOIN conference USING (conference_id)
  INNER JOIN room USING (room_id);
