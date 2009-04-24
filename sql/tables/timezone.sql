
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

CREATE INDEX log.timezone_timezone_idx ON log.timezone( timezone );
CREATE INDEX log.timezone_log_transaction_id_idx ON log.timezone( log_transaction_id );

