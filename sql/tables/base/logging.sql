
CREATE TABLE base.logging (
  log_transaction_id BIGINT,
  log_operation   char(1)
);

CREATE SEQUENCE log.log_transaction_id_seq;


