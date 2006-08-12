
CREATE TABLE master.event_state(
  event_state TEXT NOT NULL
);

CREATE TABLE event_state(
  PRIMARY KEY(event_state)
) INHERITS(master.event_state);

CREATE TABLE logging.event_state() INHERITS(master.event_state);

