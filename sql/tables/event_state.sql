
CREATE TABLE event_state (
  event_state_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  rank INTEGER,
  PRIMARY KEY (event_state_id)
) WITHOUT OIDS;

