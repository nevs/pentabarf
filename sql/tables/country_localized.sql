
CREATE TABLE base.country_localized (
  country TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE country_localized (
  FOREIGN KEY( country ) REFERENCES country( country ) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( translated ) REFERENCES language( language ) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY( country, translated )
) INHERITS( base.country_localized );

CREATE TABLE log.country_localized (
) INHERITS( base.logging, base.country_localized );

