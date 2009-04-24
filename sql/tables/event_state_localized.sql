
CREATE TABLE base.event_state_localized (
  event_state TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE event_state_localized (
  FOREIGN KEY (event_state) REFERENCES event_state (event_state) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_state, translated)
) INHERITS( base.event_state_localized );

CREATE TABLE log.event_state_localized (
) INHERITS( base.logging, base.event_state_localized );

CREATE INDEX log.event_state_localized_event_state_idx ON log.event_state_localized( event_state );
CREATE INDEX log.event_state_localized_log_transaction_id_idx ON log.event_state_localized( log_transaction_id );

