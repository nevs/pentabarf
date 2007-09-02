
CREATE TABLE activation_string_reset_password (
  person_id INTEGER UNIQUE NOT NULL,
  activation_string CHAR(64) NOT NULL UNIQUE,
  password_reset TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  PRIMARY KEY (person_id),
  FOREIGN KEY (person_id) REFERENCES person (person_id)
) WITHOUT OIDS;

ALTER TABLE conference ADD COLUMN homepage TEXT;
ALTER TABLE conference_logging ADD COLUMN homepage TEXT;

ALTER TABLE conference ADD COLUMN abstract_length INTEGER;
ALTER TABLE conference_logging ADD COLUMN abstract_length INTEGER;

ALTER TABLE conference ADD COLUMN description_length INTEGER;
ALTER TABLE conference_logging ADD COLUMN description_length INTEGER;

