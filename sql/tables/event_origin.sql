
CREATE TABLE base.event_origin (
  event_origin TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE event_origin (
  PRIMARY KEY (event_origin)
) INHERITS( base.event_origin );

CREATE TABLE log.event_origin (
) INHERITS( base.logging, base.event_origin );

CREATE INDEX log.event_origin_event_origin_idx ON log.event_origin( event_origin );
CREATE INDEX log.event_origin_log_transaction_id_idx ON log.event_origin( log_transaction_id );

