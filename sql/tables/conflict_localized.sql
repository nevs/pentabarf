
CREATE TABLE conflict_localized (
  conflict_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  FOREIGN KEY (conflict_id) REFERENCES conflict (conflict_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conflict_id, language_id)
) WITHOUT OIDS;

