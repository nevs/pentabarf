
CREATE TABLE master.conference_track(
  conference_track_id INTEGER NOT NULL,
  conference_id INTEGER NOT NULL,
  conference_track TEXT NOT NULL
);

CREATE TABLE conference_track(
  PRIMARY KEY( conference_track_id ),
  FOREIGN KEY(conference_id) REFERENCES conference(conference_id) ON UPDATE CASCADE,
  UNIQUE( conference_id, conference_track)
) INHERITS(master.conference_track);

CREATE SEQUENCE conference_track_id_sequence;
ALTER TABLE conference_track ALTER COLUMN conference_track_id SET DEFAULT nextval('conference_track_id_sequence');

CREATE TABLE logging.conference_track() INHERITS(master.logging, master.conference_track);

