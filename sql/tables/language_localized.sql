
CREATE TABLE master.language_localized(
  language TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE language_localized(
  PRIMARY KEY(language, translated),
  FOREIGN KEY(language) REFERENCES language(language) ON UPDATE CASCADE,
  FOREIGN KEY(translated) REFERENCES language(language) ON UPDATE CASCADE
) INHERITS(master.language_localized);

CREATE TABLE logging.language_localized() INHERITS(master.language_localized);

