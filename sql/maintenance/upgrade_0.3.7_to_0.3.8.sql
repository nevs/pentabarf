
BEGIN;

ALTER TABLE conference_day DROP CONSTRAINT conference_day_conference_id_fkey;
ALTER TABLE conference_day ADD CONSTRAINT conference_day_conference_id_fkey FOREIGN KEY( conference_id ) REFERENCES conference( conference_id ) ON UPDATE CASCADE ON DELETE CASCADE;

INSERT INTO currency (currency, exchange_rate) VALUES ('VEF', NULL);

UPDATE ui_message SET ui_message = replace( ui_message, ':event_rating_public:', ':event_feedback:');

COMMIT;

