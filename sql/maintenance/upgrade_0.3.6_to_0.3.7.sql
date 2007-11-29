
BEGIN;

DROP FUNCTION auth.create_account(varchar,varchar,text,char,integer);

ALTER TABLE base.conference_person ADD COLUMN arrived BOOL NOT NULL DEFAULT FALSE;
UPDATE conference_person SET arrived = ( SELECT arrived  FROM conference_person_travel WHERE conference_person_travel.conference_person_id = conference_person.conference_person_id);
ALTER TABLE base.conference_person_travel DROP COLUMN arrived CASCADE;

ALTER TABLE event DROP CONSTRAINT event_conference_id_fkey;
ALTER TABLE event ADD CONSTRAINT event_conference_id_fkey FOREIGN KEY (conference_id) REFERENCES conference(conference_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE base.event ADD COLUMN conference_day DATE;
UPDATE event SET conference_day = ( SELECT start_date + event.day - 1 FROM conference WHERE conference.conference_id = event.conference_id ) WHERE day IS NOT NULL;
ALTER TABLE base.event DROP COLUMN day CASCADE;

CREATE INDEX event_conference_day_index ON event(conference_day);

ALTER TABLE base.conference ALTER COLUMN conference_phase SET DEFAULT 'chaos';


COMMIT;

