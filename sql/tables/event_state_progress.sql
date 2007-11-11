
CREATE TABLE base.event_state_progress (
  event_state_progress TEXT NOT NULL,
  event_state TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE event_state_progress (
  FOREIGN KEY (event_state) REFERENCES event_state (event_state) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_state, event_state_progress)
) INHERITS( base.event_state_progress );

CREATE TABLE log.event_state_progress (
) INHERITS( base.logging, base.event_state_progress );

