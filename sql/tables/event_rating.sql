
CREATE TABLE base.event_rating (
  person_id INTEGER NOT NULL,
  event_id INTEGER NOT NULL,
  event_rating_category_id INTEGER NOT NULL,
  rating SMALLINT CHECK( rating > 0 AND rating < 6 ) NOT NULL,
  eval_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

CREATE TABLE event_rating (
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (event_rating_category_id) REFERENCES event_rating_category(event_rating_category_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (person_id, event_id, event_rating_category_id)
) INHERITS( base.event_rating );

CREATE TABLE log.event_rating (
) INHERITS( base.logging, base.event_rating );

CREATE INDEX log.event_rating_event_id_idx ON log.event_rating( event_id );
CREATE INDEX log.event_rating_log_transaction_id_idx ON log.event_rating( log_transaction_id );

