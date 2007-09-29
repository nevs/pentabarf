
CREATE TABLE event_attachment (
  event_attachment_id SERIAL NOT NULL,
  attachment_type_id INTEGER NOT NULL,
  event_id INTEGER NOT NULL,
  mime_type_id INTEGER NOT NULL,
  filename VARCHAR(256) CHECK (filename NOT LIKE '%/%'),
  title VARCHAR(256),
  pages INTEGER,
  data BYTEA NOT NULL,
  f_public BOOL NOT NULL DEFAULT TRUE,
  last_modified TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  last_modified_by INTEGER,
  FOREIGN KEY (attachment_type_id) REFERENCES attachment_type (attachment_type_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (mime_type_id) REFERENCES mime_type (mime_type_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (last_modified_by) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE SET NULL,
  PRIMARY KEY (event_attachment_id)
);

