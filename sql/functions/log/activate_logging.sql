
-- this function creates a log function for each table found in the
-- log schema and registers those functions as trigger
CREATE OR REPLACE FUNCTION log.activate_logging() RETURNS VOID AS $$
  DECLARE
    logtable    RECORD;
    fundef      TEXT;
    trigdef     TEXT;
    trigname    TEXT;
    procname    TEXT;
    tablename   TEXT;
    tableschema TEXT;
  BEGIN
    FOR logtable IN
      SELECT table_name FROM information_schema.tables WHERE table_schema = 'log'
    LOOP
      tablename = logtable.table_name;
      SELECT INTO tableschema table_schema FROM information_schema.tables WHERE table_schema IN ('auth','public') AND table_name = tablename;
      RAISE NOTICE 'Creating log function for table %', tablename;
      -- (re)creating trigger function
      procname = tablename || '_log_function';
      fundef = $f$CREATE OR REPLACE FUNCTION log.$f$ || quote_ident( procname ) || $f$() RETURNS TRIGGER AS $i$
        BEGIN
          IF ( TG_OP = 'DELETE' ) THEN
            INSERT INTO log.$f$ || quote_ident( tablename ) || $f$ SELECT 'D', now(), current_setting('pentabarf.person_id')::int, OLD.*;
            RETURN OLD;
          ELSE
            INSERT INTO log.$f$ || quote_ident( tablename ) || $f$ SELECT substring( TG_OP, 1, 1 ), now(), current_setting('pentabarf.person_id')::int, NEW.*;
            RETURN NEW;
          END IF;
          RETURN NULL;
        END;
      $i$ LANGUAGE plpgsql;$f$;
      EXECUTE fundef;

      trigname = tablename || '_log_trigger';
      -- enable function as trigger if it is not yet enabled
      IF ( NOT EXISTS( SELECT 1 FROM information_schema.triggers WHERE trigger_name = trigname AND event_object_schema = tableschema AND event_object_table = tablename ) ) THEN
        RAISE NOTICE 'Creating trigger for table %', tablename;
        trigdef = $t$CREATE TRIGGER $t$ || quote_ident( trigname ) || $t$ AFTER INSERT OR UPDATE OR DELETE ON $t$ || quote_ident( tableschema ) || '.' || quote_ident( tablename ) || $t$ FOR EACH ROW EXECUTE PROCEDURE log.$t$ || quote_ident( procname ) || $t$();$t$;
        EXECUTE trigdef;
      END IF;
    END LOOP;

  END;
$$ LANGUAGE plpgsql;
