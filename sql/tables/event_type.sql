
CREATE TABLE event_type (
  event_type_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  rank INTEGER,
  PRIMARY KEY (event_type_id)
) WITHOUT OIDS;

