-- returns a list of all person that will appear in the schedule
CREATE OR REPLACE VIEW view_schedule_person AS
  SELECT
    person.person_id,
    coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname) AS name,
    conference_person.email,
    conference.conference_id,
    conference_person.conference_person_id,
    conference_person.abstract,
    conference_person.description
  FROM
    person
    CROSS JOIN conference
    LEFT OUTER JOIN conference_person USING(conference_id,person_id)
  WHERE
    EXISTS (
      SELECT 1
      FROM
        event_person
        INNER JOIN event_role ON (
          event_role.event_role = event_person.event_role AND
          event_role.public = true )
        INNER JOIN event ON (
          event.event_id = event_person.event_id AND
          event.public = TRUE AND
          event.event_state = 'accepted' AND
          event.event_state_progress = 'reconfirmed' )
        INNER JOIN view_schedule_day USING(conference_day_id)
        INNER JOIN view_schedule_room USING(conference_room_id)
      WHERE
        event_person.person_id = person.person_id AND
        event.conference_id = conference.conference_id AND
        event_person.event_role_state = 'confirmed'
    )
  ORDER BY coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname)
;
