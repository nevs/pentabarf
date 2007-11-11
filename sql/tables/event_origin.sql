
CREATE TABLE base.event_origin (
  event_origin TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE event_origin (
  PRIMARY KEY (event_origin)
) INHERITS( base.event_origin );

CREATE TABLE log.event_origin (
) INHERITS( base.logging, base.event_origin );

