
CREATE OR REPLACE VIEW view_report_slides AS
  SELECT 
    event_id,
    conference_id,
    title,
    subtitle,
    array_to_string(ARRAY(
      SELECT view_person.person_id
        FROM
          event_person
          INNER JOIN view_person USING (person_id)
        WHERE
          event_person.event_role IN ('speaker','moderator') AND
          event_person.event_role_state = 'confirmed' AND
          event_person.event_id = event.event_id
        ORDER BY view_person.name, event_person.person_id
      ), E'\n'::text) AS speaker_ids,
    array_to_string(ARRAY(
      SELECT view_person.name
        FROM
          event_person
          INNER JOIN view_person USING (person_id)
        WHERE
          event_person.event_role IN ('speaker','moderator') AND
          event_person.event_role_state = 'confirmed' AND
          event_person.event_id = event.event_id
        ORDER BY view_person.name, event_person.person_id
      ), E'\n'::text) AS speakers,
    slides,
    (SELECT count(event_attachment_id)
       FROM event_attachment
      WHERE event_id = event.event_id AND
            attachment_type = 'slides')
    AS slides_submitted
  FROM event
  WHERE event.event_state = 'accepted' AND
    event.event_state_progress = 'confirmed' AND
    event.slides = 't'
  ORDER BY lower(title), lower(subtitle)
;

