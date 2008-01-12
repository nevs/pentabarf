
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
    event.conference_track,
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
    coalesce( rating.relevance, 0 ) AS relevance,
    coalesce( rating.relevance_count, 0 ) AS relevance_count,
    coalesce( rating.actuality, 0 ) AS actuality,
    coalesce( rating.actuality_count, 0 ) AS actuality_count,
    coalesce( rating.acceptance, 0 ) AS acceptance,
    coalesce( rating.acceptance_count, 0 ) AS acceptance_count,
    coalesce( rating.raters, 0 ) AS raters,
    (2 * coalesce( rating.acceptance, 0 ) + coalesce( rating.relevance, 0 ) + coalesce( rating.actuality, 0 ))/4 AS rating
  FROM event
         LEFT OUTER JOIN event_state_localized USING (event_state)
         LEFT OUTER JOIN (
           SELECT event_id,
                  coalesce( sum((relevance - 3) * 50 )/ count(relevance), 0) AS relevance,
                  count(relevance) AS relevance_count,
                  coalesce( sum((actuality - 3) * 50 )/ count(actuality), 0) AS actuality,
                  count(actuality) AS actuality_count,
                  coalesce( sum((acceptance - 3) * 50 ) / count(acceptance), 0) AS acceptance,
                  count(acceptance) AS acceptance_count,
                  count( coalesce( relevance::text, actuality::text, acceptance::text, remark ) ) AS raters
             FROM event_rating
            GROUP BY event_id
         ) AS rating USING (event_id)
   ORDER BY acceptance DESC, relevance DESC, actuality DESC
;

