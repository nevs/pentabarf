
CREATE TABLE event_transaction (
  event_transaction_id SERIAL,
  event_id INTEGER NOT NULL,
  changed_when TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  changed_by INTEGER NOT NULL,
  f_create BOOL NOT NULL DEFAULT FALSE,
  FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (changed_by) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_transaction_id)
) WITHOUT OIDS;

