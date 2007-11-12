
CREATE TABLE base.event_related (
  event_id1 INTEGER NOT NULL,
  event_id2 INTEGER NOT NULL,
  CHECK (event_id1 <> event_id2)
);

CREATE TABLE event_related (
  event_id1 INTEGER NOT NULL,
  event_id2 INTEGER NOT NULL,
  FOREIGN KEY (event_id1) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (event_id2) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_id1, event_id2)
) INHERITS( base.event_related );

CREATE TABLE log.event_related (
) INHERITS( base.logging, base.event_related );

