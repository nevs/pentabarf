
CREATE TABLE base.event_type (
  event_type TEXT,
  public_role_required BOOL NOT NULL DEFAULT false, -- this event type requires a public event_role for schedule inclusion
  rank INTEGER
);

CREATE TABLE event_type (
  PRIMARY KEY (event_type)
) INHERITS( base.event_type );

CREATE TABLE log.event_type (
) INHERITS( base.logging, base.event_type );

CREATE INDEX log_event_type_event_type_idx ON log.event_type( event_type );
CREATE INDEX log_event_type_log_transaction_id_idx ON log.event_type( log_transaction_id );

