
CREATE TABLE base.conference_language (
  conference_id INTEGER NOT NULL,
  language TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE conference_language (
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language) REFERENCES language (language) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (conference_id, language)
) INHERITS( base.conference_language );

CREATE TABLE log.conference_language (
) INHERITS( base.logging, base.conference_language );

CREATE INDEX log_conference_language_conference_id_idx ON log.conference_language( conference_id );
CREATE INDEX log_conference_language_log_transaction_id_idx ON log.conference_language( log_transaction_id );

