
CREATE TABLE master.country_localized(
  country TEXT,
  translated TEXT,
  name TEXT
) WITHOUT OIDS;

CREATE TABLE country_localized() INHERITS(master.country_localized);
CREATE TABLE logging.country_localized() INHERITS(master.country_localized);
