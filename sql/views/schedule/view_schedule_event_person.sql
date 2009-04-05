CREATE OR REPLACE VIEW view_schedule_event_person AS
  SELECT
    event_person.event_person_id,
    event_person.event_id,
    event.conference_id,
    event.title,
    event.subtitle,
    event_person.person_id,
    view_person.name,
    event_person.event_role,
    event_role_localized.name AS event_role_name,
    event_role_localized.translated,
    event_person.event_role_state
  FROM
    event_person
    INNER JOIN view_person USING (person_id)
    INNER JOIN event USING (event_id)
    INNER JOIN view_schedule_room USING (conference_id,conference_room_id)
    INNER JOIN view_schedule_day USING (conference_id,conference_day_id)
    INNER JOIN event_role_localized USING (event_role)
  WHERE
    event_person.event_role IN ('speaker','moderator') AND
    event_person.event_role_state = 'confirmed' AND
    event.event_state = 'accepted' AND
    event.event_state_progress = 'reconfirmed' AND
    event.start_time IS NOT NULL AND
    event.public = TRUE
  ORDER BY title, subtitle, name
;
