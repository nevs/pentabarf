
CREATE TABLE event_state_progress (
  event_state_progress_id SERIAL NOT NULL,
  event_state TEXT NOT NULL,
  tag VARCHAR(32) NOT NULL,
  rank INTEGER,
  FOREIGN KEY (event_state) REFERENCES event_state (event_state) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_state_progress_id)
) WITHOUT OIDS;

