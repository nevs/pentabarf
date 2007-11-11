
CREATE TABLE base.event_type (
  event_type TEXT,
  rank INTEGER
);

CREATE TABLE event_type (
  PRIMARY KEY (event_type)
) INHERITS( base.event_type );

CREATE TABLE log.event_type (
) INHERITS( base.logging, base.event_type );

