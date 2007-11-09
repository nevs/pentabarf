
CREATE TABLE base.country (
  country TEXT NOT NULL
);

CREATE TABLE country (
  PRIMARY KEY( country )
) INHERITS( base.country );

CREATE TABLE log.country (
) INHERITS( base.logging, base.country );

