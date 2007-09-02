
CREATE TABLE conflict_type (
  conflict_type_id SERIAL NOT NULL,
  tag VARCHAR(64) NOT NULL UNIQUE,
  PRIMARY KEY (conflict_type_id)
) WITHOUT OIDS;

