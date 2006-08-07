
CREATE TABLE master.mime_type(
  mime_type TEXT NOT NULL
) WITHOUT OIDS;

CREATE TABLE mime_type(
  PRIMARY KEY(mime_type)
) INHERITS(master.mime_type);

CREATE TABLE logging.mime_type() INHERITS(master.mime_type);

