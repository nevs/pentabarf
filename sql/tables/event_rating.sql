
CREATE TABLE base.event_rating (
  person_id INTEGER NOT NULL,
  event_id INTEGER NOT NULL,
  relevance SMALLINT CHECK (relevance > 0 AND relevance < 6),
  actuality SMALLINT CHECK (actuality > 0 AND actuality < 6),
  acceptance SMALLINT CHECK (acceptance > 0 AND acceptance < 6),
  remark TEXT,
  eval_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

CREATE TABLE event_rating (
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (person_id, event_id)
) INHERITS( base.event_rating );

CREATE TABLE log.event_rating (
) INHERITS( base.logging, base.event_rating );

