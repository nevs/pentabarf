
CREATE TABLE event_link (
  event_link_id SERIAL NOT NULL,
  event_id INTEGER NOT NULL,
  url VARCHAR(1024) NOT NULL,
  title VARCHAR(256),
  rank INTEGER,
  last_modified TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  last_modified_by INTEGER,
  FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_link_id)
);

