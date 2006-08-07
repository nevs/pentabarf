
CREATE TABLE master.country_localized(
  country TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
) WITHOUT OIDS;

CREATE TABLE country_localized(
  PRIMARY KEY(country,translated),
  FOREIGN KEY(country) REFERENCES country(country),
  FOREIGN KEY(translated) REFERENCES language(language)
) INHERITS(master.country_localized);

CREATE TABLE logging.country_localized() INHERITS(master.country_localized);

