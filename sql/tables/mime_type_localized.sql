
CREATE TABLE master.mime_type_localized(
  mime_type TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
) WITHOUT OIDS;

CREATE TABLE mime_type_localized(
  PRIMARY KEY(mime_type, translated),
  FOREIGN KEY(mime_type) REFERENCES mime_type(mime_type),
  FOREIGN KEY(translated) REFERENCES language(language)
) INHERITS(master.mime_type_localized);

CREATE TABLE logging.mime_type_localized() INHERITS(master.mime_type_localized);

