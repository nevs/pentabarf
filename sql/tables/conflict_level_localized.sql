
CREATE TABLE conflict_level_localized (
  conflict_level_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (conflict_level_id) REFERENCES conflict_level (conflict_level_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conflict_level_id, language_id)
);

