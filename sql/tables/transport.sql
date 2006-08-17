
CREATE TABLE master.transport(
  transport TEXT NOT NULL
);

CREATE TABLE transport(
  PRIMARY KEY(transport)
) INHERITS(master.transport);

CREATE TABLE logging.transport() INHERITS(master.transport);

