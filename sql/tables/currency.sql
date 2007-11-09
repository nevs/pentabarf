
CREATE TABLE base.currency (
  currency TEXT NOT NULL,
  exchange_rate DECIMAL(15,5)
);

CREATE TABLE currency (
  PRIMARY KEY( currency )
) INHERITS( base.currency );

CREATE TABLE log.currency (
) INHERITS( base.logging, base.currency );

