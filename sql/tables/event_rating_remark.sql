
CREATE TABLE base.event_rating_remark (
  person_id INTEGER NOT NULL,
  event_id INTEGER NOT NULL,
  remark TEXT NOT NULL,
  eval_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

CREATE TABLE event_rating_remark (
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (person_id, event_id)
) INHERITS( base.event_rating_remark );

CREATE TABLE log.event_rating_remark (
) INHERITS( base.logging, base.event_rating_remark );

