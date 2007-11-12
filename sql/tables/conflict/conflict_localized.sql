
CREATE TABLE base.conflict_localized (
  conflict TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE conflict.conflict_localized (
  FOREIGN KEY (conflict) REFERENCES conflict.conflict (conflict) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conflict, translated)
) INHERITS( base.conflict_localized );

CREATE TABLE log.conflict_localized (
) INHERITS( base.logging, base.conflict_localized );

