
BEGIN;

ALTER TABLE conference_day DROP CONSTRAINT conference_day_conference_id_fkey;
ALTER TABLE conference_day ADD CONSTRAINT conference_day_conference_id_fkey FOREIGN KEY( conference_id ) REFERENCES conference( conference_id ) ON UPDATE CASCADE ON DELETE CASCADE;

COMMIT;

