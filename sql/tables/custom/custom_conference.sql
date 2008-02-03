
CREATE TABLE base.custom_conference (
  conference_id INTEGER NOT NULL
);

CREATE TABLE custom.custom_conference (
  PRIMARY KEY( conference_id ),
  FOREIGN KEY( conference_id) REFERENCES conference(conference_id) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.custom_conference );

CREATE TABLE log.custom_conference (
) INHERITS( base.logging, base.custom_conference );

