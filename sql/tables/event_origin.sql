
CREATE TABLE event_origin (
  event_origin_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  rank INTEGER,
  PRIMARY KEY (event_origin_id)
) WITHOUT OIDS;

