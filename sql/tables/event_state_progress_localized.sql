
CREATE TABLE base.event_state_progress_localized (
  event_state TEXT NOT NULL,
  event_state_progress TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE event_state_progress_localized (
  FOREIGN KEY (event_state,event_state_progress) REFERENCES event_state_progress (event_state,event_state_progress) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_state, event_state_progress, translated)
) INHERITS( base.event_state_progress_localized );

CREATE TABLE log.event_state_progress_localized (
) INHERITS( base.logging, base.event_state_progress_localized );

CREATE INDEX log_event_state_progress_localized_event_state_event_state_progress_idx ON log.event_state_progress_localized( event_state, event_state_progress );
CREATE INDEX log_event_state_progress_localized_log_transaction_id_idx ON log.event_state_progress_localized( log_transaction_id );

