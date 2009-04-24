
CREATE TABLE base.event_role_state_localized (
  event_role TEXT NOT NULL,
  event_role_state TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE event_role_state_localized (
  FOREIGN KEY (event_role,event_role_state) REFERENCES event_role_state (event_role,event_role_state) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_role, event_role_state, translated)
) INHERITS( base.event_role_state_localized );

CREATE TABLE log.event_role_state_localized (
) INHERITS( base.logging, base.event_role_state_localized );

CREATE INDEX log_event_role_state_localized_event_role_event_role_state_idx ON log.event_role_state_localized( event_role, event_role_state );
CREATE INDEX log_event_role_state_localized_log_transaction_id_idx ON log.event_role_state_localized( log_transaction_id );

