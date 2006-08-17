
CREATE TABLE master.conference_image(
  conference_id INTEGER NOT NULL,
  mime_type TEXT NOT NULL,
  image BYTEA NOT NULL
);

-- this is the real event table
CREATE TABLE conference_image(
  PRIMARY KEY(conference_id),
  FOREIGN KEY(conference_id) REFERENCES conference(conference_id) ON UPDATE CASCADE,
  FOREIGN KEY(mime_type) REFERENCES mime_type(mime_type) ON UPDATE CASCADE
) INHERITS(master.conference_image);

CREATE TABLE logging.conference_image() INHERITS(master.conference_image);

