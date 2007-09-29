
BEGIN;


ALTER TABLE event DROP COLUMN actual_start;
ALTER TABLE event DROP COLUMN actual_end;


COMMIT;

