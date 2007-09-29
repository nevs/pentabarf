
CREATE TABLE event_related (
  event_id1 INTEGER NOT NULL,
  event_id2 INTEGER NOT NULL,
  FOREIGN KEY (event_id1) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (event_id2) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  CHECK (event_id1 <> event_id2),
  PRIMARY KEY (event_id1, event_id2)
);

