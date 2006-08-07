
CREATE TABLE master.mime_type(
  mime_type TEXT
) WITHOUT OIDS;

CREATE TABLE mime_type() INHERITS(master.mime_type);
CREATE TABLE logging.mime_type() INHERITS(master.mime_type);

