
CREATE TABLE master.phone_type_localized(
  phone_type TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
) WITHOUT OIDS;

CREATE TABLE phone_type_localized(
  PRIMARY KEY(phone_type, translated),
  FOREIGN KEY(phone_type) REFERENCES phone_type(phone_type),
  FOREIGN KEY(translated) REFERENCES language(language)
) INHERITS(master.phone_type_localized);

CREATE TABLE logging.phone_type_localized() INHERITS(master.phone_type_localized);

