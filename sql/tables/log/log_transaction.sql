
CREATE TABLE base.log_transaction (
  log_transaction_id SERIAL,
  log_timestamp TIMESTAMP DEFAULT now(),
  person_id INTEGER
);

CREATE TABLE log.log_transaction (
  FOREIGN KEY (person_id) REFERENCES person(person_id) ON UPDATE CASCADE ON DELETE SET NULL,
  PRIMARY KEY( log_transaction_id )
) INHERITS( base.log_transaction );

