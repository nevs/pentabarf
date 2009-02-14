
CREATE TABLE release.conference_track (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,conference_track_id)
) INHERITS( base.release, base.conference_track );

