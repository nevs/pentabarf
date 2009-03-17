CREATE OR REPLACE VIEW release.view_schedule_event_person AS
  SELECT
    event_person.event_person_id,
    event_person.conference_release_id,
    event_person.event_id,
    view_schedule_event.title,
    view_schedule_event.subtitle,
    event_person.person_id,
    coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname) AS name,
    event_person.event_role,
    event_role_localized.name AS event_role_name,
    event_role_localized.translated,
    event_person.event_role_state
  FROM
    release.event_person
    INNER JOIN event_role_localized USING (event_role)
    INNER JOIN release.view_schedule_event USING (conference_release_id,event_id,translated)
    INNER JOIN release.person USING (conference_release_id,person_id)
  WHERE
    event_person.event_role IN ('speaker','moderator') AND
    event_person.event_role_state = 'confirmed';
;
