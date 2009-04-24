
CREATE TABLE base.event_state (
  event_state TEXT,
  rank INTEGER
);

CREATE TABLE event_state (
  PRIMARY KEY (event_state)
) INHERITS( base.event_state );

CREATE TABLE log.event_state (
) INHERITS( base.logging, base.event_state );

CREATE INDEX log.event_state_event_state_idx ON log.event_state( event_state );
CREATE INDEX log.event_state_log_transaction_id_idx ON log.event_state( log_transaction_id );

