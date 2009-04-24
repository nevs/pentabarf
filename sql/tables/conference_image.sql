
CREATE TABLE base.conference_image (
  conference_id INTEGER NOT NULL,
  mime_type TEXT NOT NULL,
  image BYTEA NOT NULL
);

CREATE TABLE conference_image (
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (mime_type) REFERENCES mime_type (mime_type) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (conference_id)
) INHERITS( base.conference_image );

CREATE TABLE log.conference_image (
) INHERITS( base.logging, base.conference_image );

CREATE INDEX log.conference_image_conference_id_idx ON log.conference_image( conference_id );
CREATE INDEX log.conference_image_log_transaction_id_idx ON log.conference_image( log_transaction_id );

