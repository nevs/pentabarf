
BEGIN;

ALTER TABLE base.event ADD COLUMN tags TEXT;

ALTER TABLE base.person ADD COLUMN organisation TEXT;

COMMIT;

