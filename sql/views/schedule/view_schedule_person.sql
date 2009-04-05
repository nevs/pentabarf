CREATE OR REPLACE VIEW view_schedule_person AS
  SELECT
    person.person_id,
    coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname) AS name,
    person.email,
    conference_person.conference_id,
    conference_person.conference_person_id,
    conference_person.abstract,
    conference_person.description
  FROM
    person
    INNER JOIN conference_person USING(person_id)
  WHERE
    EXISTS (
      SELECT 1
      FROM
        event_person
        INNER JOIN event ON( event.public = TRUE AND event.event_state = 'accepted' AND event.event_state_progress = 'reconfirmed' )
        INNER JOIN view_schedule_day USING(conference_day_id)
        INNER JOIN view_schedule_room USING(conference_room_id)
      WHERE
        event_person.person_id = person.person_id AND
        event_person.event_role IN ('speaker','moderator') AND
        event_person.event_role_state = 'confirmed'
    )
  ORDER BY coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname)
;
