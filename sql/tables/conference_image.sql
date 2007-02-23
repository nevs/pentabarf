
CREATE TABLE conference_image (
  conference_id INTEGER NOT NULL,
  mime_type_id INTEGER NOT NULL,
  image BYTEA NOT NULL,
  last_modified TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  last_modified_by INTEGER,
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (mime_type_id) REFERENCES mime_type (mime_type_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (last_modified_by) REFERENCES person(person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_id)
) WITHOUT OIDS;

