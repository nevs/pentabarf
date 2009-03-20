CREATE OR REPLACE VIEW view_schedule_event_person AS
  SELECT
    event_person.event_person_id,
    event_person.event_id,
    view_schedule_event.conference_id,
    view_schedule_event.title,
    view_schedule_event.subtitle,
    event_person.person_id,
    view_schedule_person.name,
    event_person.event_role,
    event_role_localized.name AS event_role_name,
    event_role_localized.translated,
    event_person.event_role_state
  FROM
    event_person
    INNER JOIN event_role_localized USING (event_role)
    INNER JOIN view_schedule_event USING (event_id,translated)
    INNER JOIN view_schedule_person USING (person_id,conference_id)
  WHERE
    event_person.event_role IN ('speaker','moderator') AND
    event_person.event_role_state = 'confirmed'
  ORDER BY title, subtitle, name
;
