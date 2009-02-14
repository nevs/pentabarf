
CREATE TABLE base.conference_release (
  conference_release_id SERIAL,
  conference_id INTEGER NOT NULL,
  conference_release TEXT NOT NULL
);

CREATE TABLE conference_release (
  FOREIGN KEY( conference_id ) REFERENCES conference( conference_id ) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY( conference_release_id ),
  UNIQUE( conference_id, conference_release )
) INHERITS( base.conference_release );

CREATE TABLE log.conference_release (
) INHERITS( base.logging, base.conference_release );

