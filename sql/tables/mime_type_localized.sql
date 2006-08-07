
CREATE TABLE master.mime_type_localized(
  mime_type TEXT,
  translated TEXT,
  name TEXT
) WITHOUT OIDS;

CREATE TABLE mime_type_localized() INHERITS(master.mime_type_localized);
CREATE TABLE logging.mime_type_localized() INHERITS(master.mime_type_localized);

