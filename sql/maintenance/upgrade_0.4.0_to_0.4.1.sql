
BEGIN;

INSERT INTO conference_role_permission (conference_role, permission) VALUES ('reviewer', 'review::modify');

ALTER TABLE event_role ADD COLUMN public BOOL NOT NULL DEFAULT false;
UPDATE event_role SET public = true WHERE event_role IN ('moderator','speaker');

SELECT log.activate_logging();

COMMIT;

