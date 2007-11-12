
CREATE TABLE base.conflict_level (
  conflict_level TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE conflict.conflict_level (
  PRIMARY KEY (conflict_level)
) INHERITS( base.conflict_level );

CREATE TABLE log.conflict_level (
) INHERITS( base.logging, base.conflict_level );

