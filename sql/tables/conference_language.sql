
CREATE TABLE conference_language (
  conference_language_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  rank INTEGER,
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (conference_id, language_id),
  PRIMARY KEY (conference_language_id)
) WITHOUT OIDS;

