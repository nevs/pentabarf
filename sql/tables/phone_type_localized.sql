
CREATE TABLE master.phone_type_localized(
  phone_type TEXT,
  translated TEXT,
  name TEXT
) WITHOUT OIDS;

CREATE TABLE phone_type_localized() INHERITS(master.phone_type_localized);
CREATE TABLE logging.phone_type_localized() INHERITS(master.phone_type_localized);

