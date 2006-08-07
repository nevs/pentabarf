
CREATE TABLE master.language_localized(
  language TEXT,
  translated TEXT,
  name     TEXT
) WITHOUT OIDS;

CREATE TABLE language_localized() INHERITS(master.language_localized);
CREATE TABLE logging.language_localized() INHERITS(master.language_localized);
