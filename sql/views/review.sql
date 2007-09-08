
CREATE OR REPLACE VIEW view_review AS
  SELECT 
    event.event_id,
    event.conference_id,
    event.title,
    event.subtitle,
    event.event_state_id,
    event.event_state_progress_id,
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
     view_event_state.language_id AS translated_id,
     view_event_state.tag AS event_state_tag,
     view_event_state.name AS event_state,
     view_event_state_progress.tag AS event_state_progress_tag,
     view_event_state_progress.name AS event_state_progress,
     view_conference_track.tag AS conference_track_tag,
     view_conference_track.name AS conference_track
    FROM event
         INNER JOIN view_event_state USING (event_state_id)
         INNER JOIN view_event_state_progress ON (
           view_event_state.language_id = view_event_state_progress.language_id AND
           event.event_state_progress_id = view_event_state_progress.event_state_progress_id )
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
         LEFT OUTER JOIN view_conference_track ON (
           view_event_state.language_id = view_conference_track.language_id AND
           event.conference_track_id = view_conference_track.conference_track_id)
   ORDER BY acceptance DESC, relevance DESC, actuality DESC
;

