
CREATE TABLE master.currency(
  currency TEXT
) WITHOUT OIDS;

CREATE TABLE currency() INHERITS(master.currency);
CREATE TABLE logging.currency() INHERITS(master.currency);

