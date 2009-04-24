
CREATE TABLE base.country (
  country TEXT NOT NULL
);

CREATE TABLE country (
  PRIMARY KEY( country )
) INHERITS( base.country );

CREATE TABLE log.country (
) INHERITS( base.logging, base.country );

CREATE INDEX log_country_country_idx ON log.country( country );
CREATE INDEX log_country_log_transaction_id_idx ON log.country( log_transaction_id );

