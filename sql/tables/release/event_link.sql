
CREATE TABLE release.event_link (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,event_link_id)
) INHERITS( base.release, base.event_link );

