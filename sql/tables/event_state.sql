
CREATE TABLE base.event_state (
  event_state TEXT,
  rank INTEGER
);

CREATE TABLE event_state (
  PRIMARY KEY (event_state)
) INHERITS( base.event_state );

CREATE TABLE log.event_state (
) INHERITS( base.logging, base.event_state );

