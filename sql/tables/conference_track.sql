
CREATE TABLE conference_track (
  conference_track_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  tag VARCHAR(32) NOT NULL,
  rank INTEGER,
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_track_id),
  CHECK (tag NOT SIMILAR TO '%[\\\\/]%')
) WITHOUT OIDS;

