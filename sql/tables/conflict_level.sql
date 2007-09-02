
CREATE TABLE conflict_level (
  conflict_level_id SERIAL NOT NULL,
  tag VARCHAR(64) NOT NULL UNIQUE,
  rank INTEGER,
  PRIMARY KEY (conflict_level_id)
) WITHOUT OIDS;

