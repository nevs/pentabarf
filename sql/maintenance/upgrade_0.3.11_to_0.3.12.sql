
BEGIN;

DROP TABLE log.ui_message;
DROP TRIGGER ui_message_log_trigger ON ui_message;
DELETE FROM log.log_transaction_involved_tables where table_name = 'ui_message';

CREATE INDEX account_person_id_index ON auth.account(person_id);

COMMIT;

