
CREATE TABLE base.event_link_internal (
  event_link_internal_id SERIAL NOT NULL,
  event_id INTEGER NOT NULL,
  link_type TEXT NOT NULL,
  url TEXT NOT NULL,
  description TEXT,
  rank INTEGER
);

CREATE TABLE event_link_internal (
  FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (link_type) REFERENCES link_type (link_type) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (event_link_internal_id)
) INHERITS( base.event_link_internal );

CREATE TABLE log.event_link_internal (
) INHERITS( base.logging, base.event_link_internal );

