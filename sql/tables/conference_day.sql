
CREATE TABLE base.conference_day (
  conference_id INTEGER NOT NULL,
  conference_day DATE NOT NULL,
  name TEXT,
  public BOOL NOT NULL DEFAULT TRUE
);

CREATE TABLE conference_day (
  FOREIGN KEY( conference_id ) REFERENCES conference( conference_id )
) INHERITS( base.conference_day );

CREATE TABLE log.conference_day (
) INHERITS( base.logging, base.conference_day );

