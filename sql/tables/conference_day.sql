
CREATE TABLE base.conference_day (
  conference_day_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  conference_day DATE NOT NULL,
  name TEXT,
  public BOOL NOT NULL DEFAULT TRUE
);

CREATE TABLE conference_day (
  FOREIGN KEY( conference_id ) REFERENCES conference( conference_id ) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY( conference_day_id )
) INHERITS( base.conference_day );

CREATE TABLE log.conference_day (
) INHERITS( base.logging, base.conference_day );

CREATE INDEX log_conference_day_conference_day_id_idx ON log.conference_day( conference_day_id );
CREATE INDEX log_conference_day_log_transaction_id_idx ON log.conference_day( log_transaction_id );

