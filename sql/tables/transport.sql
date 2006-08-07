
CREATE TABLE master.transport(
  transport TEXT
) WITHOUT OIDS;

CREATE TABLE transport() INHERITS(master.transport);
CREATE TABLE logging.transport() INHERITS(master.transport);

