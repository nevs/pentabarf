
CREATE TABLE base.event_role (
  event_role TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE event_role (
  PRIMARY KEY (event_role)
) INHERITS( base.event_role );

CREATE TABLE log.event_role (
) INHERITS( base.logging, base.event_role );

