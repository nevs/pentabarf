
CREATE TABLE base.person_phone (
  person_phone_id SERIAL NOT NULL,
  person_id INTEGER NOT NULL,
  phone_type TEXT NOT NULL,
  phone_number TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE person_phone (
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (phone_type) REFERENCES phone_type (phone_type) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (person_phone_id)
) INHERITS( base.person_phone );

CREATE TABLE log.person_phone (
) INHERITS( base.logging, base.person_phone );

