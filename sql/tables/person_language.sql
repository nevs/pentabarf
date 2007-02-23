
CREATE TABLE person_language (
  person_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  rank INTEGER,
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (person_id, language_id)
) WITHOUT OIDS;

