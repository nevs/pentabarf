
CREATE TABLE authorisation (
  authorisation_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  rank INTEGER,
  PRIMARY KEY (authorisation_id)
) WITHOUT OIDS;

