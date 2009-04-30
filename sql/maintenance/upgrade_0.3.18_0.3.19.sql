
BEGIN;

DELETE FROM auth.permission WHERE permission = 'move_event';

ALTER TABLE base.permission add column conference_permission BOOL NOT NULL DEFAULT FALSE;

COMMIT;

