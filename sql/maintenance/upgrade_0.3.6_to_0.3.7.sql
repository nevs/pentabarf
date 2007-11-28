
BEGIN;

  ALTER TABLE base.conference_person ADD COLUMN arrived BOOL NOT NULL DEFAULT FALSE;
  UPDATE conference_person SET arrived = ( SELECT arrived  FROM conference_person_travel WHERE conference_person_travel.conference_person_id = conference_person.conference_person_id);
  ALTER TABLE base.conference_person_travel DROP COLUMN arrived CASCADE;

ALTER TABLE event DROP CONSTRAINT event_conference_id_fkey;
ALTER TABLE event ADD CONSTRAINT event_conference_id_fkey FOREIGN KEY (conference_id) REFERENCES conference(conference_id) ON UPDATE CASCADE ON DELETE RESTRICT;

COMMIT;

