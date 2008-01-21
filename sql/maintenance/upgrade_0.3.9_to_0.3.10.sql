
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
    PERFORM 1 FROM log.log_transaction_involved_tables WHERE log_transaction_id = NEW.log_transaction_id AND table_name = NEW.table_name;
    IF FOUND THEN
      RETURN NULL;
    ELSE
      RETURN NEW;
    END IF;
  END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_transaction_involved_tables_insert_trigger BEFORE INSERT ON log.log_transaction_involved_tables FOR EACH ROW EXECUTE PROCEDURE log.log_transaction_involved_tables_before_insert();

CREATE SCHEMA custom;

CREATE TABLE base.custom_fields (
  table_name TEXT NOT NULL,
  field_name TEXT NOT NULL,
  field_type TEXT NOT NULL,
  not_null BOOLEAN NOT NULL DEFAULT 'f',
  CHECK( table_name IN ('conference_person') ),
  CHECK( field_name ~* '^[a-z_0-9]+$' ),
  CHECK( field_type IN ('boolean','text') )
);

CREATE TABLE custom.custom_fields (
  PRIMARY KEY( table_name, field_name )
) INHERITS( base.custom_fields );

CREATE TABLE log.custom_fields (
) INHERITS( base.logging, base.custom_fields );

CREATE TABLE base.custom_conference_person (
  conference_person_id INTEGER NOT NULL
);

CREATE TABLE custom.custom_conference_person (
  PRIMARY KEY( conference_person_id ),
  FOREIGN KEY( conference_person_id) REFERENCES conference_person(conference_person_id) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.custom_conference_person );

CREATE TABLE log.custom_conference_person (
) INHERITS( base.logging, base.custom_conference_person );


COMMIT;

