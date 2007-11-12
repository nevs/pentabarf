
CREATE TABLE base.event_attachment (
  event_attachment_id SERIAL NOT NULL,
  attachment_type TEXT NOT NULL,
  event_id INTEGER NOT NULL,
  mime_type TEXT NOT NULL,
  filename TEXT,
  title TEXT,
  pages INTEGER,
  data BYTEA NOT NULL,
  public BOOL NOT NULL DEFAULT TRUE,
  CHECK (strpos( filename, '/' ) = 0)
);

CREATE TABLE event_attachment (
  FOREIGN KEY (attachment_type) REFERENCES attachment_type (attachment_type) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (mime_type) REFERENCES mime_type (mime_type) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (event_attachment_id)
) INHERITS( base.event_attachment );

CREATE TABLE log.event_attachment (
) INHERITS( base.logging, base.event_attachment );

