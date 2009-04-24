
CREATE TABLE base.event_rating_category (
  event_rating_category_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  event_rating_category TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE event_rating_category (
  FOREIGN KEY (conference_id) REFERENCES conference(conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_rating_category_id),
  UNIQUE (conference_id,event_rating_category)
) INHERITS( base.event_rating_category );

CREATE TABLE log.event_rating_category (
) INHERITS( base.logging, base.event_rating_category );

CREATE INDEX log_event_rating_category_event_rating_category_id_idx ON log.event_rating_category( event_rating_category_id );
CREATE INDEX log_event_rating_category_log_transaction_id_idx ON log.event_rating_category( log_transaction_id );

