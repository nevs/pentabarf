
CREATE OR REPLACE VIEW view_event_related AS
  SELECT event_id1,
         event_id2 AS event_id,
         title,
         subtitle
    FROM event_related
         INNER JOIN event ON (event_related.event_id2 = event.event_id);

