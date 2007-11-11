
CREATE TABLE base.event_image (
  event_id INTEGER NOT NULL,
  mime_type TEXT NOT NULL,
  image BYTEA NOT NULL
);

CREATE TABLE event_image (
  FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (mime_type) REFERENCES mime_type (mime_type) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (event_id)
) INHERITS( base.event_image );

CREATE TABLE log.event_image (
) INHERITS( base.logging, base.event_image );

