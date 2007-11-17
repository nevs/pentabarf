
CREATE OR REPLACE VIEW view_event_rating AS
  SELECT
    event_rating.event_id,
    event_rating.person_id,
    event_rating.relevance,
    event_rating.actuality,
    event_rating.acceptance,
    event_rating.remark,
    event_rating.eval_time,
    view_person.name
  FROM
    event_rating
    INNER JOIN view_person USING (person_id)
  WHERE
    event_rating.relevance IS NOT NULL OR
    event_rating.actuality IS NOT NULL OR
    event_rating.acceptance IS NOT NULL OR
    event_rating.remark IS NOT NULL
  ORDER BY event_rating.eval_time DESC
;

