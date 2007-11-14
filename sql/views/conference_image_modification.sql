
CREATE OR REPLACE VIEW view_conference_image_modification AS
  SELECT
    conference_image.conference_id,
    coalesce(log_timestamp,now()) AS last_modified
  FROM
    conference_image
    LEFT OUTER JOIN (
      SELECT
        conference_image.conference_id,
        log_timestamp
      FROM
        log.conference_image
        INNER JOIN log.log_transaction USING(log_transaction_id)
    ) AS log USING(conference_id)
;
