
BEGIN;

DELETE FROM log.conference_track;
ALTER TABLE base.conference_track ADD COLUMN conference_track_id SERIAL NOT NULL;
ALTER TABLE base.event ADD COLUMN conference_track_id INTEGER;

UPDATE event SET conference_track_id = ( SELECT conference_track_id FROM conference_track WHERE conference_track.conference_track = event.conference_track AND conference_track.conference_id = event.conference_id) WHERE conference_track IS NOT NULL;

ALTER TABLE public.event DROP CONSTRAINT event_conference_track_fkey;

ALTER TABLE public.conference_track DROP CONSTRAINT conference_track_pkey1;

ALTER TABLE public.conference_track ADD CONSTRAINT conference_track_pkey1 PRIMARY KEY( conference_track_id );
ALTER TABLE public.event ADD CONSTRAINT event_conference_track_id_fkey FOREIGN KEY (conference_track_id) REFERENCES conference_track (conference_track_id) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE base.event DROP COLUMN conference_track CASCADE;

SELECT log.activate_logging();

COMMIT;

