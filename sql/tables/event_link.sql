
CREATE TABLE base.event_link (
  event_link_id SERIAL NOT NULL,
  event_id INTEGER NOT NULL,
  url TEXT NOT NULL,
  title TEXT,
  rank INTEGER
);

CREATE TABLE event_link (
  FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_link_id)
) INHERITS( base.event_link );

CREATE TABLE log.event_link (
) INHERITS( base.logging, base.event_link );

CREATE INDEX log_event_link_event_link_id_idx ON log.event_link( event_link_id );
CREATE INDEX log_event_link_log_transaction_id_idx ON log.event_link( log_transaction_id );

