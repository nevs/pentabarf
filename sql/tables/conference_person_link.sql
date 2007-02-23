
CREATE TABLE conference_person_link (
  conference_person_link_id SERIAL NOT NULL,
  conference_person_id INTEGER NOT NULL,
  url TEXT NOT NULL,
  title VARCHAR(256),
  rank INTEGER,
  FOREIGN KEY (conference_person_id) REFERENCES conference_person (conference_person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_person_link_id)
) WITHOUT OIDS;

