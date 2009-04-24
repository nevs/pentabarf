
CREATE TABLE base.custom_conference_person (
  conference_id INTEGER NOT NULL,
  person_id INTEGER NOT NULL
);

CREATE TABLE custom.custom_conference_person (
  PRIMARY KEY( conference_id, person_id ),
  FOREIGN KEY( conference_id, person_id ) REFERENCES conference_person( conference_id, person_id ) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.custom_conference_person );

CREATE TABLE log.custom_conference_person (
) INHERITS( base.logging, base.custom_conference_person );

CREATE INDEX log_custom_conference_person_conference_id_person_id_idx ON log.custom_conference_person( conference_id, person_id );
CREATE INDEX log_custom_conference_person_log_transaction_id_idx ON log.custom_conference_person( log_transaction_id );

