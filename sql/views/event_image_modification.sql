
CREATE OR REPLACE VIEW view_event_image_modification AS
  SELECT
    event_image.event_id,
    coalesce(log_timestamp,now()) AS last_modified
  FROM
    event_image
    LEFT OUTER JOIN (
      SELECT
        event_image.event_id,
        log_timestamp
      FROM
        log.event_image
        INNER JOIN log.log_transaction USING(log_transaction_id)
    ) AS log USING(event_id)
;

