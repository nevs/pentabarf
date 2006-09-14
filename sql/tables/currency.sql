
CREATE TABLE master.currency(
  currency TEXT NOT NULL,
  visible BOOL NOT NULL DEFAULT FALSE
);

CREATE TABLE currency(
  PRIMARY KEY(currency)
) INHERITS(master.currency);

CREATE TABLE logging.currency() INHERITS(master.logging, master.currency);

