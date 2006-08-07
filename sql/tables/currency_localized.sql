
CREATE TABLE master.currency_localized(
  currency TEXT,
  translated TEXT,
  name TEXT
) WITHOUT OIDS;

CREATE TABLE currency_localized() INHERITS(master.currency_localized);
CREATE TABLE logging.currency_localized() INHERITS(master.currency_localized);

