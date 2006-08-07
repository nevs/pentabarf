
CREATE TABLE master.conference_image(
  conference_id TEXT,
  mime_type TEXT,
  image BYTEA
) WITHOUT OIDS;

-- this is the real event table
CREATE TABLE conference_image() INHERITS(master.conference_image);

CREATE TABLE logging.conference_image() INHERITS(master.conference_image);

