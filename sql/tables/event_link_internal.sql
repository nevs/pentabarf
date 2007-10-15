
CREATE TABLE event_link_internal (
  event_link_internal_id SERIAL NOT NULL,
  event_id INTEGER NOT NULL,
  link_type TEXT NOT NULL,
  url TEXT NOT NULL,
  description TEXT,
  rank INTEGER,
  FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (link_type) REFERENCES link_type (link_type) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (event_link_internal_id)
);

