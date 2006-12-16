
CREATE TABLE master.currency_localized(
  currency TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE public.currency_localized(
  PRIMARY KEY(currency,translated),
  FOREIGN KEY(currency) REFERENCES currency(currency) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY(translated) REFERENCES language(language) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS(master.currency_localized);

CREATE TABLE logging.currency_localized() INHERITS(master.logging, master.currency_localized);

