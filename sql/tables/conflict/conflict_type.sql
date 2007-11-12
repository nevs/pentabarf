
CREATE TABLE base.conflict_type (
  conflict_type TEXT
);

CREATE TABLE conflict.conflict_type (
  PRIMARY KEY (conflict_type)
) INHERITS( base.conflict_type );

CREATE TABLE log.conflict_type (
) INHERITS( base.logging, base.conflict_type );

