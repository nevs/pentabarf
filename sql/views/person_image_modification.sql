
CREATE OR REPLACE VIEW view_person_image_modification AS
  SELECT
    person_image.person_id,
    coalesce(log_timestamp,now()) AS last_modified
  FROM
    person_image
    LEFT OUTER JOIN (
      SELECT
        person_image.person_id,
        log_timestamp
      FROM
        log.person_image
        INNER JOIN log.log_transaction USING(log_transaction_id)
    ) AS log USING(person_id)
;
