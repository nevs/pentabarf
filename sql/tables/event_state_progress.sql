
CREATE TABLE master.event_state_progress(
  event_state_progress TEXT NOT NULL
);

CREATE TABLE event_state_progress(
  PRIMARY KEY(event_state_progress)
) INHERITS(master.event_state_progress);

CREATE TABLE logging.event_state_progress() INHERITS(master.event_state_progress);

