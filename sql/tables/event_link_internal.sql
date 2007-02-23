
CREATE TABLE event_link_internal (
  event_link_internal_id SERIAL NOT NULL,
  event_id INTEGER NOT NULL,
  link_type_id INTEGER NOT NULL,
  url VARCHAR(1024) NOT NULL,
  description VARCHAR(256),
  rank INTEGER,
  FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (link_type_id) REFERENCES link_type (link_type_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_link_internal_id)
) WITHOUT OIDS;

