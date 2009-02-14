
CREATE TABLE release.person (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,person_id)
) INHERITS( base.release, base.person );

