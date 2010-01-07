
CREATE OR REPLACE VIEW view_event_rating AS
  SELECT
    event_rating_remark.event_id,
    event_rating_remark.person_id,
    view_person.name,
    event_rating_remark.remark,
    event_rating_remark.eval_time
  FROM
    event_rating_remark
    INNER JOIN view_person USING (person_id)
  UNION SELECT
    event_rating.event_id,
    event_rating.person_id,
    view_person.name,
    NULL::text AS remark,
    max(event_rating.eval_time) AS eval_time
  FROM
    event_rating
    INNER JOIN view_person USING (person_id)
  WHERE
    NOT EXISTS( SELECT 1 FROM event_rating_remark WHERE event_rating_remark.event_id = event_rating.event_id AND
                event_rating_remark.person_id = event_rating.person_id )
  GROUP BY event_id,person_id,name
  ORDER BY eval_time DESC
;

