
CREATE TABLE master.event_image(
  event_id INTEGER NOT NULL,
  mime_type TEXT NOT NULL,
  image BYTEA NOT NULL
);

-- this is the real event table
CREATE TABLE event_image(
  PRIMARY KEY(event_id),
  FOREIGN KEY(event_id) REFERENCES event(event_id) ON UPDATE CASCADE,
  FOREIGN KEY(mime_type) REFERENCES mime_type(mime_type) ON UPDATE CASCADE
) INHERITS(master.event_image);

CREATE TABLE logging.event_image() INHERITS(master.logging, master.event_image);

