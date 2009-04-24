
CREATE TABLE base.custom_person (
  person_id INTEGER NOT NULL
);

CREATE TABLE custom.custom_person (
  PRIMARY KEY( person_id ),
  FOREIGN KEY( person_id) REFERENCES person(person_id) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.custom_person );

CREATE TABLE log.custom_person (
) INHERITS( base.logging, base.custom_person );

CREATE INDEX log_custom_person_person_id_idx ON log.custom_person( person_id );
CREATE INDEX log_custom_person_log_transaction_id_idx ON log.custom_person( log_transaction_id );

