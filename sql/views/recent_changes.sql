
CREATE OR REPLACE VIEW view_recent_changes AS
  SELECT 
    log_transaction_id,
    log_timestamp,
    person_id,
    name
  FROM log.log_transaction
    LEFT OUTER JOIN view_person USING(person_id)
  ORDER BY log_timestamp DESC
;

