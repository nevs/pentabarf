
BEGIN;

DROP TABLE log.ui_message;
DROP TRIGGER ui_message_log_trigger ON ui_message;
DELETE FROM log.log_transaction_involved_tables where table_name = 'ui_message';

CREATE INDEX account_person_id_index ON auth.account(person_id);

ALTER TABLE base.conference ADD COLUMN f_submission_writable BOOL NOT NULL DEFAULT FALSE;
UPDATE conference SET f_submission_writable = TRUE WHERE f_submission_enabled = TRUE;

SELECT log.activate_logging();

COMMIT;

