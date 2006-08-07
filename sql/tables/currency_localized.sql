
CREATE TABLE master.currency_localized(
  currency TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
) WITHOUT OIDS;

CREATE TABLE currency_localized(
  PRIMARY KEY(currency,translated),
  FOREIGN KEY(currency) REFERENCES currency(currency),
  FOREIGN KEY(translated) REFERENCES language(language)
) INHERITS(master.currency_localized);
CREATE TABLE logging.currency_localized() INHERITS(master.currency_localized);

