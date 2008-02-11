
CREATE OR REPLACE FUNCTION custom_field_trigger() RETURNS trigger AS $$
  BEGIN
    IF TG_OP = 'DELETE' THEN
      IF OLD.field_name !~* '^[a-z_0-9]+$' OR OLD.field_name IN ('conference_id','event_id','person_id','conference_person_id') THEN
        RAISE EXCEPTION 'Invalid field_name: %', OLD.field_name;
      END IF;

      -- delete column from custom_table if it's there
      PERFORM 1 FROM information_schema.columns WHERE table_name = 'custom_' || OLD.table_name AND table_schema = 'base' AND column_name = OLD.field_name;
      IF FOUND THEN
        EXECUTE 'ALTER TABLE base.' || quote_ident( 'custom_' || OLD.table_name ) || ' DROP COLUMN ' || quote_ident( OLD.field_name );
        IF OLD.field_type = 'valuelist' THEN
          EXECUTE 'DROP TABLE custom.' || quote_ident('custom_' || OLD.table_name || '_' || OLD.field_name || '_values');
        END IF;
      END IF;

--      PERFORM log.activate_logging();
      RETURN OLD;

    ELSIF TG_OP = 'INSERT' THEN

      IF NEW.field_name !~* '^[a-z_0-9]+$' OR NEW.field_name IN ('conference_id','event_id','person_id','conference_person_id') THEN
        RAISE EXCEPTION 'Invalid field_name: %', NEW.field_name; 
      END IF;

      PERFORM 1 FROM information_schema.columns WHERE table_name = 'custom_' || NEW.table_name AND table_schema = 'base' AND column_name = NEW.field_name;
      -- the fields seems to exist already
      IF FOUND THEN RETURN NEW; END IF;

      IF NEW.field_type IN ('text','boolean') THEN 
        EXECUTE 'ALTER TABLE base.' || quote_ident( 'custom_' || NEW.table_name ) || ' ADD COLUMN ' || quote_ident( NEW.field_name ) || ' ' || NEW.field_type;
      ELSIF NEW.field_type = 'valuelist' THEN
        EXECUTE 'CREATE TABLE custom.' || quote_ident('custom_' || NEW.table_name || '_' || NEW.field_name || '_values') || 
                '('||quote_ident(NEW.field_name)||' TEXT PRIMARY KEY)';
        EXECUTE 'ALTER TABLE base.' || quote_ident( 'custom_' || NEW.table_name ) || ' ADD COLUMN ' || quote_ident( NEW.field_name ) || ' TEXT';
        EXECUTE 'ALTER TABLE custom.' || quote_ident( 'custom_' || NEW.table_name ) || ' ADD CONSTRAINT '|| quote_ident(NEW.table_name||'_'||NEW.field_name||'_fk') ||' FOREIGN KEY(' || quote_ident( NEW.field_name ) || ') REFERENCES custom.' || quote_ident('custom_' || NEW.table_name || '_' || NEW.field_name || '_values') || '('||quote_ident(NEW.field_name)||')';
      ELSE
        RAISE EXCEPTION 'Invalid field_type: %', NEW.field_type;
      END IF;

--      PERFORM log.activate_logging();
      RETURN NEW;

    ELSIF TG_OP = 'UPDATE' THEN
      IF OLD.table_name <> NEW.table_name THEN RAISE EXCEPTION 'Changing table is not allowed.'; END IF;
      IF OLD.field_name <> NEW.field_name THEN RAISE EXCEPTION 'Changing field name is not allowed.'; END IF;
      IF OLD.field_type <> NEW.field_type THEN RAISE EXCEPTION 'Changing field type is not allowed.'; END IF;

      RETURN NEW;
    END IF;

  END;
$$ LANGUAGE plpgsql;

