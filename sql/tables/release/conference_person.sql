
CREATE TABLE release.conference_person (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,conference_person_id)
) INHERITS( base.release, base.conference_person );

