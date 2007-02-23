
CREATE TABLE conference_person (
  conference_person_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  person_id INTEGER NOT NULL,
  abstract TEXT,
  description TEXT,
  remark TEXT,
  email_public VARCHAR(64),
  f_reconfirmed BOOL NOT NULL DEFAULT FALSE,
  last_modified TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  last_modified_by INTEGER,
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (last_modified_by) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_person_id)
) WITHOUT OIDS;

CREATE INDEX conference_person_conference_id_index ON conference_person(conference_id);
CREATE INDEX conference_person_person_id_index ON conference_person(person_id);

