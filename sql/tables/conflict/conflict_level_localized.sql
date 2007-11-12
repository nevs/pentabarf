
CREATE TABLE base.conflict_level_localized (
  conflict_level TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE conflict.conflict_level_localized (
  FOREIGN KEY (conflict_level) REFERENCES conflict.conflict_level (conflict_level) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conflict_level, translated)
) INHERITS( base.conflict_level_localized );

CREATE TABLE log.conflict_level_localized (
) INHERITS( base.logging, base.conflict_level_localized );

