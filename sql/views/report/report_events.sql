CREATE OR REPLACE VIEW view_report_events AS
SELECT
  event.conference_id,
  event.event_id,
  event.title,
  event.subtitle,
  array_to_string( ARRAY(
    SELECT view_person.name || '(' || event_person.event_role || ')'
      FROM event_person
           INNER JOIN view_person USING (person_id)
     WHERE event_person.event_id=event.event_id
    ), ', ' ) AS persons,
  event.resources,
  CASE event.slides WHEN TRUE THEN 'yes' WHEN FALSE THEN 'no' ELSE 'unknown' END AS slides

FROM event;

