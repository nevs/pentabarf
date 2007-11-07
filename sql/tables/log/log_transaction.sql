
CREATE TABLE log.log_transaction(
  log_transaction_id SERIAL,
  log_timestamp TIMESTAMP DEFAULT now(),
  person_id INTEGER REFERENCES person(person_id) ON UPDATE CASCADE ON DELETE SET NULL,
  PRIMARY KEY( log_transaction_id )
);

