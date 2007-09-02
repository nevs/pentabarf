
CREATE TABLE conference_person_link_internal (
  conference_person_link_internal_id SERIAL NOT NULL,
  conference_person_id INTEGER NOT NULL,
  link_type_id INTEGER NOT NULL,
  url TEXT NOT NULL,
  description VARCHAR(256),
  rank INTEGER,
  FOREIGN KEY (conference_person_id) REFERENCES conference_person (conference_person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (link_type_id) REFERENCES link_type (link_type_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (conference_person_link_internal_id)
) WITHOUT OIDS;

