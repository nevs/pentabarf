
CREATE TABLE person_transaction (
  person_transaction_id SERIAL,
  person_id INTEGER NOT NULL,
  changed_when TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  changed_by INTEGER NOT NULL,
  f_create BOOL NOT NULL DEFAULT FALSE,
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (changed_by) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (person_transaction_id)
);

