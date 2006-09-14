
CREATE TABLE master.event_state_progress(
  event_state TEXT NOT NULL,
  event_state_progress TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE event_state_progress(
  PRIMARY KEY(event_state, event_state_progress),
  FOREIGN KEY(event_state) REFERENCES event_state(event_state)
) INHERITS(master.event_state_progress);

CREATE TABLE logging.event_state_progress() INHERITS(master.logging, master.event_state_progress);

