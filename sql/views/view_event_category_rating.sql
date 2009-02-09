
CREATE OR REPLACE VIEW view_event_category_rating AS
  SELECT
    event_rating.event_id,
    event_rating.person_id,
    view_person.name,
    event_rating_category.event_rating_category_id,
    event_rating_category.event_rating_category,
    event_rating.rating,
    event_rating.eval_time
  FROM
    event_rating
    INNER JOIN event_rating_category USING (event_rating_category_id)
    INNER JOIN view_person USING (person_id)
  ORDER BY event_rating_category.rank, event_rating_category.event_rating_category
;

