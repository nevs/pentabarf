
CREATE TABLE base.language_localized (
  language TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE language_localized (
  FOREIGN KEY( language ) REFERENCES language( language ) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( translated ) REFERENCES language( language ) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY ( language, translated )
) INHERITS( base.language_localized );

CREATE TABLE log.language_localized (
) INHERITS( base.logging, base.language_localized );

CREATE INDEX log_language_localized_language_idx ON log.language_localized( language );
CREATE INDEX log_language_localized_log_transaction_id_idx ON log.language_localized( log_transaction_id );

