
CREATE TABLE base.logging (
  log_transaction_id BIGINT,
  log_operation   char(1),
  log_timestamp   TIMESTAMP NOT NULL,
  log_person_id   INTEGER
);

CREATE SEQUENCE log.log_transaction_id_seq;


