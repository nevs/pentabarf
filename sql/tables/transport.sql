
CREATE TABLE base.transport (
  transport TEXT,
  rank INTEGER
);

CREATE TABLE transport (
  PRIMARY KEY (transport)
) INHERITS( base.transport );

CREATE TABLE log.transport (
) INHERITS( base.logging, base.transport );

