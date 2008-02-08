
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
      RAISE EXCEPTION 'Not yet implemented';
    END IF;

    PERFORM log.activate_logging();
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

