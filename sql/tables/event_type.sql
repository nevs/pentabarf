
CREATE TABLE base.event_type (
  event_type TEXT,
  rank INTEGER
);

CREATE TABLE event_type (
  PRIMARY KEY (event_type)
) INHERITS( base.event_type );

CREATE TABLE log.event_type (
) INHERITS( base.logging, base.event_type );

CREATE INDEX log_event_type_event_type_idx ON log.event_type( event_type );
CREATE INDEX log_event_type_log_transaction_id_idx ON log.event_type( log_transaction_id );

