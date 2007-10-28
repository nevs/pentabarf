
CREATE TABLE conflict.conflict (
  conflict TEXT NOT NULL,
  conflict_type_id INTEGER NOT NULL,
  CHECK (conflict ~ '^[a-z_]+$'),
  FOREIGN KEY (conflict_type_id) REFERENCES conflict_type (conflict_type_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (conflict)
);

