
CREATE TABLE event_state_progress (
  event_state_progress TEXT NOT NULL,
  event_state TEXT NOT NULL,
  rank INTEGER,
  FOREIGN KEY (event_state) REFERENCES event_state (event_state) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_state, event_state_progress)
) WITHOUT OIDS;

