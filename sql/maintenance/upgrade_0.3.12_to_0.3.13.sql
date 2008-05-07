
BEGIN;

ALTER TABLE base.event_role ADD COLUMN participant BOOL NOT NULL DEFAULT FALSE;
UPDATE event_role set participant = TRUE WHERE event_role IN ('speaker','visitor','reporter','attendee');

DROP TABLE log.person_availability;
SELECT log.activate_logging();

COMMIT;

