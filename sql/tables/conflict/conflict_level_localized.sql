
CREATE TABLE conflict.conflict_level_localized (
  conflict_level TEXT NOT NULL,
  language_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  FOREIGN KEY (conflict_level) REFERENCES conflict.conflict_level (conflict_level) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conflict_level, language_id)
);

