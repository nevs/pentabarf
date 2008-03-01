
BEGIN;

DROP TABLE log.ui_message;
DROP TRIGGER ui_message_log_trigger ON ui_message;
DELETE FROM log.log_transaction_involved_tables where table_name = 'ui_message';

CREATE INDEX account_person_id_index ON auth.account(person_id);

ALTER TABLE base.conference ADD COLUMN f_submission_writable BOOL NOT NULL DEFAULT FALSE;
UPDATE conference SET f_submission_writable = TRUE WHERE f_submission_enabled = TRUE;

ALTER TABLE base.person ADD CONSTRAINT person_email_check CHECK(email ~ E'^[\\w=_.+-]+@([\\w.+_-]+\.)+\\w{2,}$');
ALTER TABLE base.conference_person ADD CONSTRAINT conference_person_email_check CHECK(email ~ E'^[\\w=_.+-]+@([\\w.+_-]+\.)+\\w{2,}$');
ALTER TABLE base.account ADD CONSTRAINT account_email_check CHECK(email ~ E'^[\\w=_.+-]+@([\\w.+_-]+\.)+\\w{2,}$');

SELECT log.activate_logging();

COMMIT;

