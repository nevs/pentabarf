
CREATE TABLE master.country_localized(
  country TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE public.country_localized(
  PRIMARY KEY(country,translated),
  FOREIGN KEY(country) REFERENCES country(country) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY(translated) REFERENCES language(language) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS(master.country_localized);

CREATE TABLE logging.country_localized() INHERITS(master.logging, master.country_localized);

