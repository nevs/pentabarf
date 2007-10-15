
CREATE TABLE event_image (
  event_id INTEGER NOT NULL,
  mime_type TEXT NOT NULL,
  image BYTEA NOT NULL,
  last_modified TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  last_modified_by INTEGER,
  FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (mime_type) REFERENCES mime_type (mime_type) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (last_modified_by) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE SET NULL,
  PRIMARY KEY (event_id)
);

