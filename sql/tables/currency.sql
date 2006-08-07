
CREATE TABLE master.currency(
  currency TEXT NOT NULL
) WITHOUT OIDS;

CREATE TABLE currency(
  PRIMARY KEY(currency)
) INHERITS(master.currency);

CREATE TABLE logging.currency() INHERITS(master.currency);

