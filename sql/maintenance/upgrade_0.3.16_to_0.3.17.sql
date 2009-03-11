
BEGIN;

ALTER TABLE base.conference_day ADD COLUMN conference_day_id INTEGER;

CREATE SEQUENCE conference_day_conference_day_id_seq;
ALTER TABLE base.conference_day ALTER COLUMN conference_day_id SET DEFAULT nextval('conference_day_conference_day_id_seq');

UPDATE conference_day SET conference_day_id = nextval('conference_day_conference_day_id_seq');

UPDATE log.conference_day SET conference_day_id = coalesce( 
  (SELECT conference_day_id FROM conference_day AS main WHERE main.conference_id = conference_day.conference_id AND main.conference_day = conference_day.conference_day),
  (SELECT conference_day_id FROM log.conference_day AS log WHERE log.conference_id = conference_day.conference_id AND log.conference_day = conference_day.conference_day LIMIT 1),
  nextval('conference_day_conference_day_id_seq'));

ALTER TABLE base.conference_day ALTER COLUMN conference_day_id SET NOT NULL;

-- add conference_day_id to event
ALTER TABLE base.event ADD COLUMN conference_day_id INTEGER;
UPDATE event SET conference_day_id = (SELECT conference_day_id FROM conference_day WHERE conference_day.conference_day = event.conference_day AND conference_day.conference_id = event.conference_id) WHERE conference_day IS NOT NULL;
UPDATE log.event SET conference_day_id = (SELECT conference_day_id FROM log.conference_day WHERE conference_day.conference_day = event.conference_day AND conference_day.conference_id = event.conference_id LIMIT 1) WHERE conference_day IS NOT NULL;
ALTER TABLE base.event DROP COLUMN event.conference_day CASCADE;


ALTER TABLE conference_day DROP CONSTRAINT conference_day_pkey;
ALTER TABLE conference_day ADD CONSTRAINT conference_day_pkey PRIMARY KEY(conference_day_id);

ALTER TABLE event ADD CONSTRAINT event_conference_day_id_fkey FOREIGN KEY (conference_day_id) REFERENCES conference_day (conference_day_id) ON UPDATE CASCADE ON DELETE SET NULL;


INSERT INTO auth.object_domain VALUES ('conference_release','conference');


COMMIT;

