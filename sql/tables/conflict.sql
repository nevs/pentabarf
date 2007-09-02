
CREATE TABLE conflict (
  conflict_id SERIAL NOT NULL,
  conflict_type_id INTEGER NOT NULL,
  tag VARCHAR(64) CHECK (tag ~ '^[a-z_]+$'),
  FOREIGN KEY (conflict_type_id) REFERENCES conflict_type (conflict_type_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (conflict_id)
) WITHOUT OIDS;

