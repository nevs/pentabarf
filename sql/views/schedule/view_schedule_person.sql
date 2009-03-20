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
        INNER JOIN view_schedule_event USING(event_id)
      WHERE
        event_person.person_id = person.person_id AND
        event_person.event_role IN ('speaker','moderator') AND
        event_person.event_role_state = 'confirmed'
    )
  ORDER BY coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname)
;
