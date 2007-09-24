
CREATE OR REPLACE VIEW view_review AS
  SELECT
    event.event_id,
    event.conference_id,
    event.title,
    event.subtitle,
    event.event_state,
    event.event_state_progress,
    array_to_string(ARRAY(
      SELECT view_person.name
        FROM event_person
        INNER JOIN event_role ON (
          event_role.event_role_id = event_person.event_role_id AND
          (event_role.tag IN ('speaker','moderator') ) )
        INNER JOIN event_role_state ON (
          event_role_state.event_role_state_id = event_person.event_role_state_id AND 
          event_role_state.tag::text = 'confirmed' )
        INNER JOIN view_person USING (person_id)
        WHERE event_person.event_id = event.event_id), ', '::text) AS speakers,
     coalesce( rating.relevance, 0 ) AS relevance,
     coalesce( rating.relevance_count, 0 ) AS relevance_count,
     coalesce( rating.actuality, 0 ) AS actuality,
     coalesce( rating.actuality_count, 0 ) AS actuality_count,
     coalesce( rating.acceptance, 0 ) AS acceptance,
     coalesce( rating.acceptance_count, 0 ) AS acceptance_count,
     coalesce( rating.raters, 0 ) AS raters,
     (2 * coalesce( rating.acceptance, 0 ) + coalesce( rating.relevance, 0 ) + coalesce( rating.actuality, 0 ))/4 AS rating,
     conference_track.tag AS conference_track
    FROM event
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
         LEFT OUTER JOIN conference_track ON (
           event.conference_track_id = conference_track.conference_track_id)
   ORDER BY acceptance DESC, relevance DESC, actuality DESC
;

