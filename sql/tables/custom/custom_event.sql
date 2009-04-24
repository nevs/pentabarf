
CREATE TABLE base.custom_event (
  event_id INTEGER NOT NULL
);

CREATE TABLE custom.custom_event (
  PRIMARY KEY( event_id ),
  FOREIGN KEY( event_id) REFERENCES event(event_id) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.custom_event );

CREATE TABLE log.custom_event (
) INHERITS( base.logging, base.custom_event );

CREATE INDEX log_custom_event_event_id_idx ON log.custom_event( event_id );
CREATE INDEX log_custom_event_log_transaction_id_idx ON log.custom_event( log_transaction_id );

