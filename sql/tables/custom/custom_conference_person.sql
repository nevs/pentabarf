
CREATE TABLE base.custom_conference_person (
  conference_person_id INTEGER NOT NULL
);

CREATE TABLE custom.custom_conference_person (
  PRIMARY KEY( conference_person_id ),
  FOREIGN KEY( conference_person_id) REFERENCES conference_person(conference_person_id) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.custom_conference_person );

CREATE TABLE log.custom_conference_person (
) INHERITS( base.logging, base.custom_conference_person );

