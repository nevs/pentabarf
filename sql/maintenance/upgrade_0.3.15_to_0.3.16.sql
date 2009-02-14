
BEGIN;

CREATE SCHEMA release;

CREATE TABLE base.release (
  conference_release_id INTEGER
);

CREATE TABLE base.conference_release (
  conference_release_id SERIAL,
  conference_id INTEGER NOT NULL,
  conference_release TEXT NOT NULL
);

CREATE TABLE conference_release (
  FOREIGN KEY( conference_id ) REFERENCES conference( conference_id ) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY( conference_release_id ),
  UNIQUE( conference_id, conference_release )
) INHERITS( base.conference_release );

CREATE TABLE log.conference_release (
) INHERITS( base.logging, base.conference_release );

SELECT log.activate_logging();

-- release tables

CREATE TABLE release.conference (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,conference_id)
) INHERITS( base.release, base.conference );

CREATE TABLE release.conference_day (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,conference_day)
) INHERITS( base.release, base.conference_day );

CREATE TABLE release.conference_track (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,conference_track_id)
) INHERITS( base.release, base.conference_track );

CREATE TABLE release.conference_room (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,conference_room_id)
) INHERITS( base.release, base.conference_room );

CREATE TABLE release.conference_link (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,conference_link_id)
) INHERITS( base.release, base.conference_link );

CREATE TABLE release.conference_image (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,conference_id)
) INHERITS( base.release, base.conference_image );

CREATE TABLE release.event (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,event_id)
) INHERITS( base.release, base.event );

CREATE TABLE release.person (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,person_id)
) INHERITS( base.release, base.person );

CREATE TABLE release.conference_person (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,conference_person_id)
) INHERITS( base.release, base.conference_person );

COMMIT;

