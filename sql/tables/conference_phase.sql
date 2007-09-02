
CREATE TABLE conference_phase (
  conference_phase_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  rank INTEGER,
  PRIMARY KEY (conference_phase_id)
) WITHOUT OIDS;

