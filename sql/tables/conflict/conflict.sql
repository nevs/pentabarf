
CREATE TABLE base.conflict (
  conflict TEXT NOT NULL,
  conflict_type TEXT NOT NULL,
  CHECK (conflict ~ '^[a-z_]+$')
);

CREATE TABLE conflict.conflict (
  FOREIGN KEY (conflict_type) REFERENCES conflict.conflict_type (conflict_type) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (conflict)
) INHERITS( base.conflict );

CREATE TABLE log.conflict (
) INHERITS( base.logging, base.conflict );

