
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
  submission_visible BOOL NOT NULL DEFAULT FALSE,
  submission_settable BOOL NOT NULL DEFAULT FALSE,
  CHECK( table_name IN ('conference_person','person','event','conference') ),
  CHECK( field_name ~* '^[a-z_0-9]+$' ),
  CHECK( field_type IN ('boolean','text') )
);
CREATE TABLE custom.custom_fields ( PRIMARY KEY( table_name, field_name )) INHERITS( base.custom_fields );
CREATE TABLE log.custom_fields () INHERITS( base.logging, base.custom_fields );

CREATE TABLE base.custom_conference (conference_id INTEGER NOT NULL);
CREATE TABLE custom.custom_conference (
  PRIMARY KEY( conference_id ),
  FOREIGN KEY( conference_id) REFERENCES conference(conference_id) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.custom_conference );
CREATE TABLE log.custom_conference () INHERITS( base.logging, base.custom_conference );

CREATE TABLE base.custom_event (event_id INTEGER NOT NULL);
CREATE TABLE custom.custom_event (
  PRIMARY KEY( event_id ),
  FOREIGN KEY( event_id) REFERENCES event(event_id) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.custom_event );
CREATE TABLE log.custom_event () INHERITS( base.logging, base.custom_event );

CREATE TABLE base.custom_person (person_id INTEGER NOT NULL);
CREATE TABLE custom.custom_person (
  PRIMARY KEY( person_id ),
  FOREIGN KEY( person_id) REFERENCES person(person_id) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.custom_person );
CREATE TABLE log.custom_person () INHERITS( base.logging, base.custom_person );

CREATE TABLE base.custom_conference_person (conference_person_id INTEGER NOT NULL);
CREATE TABLE custom.custom_conference_person (
  PRIMARY KEY( conference_person_id ),
  FOREIGN KEY( conference_person_id) REFERENCES conference_person(conference_person_id) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.custom_conference_person );
CREATE TABLE log.custom_conference_person () INHERITS( base.logging, base.custom_conference_person );

CREATE TABLE base.conference_room_role (
  conference_id INTEGER NOT NULL,
  event_role TEXT NOT NULL,
  conference_room TEXT NOT NULL,
  amount INTEGER NOT NULL DEFAULT 1
);
CREATE TABLE conference_room_role (
  FOREIGN KEY (conference_id, conference_room) REFERENCES conference_room (conference_id, conference_room) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (event_role) REFERENCES event_role (event_role) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_id, conference_room, event_role)
) INHERITS( base.conference_room_role );
CREATE TABLE log.conference_room_role () INHERITS( base.logging, base.conference_room_role );


INSERT INTO ui_message VALUES ('table::conference_person_travel::accommodation_currency');
INSERT INTO ui_message_localized VALUES ('table::conference_person_travel::accommodation_currency','en','Currency');
INSERT INTO ui_message VALUES ('table::conference_person_travel::fee_currency');
INSERT INTO ui_message_localized VALUES ('table::conference_person_travel::fee_currency','en','Currency');
INSERT INTO ui_message VALUES ('table::conference_person_travel::travel_currency');
INSERT INTO ui_message_localized VALUES ('table::conference_person_travel::travel_currency','en','Currency');
INSERT INTO ui_message VALUES ('table::event_feedback::remark');
INSERT INTO ui_message_localized VALUES ('table::event_feedback::remark','en','Comment');
INSERT INTO ui_message VALUES ('table::ui_message::ui_message');
INSERT INTO ui_message_localized VALUES ('table::ui_message::ui_message','en','UI message');
INSERT INTO ui_message VALUES ('table::ui_message_localized::ui_message');
INSERT INTO ui_message_localized VALUES ('table::ui_message_localized::ui_message','en','UI message');
INSERT INTO ui_message VALUES ('table::ui_message_localized::name');
INSERT INTO ui_message_localized VALUES ('table::ui_message_localized::name','en','Name');
INSERT INTO ui_message VALUES ('table::ui_message_localized::translated');
INSERT INTO ui_message_localized VALUES ('table::ui_message_localized::translated','en','Language');

INSERT INTO auth.domain VALUES ('custom');
INSERT INTO auth.permission VALUES ('modify_custom');
INSERT INTO auth.role_permission VALUES ('admin','modify_custom');
INSERT INTO auth.role_permission VALUES ('developer','modify_custom');
INSERT INTO auth.object_domain VALUES ('custom_fields','custom');
INSERT INTO auth.object_domain VALUES ('custom_conference','conference');
INSERT INTO auth.object_domain VALUES ('custom_event','event');
INSERT INTO auth.object_domain VALUES ('custom_conference_person','person');
INSERT INTO auth.object_domain VALUES ('custom_person','person');
INSERT INTO auth.object_domain VALUES ('ui_message','localization');
INSERT INTO auth.object_domain VALUES ('conference_room_role', 'conference');

CREATE OR REPLACE FUNCTION custom_field_trigger() RETURNS trigger AS $$
  BEGIN
    IF TG_OP = 'DELETE' THEN
      IF OLD.field_name !~* '^[a-z_0-9]+$' OR OLD.field_name = 'conference_person_id' THEN
        RAISE EXCEPTION 'Invalid field_name: %', OLD.field_name;
      END IF;
      PERFORM 1 FROM information_schema.columns WHERE table_name = 'custom_' || OLD.table_name AND table_schema = 'base' AND column_name = OLD.field_name;
      IF FOUND THEN
        EXECUTE 'ALTER TABLE base.' || quote_ident( 'custom_' || OLD.table_name ) || ' DROP COLUMN ' || quote_ident( OLD.field_name );
      END IF;
      RETURN OLD;
    ELSIF TG_OP = 'INSERT' THEN
      PERFORM 1 FROM information_schema.columns WHERE table_name = 'custom_' || NEW.table_name AND table_schema = 'base' AND column_name = NEW.field_name;
      IF FOUND THEN
        -- the fields seems to exist already
        RETURN NEW;
      END IF;
      IF NEW.field_name !~* '^[a-z_0-9]+$' THEN
        RAISE EXCEPTION 'Invalid field_name: %', NEW.field_name;
      END IF;
      IF NEW.field_type NOT IN ('text','boolean') THEN
        RAISE EXCEPTION 'Invalid field_type: %', NEW.field_type;
      END IF;
      EXECUTE 'ALTER TABLE base.' || quote_ident( 'custom_' || NEW.table_name ) || ' ADD COLUMN ' || quote_ident( NEW.field_name ) || ' ' || NEW.field_type;
    ELSIF TG_OP = 'UPDATE' THEN
      IF OLD.table_name <> NEW.table_name THEN RAISE EXCEPTION 'Changing table is not allowed.'; END IF;
      IF OLD.field_name <> NEW.field_name THEN RAISE EXCEPTION 'Changing field name is not allowed.'; END IF;
      IF OLD.field_type <> NEW.field_type THEN RAISE EXCEPTION 'Changing field type is not allowed.'; END IF;
    END IF;

    PERFORM log.activate_logging();
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER custom_fields_trigger BEFORE INSERT OR UPDATE OR DELETE ON custom.custom_fields FOR EACH ROW EXECUTE PROCEDURE custom_field_trigger();

ALTER TABLE base.conference_person ADD COLUMN reconfirmed BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE base.event ALTER public SET DEFAULT TRUE;

UPDATE ui_message SET ui_message = regexp_replace(ui_message,'^table::','') WHERE ui_message like 'table::%';

COMMIT;

