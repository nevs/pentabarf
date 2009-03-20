CREATE OR REPLACE VIEW release.view_schedule_person AS
  SELECT
    person.conference_release_id,
    person.person_id,
    coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname) AS name,
    person.email,
    conference_person.conference_id,
    conference_person.conference_person_id,
    conference_person.abstract,
    conference_person.description
  FROM
    release.person
    INNER JOIN release.conference_person USING(conference_release_id,person_id)
  WHERE
    EXISTS (
      SELECT 1
      FROM
        release.event_person
        INNER JOIN release.view_schedule_event USING(conference_release_id,event_id)
      WHERE
        event_person.conference_release_id = person.conference_release_id AND
        event_person.person_id = person.person_id AND
        event_person.event_role IN ('speaker','moderator') AND
        event_person.event_role_state = 'confirmed'
    )
  ORDER BY coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname)
;
