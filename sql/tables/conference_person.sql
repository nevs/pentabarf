
CREATE TABLE base.conference_person (
  conference_person_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  person_id INTEGER NOT NULL,
  abstract TEXT,
  description TEXT,
  remark TEXT,
  email TEXT,
  arrived BOOL NOT NULL DEFAULT FALSE
);

CREATE TABLE conference_person (
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_person_id),
  UNIQUE( conference_id, person_id)
) INHERITS( base.conference_person );

CREATE TABLE log.conference_person (
) INHERITS( base.logging, base.conference_person );

