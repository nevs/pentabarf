
-- trigger for ensuring that there are always pairs of linked events
CREATE OR REPLACE FUNCTION event_related_trigger_insert() RETURNS TRIGGER AS $$
   DECLARE
      cur_record RECORD;

   BEGIN

      FOR cur_record IN
         SELECT event_id1, event_id2 FROM event_related
            WHERE NOT EXISTS (SELECT event_id1, event_id2 FROM event_related AS related WHERE event_related.event_id1 = related.event_id2 AND event_related.event_id2 = related.event_id1)
      LOOP
        INSERT INTO event_related (event_id1, event_id2) VALUES (cur_record.event_id2, cur_record.event_id1);
      END LOOP;

      RETURN NEW;
   END;
$$ LANGUAGE 'plpgsql';


-- trigger for ensuring that there are always pairs of linked events
CREATE OR REPLACE FUNCTION event_related_trigger_delete() RETURNS TRIGGER AS $$
   DECLARE
      cur_record RECORD;

   BEGIN

      FOR cur_record IN
         SELECT event_id1, event_id2 FROM event_related
            WHERE NOT EXISTS (SELECT event_id1, event_id2 FROM event_related AS related WHERE event_related.event_id1 = related.event_id2 AND event_related.event_id2 = related.event_id1)
      LOOP
         DELETE FROM event_related WHERE event_id1 = cur_record.event_id1 AND event_id2 = cur_record.event_id2;
      END LOOP;
      RETURN NULL;
   END;
$$ LANGUAGE 'plpgsql';

-- trigger to copy all release relevant data when a new release is done
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

