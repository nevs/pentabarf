
CREATE TABLE master.conference_track(
  conference_id INTEGER,
  conference_track TEXT
) WITHOUT OIDS;

CREATE TABLE conference_track() INHERITS(master.conference_track);
CREATE TABLE logging.conference_track() INHERITS(master.conference_track);

