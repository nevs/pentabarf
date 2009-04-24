
CREATE TABLE base.conference_track (
  conference_track_id SERIAL NOT NULL,
  conference_track TEXT NOT NULL,
  conference_id INTEGER NOT NULL,
  rank INTEGER,
  CHECK (strpos( conference_track, '/' ) = 0)
);

CREATE TABLE conference_track (
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_track_id),
  UNIQUE( conference_id, conference_track )
) INHERITS( base.conference_track );

CREATE TABLE log.conference_track (
) INHERITS( base.logging, base.conference_track );

CREATE INDEX log.conference_track_conference_track_id_idx ON log.conference_track( conference_track_id );
CREATE INDEX log.conference_track_log_transaction_id_idx ON log.conference_track( log_transaction_id );

