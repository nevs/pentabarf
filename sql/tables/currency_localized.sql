
CREATE TABLE base.currency_localized (
  currency TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE currency_localized (
  FOREIGN KEY (currency) REFERENCES currency (currency) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (currency, translated)
) INHERITS( base.currency_localized );

CREATE TABLE log.currency_localized (
) INHERITS( base.logging, base.currency_localized );

