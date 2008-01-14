
BEGIN;


CREATE TABLE base.log_transaction_involved_tables (
  log_transaction_id INTEGER,
  table_name TEXT
);

CREATE TABLE log.log_transaction_involved_tables (
  FOREIGN KEY (log_transaction_id) REFERENCES log.log_transaction(log_transaction_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY( log_transaction_id, table_name )
) INHERITS( base.log_transaction_involved_tables );

CREATE OR REPLACE FUNCTION log.log_transaction_involved_tables_before_insert() RETURNS trigger AS $$
  BEGIN
    SELECT 1 FROM log.log_transaction_involved_tables WHERE log_transaction_id = NEW.log_transaction_id AND table_name = NEW.table_name;
    IF FOUND THEN
      RETURN NULL;
    ELSE
      RETURN NEW;
    END IF;
  END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_transaction_involved_tables_insert_trigger BEFORE INSERT ON log.log_transaction_involved_tables FOR EACH ROW EXECUTE PROCEDURE log.log_transaction_involved_tables_before_insert();


COMMIT;

