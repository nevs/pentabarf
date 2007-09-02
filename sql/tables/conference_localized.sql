
CREATE TABLE conference_localized (
  conference_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  description TEXT NOT NULL,
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_id, language_id)
) WITHOUT OIDS;

