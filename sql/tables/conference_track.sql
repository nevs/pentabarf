
CREATE TABLE base.conference_track (
  conference_track TEXT NOT NULL,
  conference_id INTEGER NOT NULL,
  rank INTEGER,
  CHECK (strpos( conference_track, '/' ) = 0)
);

CREATE TABLE conference_track (
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_track,conference_id)
) INHERITS( base.conference_track );

CREATE TABLE log.conference_track (
) INHERITS( base.logging, base.conference_track );

