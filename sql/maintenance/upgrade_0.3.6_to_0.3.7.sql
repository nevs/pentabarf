
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

CREATE TABLE base.conference_day (
  conference_id INTEGER NOT NULL,
  conference_day DATE NOT NULL,
  name TEXT,
  public BOOL NOT NULL DEFAULT TRUE
);

CREATE TABLE conference_day (
  FOREIGN KEY( conference_id ) REFERENCES conference( conference_id )
  PRIMARY KEY( conference_id, conference_day)
) INHERITS( base.conference_day );

CREATE TABLE log.conference_day (
) INHERITS( base.logging, base.conference_day );

INSERT INTO auth.object_domain VALUES ('conference_day','conference');

SELECT log.activate_logging();

INSERT INTO conference_day(conference_id,conference_day,name,public) SELECT conference_id, start_date + generate_series(0,days), 'Day ' || generate_series(0,days) + 1,true  FROM conference ORDER BY 1,2;

ALTER TABLE event ADD CONSTRAINT event_conference_day_fkey FOREIGN KEY (conference_day,conference_id) REFERENCES conference_day(conference_day,conference_id);


COMMIT;

