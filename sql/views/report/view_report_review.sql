
CREATE OR REPLACE VIEW view_report_review AS
  SELECT
    event.event_id,
    event.conference_id,
    event.title,
    event.subtitle,
    event.event_state,
    event_state_localized.name AS event_state_name,
    event_state_localized.translated,
    event.event_state_progress,
    event.conference_track_id,
    conference_track.conference_track,
    array_to_string(ARRAY(
      SELECT view_person.person_id
        FROM
          event_person
          INNER JOIN event_role ON (event_role.event_role = event_person.event_role AND event_role.public = TRUE)
          INNER JOIN view_person USING (person_id)
        WHERE
          event_person.event_id = event.event_id
        ORDER BY view_person.name, event_person.person_id
      ), E'\n'::text) AS speaker_ids,
    array_to_string(ARRAY(
      SELECT view_person.name
        FROM
          event_person
          INNER JOIN event_role ON (event_role.event_role = event_person.event_role AND event_role.public = TRUE)
          INNER JOIN view_person USING (person_id)
        WHERE
          event_person.event_id = event.event_id
        ORDER BY view_person.name, event_person.person_id
      ), E'\n'::text) AS speakers,
    coalesce( ( SELECT COUNT(person_id) FROM (SELECT person_id FROM event_rating WHERE event_id = event.event_id GROUP BY person_id) AS unique_rater ), 0 ) AS raters,
    ( SELECT coalesce( SUM( (rating - 3) * 50 ) / COUNT( rating ), 0 ) FROM event_rating WHERE event_id = event.event_id ) AS rating
  FROM
    event
    LEFT OUTER JOIN event_state_localized USING (event_state)
    LEFT OUTER JOIN conference_track USING (conference_track_id)
;

