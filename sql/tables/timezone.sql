
CREATE TABLE base.timezone (
  timezone TEXT NOT NULL,
  abbreviation TEXT NOT NULL,
  utc_offset INTERVAL NOT NULL
);

CREATE TABLE timezone (
  PRIMARY KEY( timezone )
) INHERITS( base.timezone );

CREATE TABLE log.timezone (
) INHERITS( base.logging, base.timezone );

