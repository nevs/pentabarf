
CREATE TABLE release.event_person (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,event_person_id)
) INHERITS( base.release, base.event_person );

