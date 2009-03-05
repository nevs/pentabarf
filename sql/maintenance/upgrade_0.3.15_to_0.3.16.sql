
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

CREATE TABLE release.event_link (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,event_link_id)
) INHERITS( base.release, base.event_link );

CREATE TABLE release.event_person (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,event_person_id)
) INHERITS( base.release, base.event_person );

CREATE TABLE release.event_attachment (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,event_attachment_id)
) INHERITS( base.release, base.event_attachment );

CREATE TABLE release.event_image (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,event_id)
) INHERITS( base.release, base.event_image );

CREATE TABLE release.person (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,person_id)
) INHERITS( base.release, base.person );

CREATE TABLE release.person_image (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,person_id)
) INHERITS( base.release, base.person_image );

CREATE TABLE release.conference_person (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,conference_person_id)
) INHERITS( base.release, base.conference_person );

CREATE TABLE release.conference_person_link (
  FOREIGN KEY (conference_release_id) REFERENCES conference_release ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_release_id,conference_person_link_id)
) INHERITS( base.release, base.conference_person_link );

CREATE OR REPLACE FUNCTION conference_release_trigger_insert() RETURNS TRIGGER AS $$
   BEGIN
      -- conference tables
      INSERT INTO release.conference SELECT NEW.conference_release_id, conference.* FROM conference WHERE conference.conference_id = NEW.conference_id;
      INSERT INTO release.conference_image SELECT NEW.conference_release_id, conference_image.* FROM conference_image WHERE conference_image.conference_id = NEW.conference_id;
      INSERT INTO release.conference_link SELECT NEW.conference_release_id, conference_link.* FROM conference_link WHERE conference_link.conference_id = NEW.conference_id;
      INSERT INTO release.conference_room SELECT NEW.conference_release_id, conference_room.* FROM conference_room WHERE conference_room.conference_id = NEW.conference_id;
      INSERT INTO release.conference_track SELECT NEW.conference_release_id, conference_track.* FROM conference_track WHERE conference_track.conference_id = NEW.conference_id;
      INSERT INTO release.conference_day SELECT NEW.conference_release_id, conference_day.* FROM conference_day WHERE conference_day.conference_id = NEW.conference_id;
      -- event tables
      INSERT INTO release.event SELECT NEW.conference_release_id, event.* FROM event WHERE event.conference_id = NEW.conference_id;
      INSERT INTO release.event_attachment SELECT NEW.conference_release_id, event_attachment.* FROM event_attachment WHERE event_attachment.event_id IN (SELECT event_id FROM release.event WHERE event.conference_release_id = NEW.conference_release_id );
      INSERT INTO release.event_image SELECT NEW.conference_release_id, event_image.* FROM event_image WHERE event_image.event_id IN (SELECT event_id FROM release.event WHERE event.conference_release_id = NEW.conference_release_id );
      INSERT INTO release.event_link SELECT NEW.conference_release_id, event_link.* FROM event_link WHERE event_link.event_id IN (SELECT event_id FROM release.event WHERE event.conference_release_id = NEW.conference_release_id );
      INSERT INTO release.event_person SELECT NEW.conference_release_id, event_person.* FROM event_person WHERE event_person.event_id IN (SELECT event_id FROM release.event WHERE event.conference_release_id = NEW.conference_release_id );

      -- person tables
      INSERT INTO release.person SELECT NEW.conference_release_id, person.* FROM person WHERE person.person_id IN (SELECT person_id FROM release.event_person WHERE event_person.conference_release_id = NEW.conference_release_id );
      INSERT INTO release.conference_person SELECT NEW.conference_release_id, conference_person.* FROM conference_person WHERE person_id IN (SELECT person_id FROM release.person WHERE person.conference_release_id = NEW.conference_release_id) AND conference_person.conference_id = NEW.conference_id;
      INSERT INTO release.conference_person_link SELECT NEW.conference_release_id, conference_person_link.* FROM conference_person_link WHERE conference_person_id IN( SELECT conference_person_id FROM release.conference_person WHERE conference_person.conference_release_id = NEW.conference_release_id );
      INSERT INTO release.person_image SELECT NEW.conference_release_id, person_image.* FROM person_image WHERE person_id IN (SELECT person_id FROM release.person WHERE person.conference_release_id = NEW.conference_release_id);

      RETURN NEW;
   END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER conference_release_after_insert AFTER INSERT ON conference_release FOR EACH ROW EXECUTE PROCEDURE conference_release_trigger_insert();

ALTER TABLE base.event RENAME COLUMN tag TO slug;

SELECT log.activate_logging();

INSERT INTO auth.object_domain VALUES ('conflict_localized','localization');

COMMIT;

