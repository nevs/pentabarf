
-- this function creates a log function as trigger for every table found in the logging schema

CREATE OR REPLACE FUNCTION logging.activate_logging() RETURNS VOID AS $$
  DECLARE
    logtable    RECORD;
    fundef      TEXT;
    trigdef     TEXT;
    trigname    TEXT;
    procname    TEXT;
    tablename   TEXT;
  BEGIN
    FOR logtable IN
      SELECT table_name FROM information_schema.tables WHERE table_schema = 'logging'
    LOOP
      tablename = logtable.table_name;
      RAISE NOTICE 'Creating log function for %', tablename;
      -- creating trigger function
      procname = tablename || '_log_function';
      fundef = $f$CREATE OR REPLACE FUNCTION logging.$f$ || quote_ident( procname ) || $f$() RETURNS TRIGGER AS $i$
        BEGIN
          IF ( TG_OP = 'DELETE' ) THEN
            INSERT INTO logging.$f$ || quote_ident( tablename ) || $f$ SELECT 'D', now(), OLD.*;
            RETURN OLD;
          ELSE
            INSERT INTO logging.$f$ || quote_ident( tablename ) || $f$ SELECT substring( TG_OP, 1, 1 ), now(), NEW.*;
            RETURN NEW;
          END IF;
          RETURN NULL;
        END;
      $i$ LANGUAGE plpgsql;$f$;
      EXECUTE fundef;

      trigname = tablename || '_log_trigger';
      PERFORM * FROM information_schema.triggers
        WHERE trigger_name = trigname AND
              event_object_schema = 'public' AND
              event_object_table = tablename;
      -- activating trigger function
      IF ( NOT FOUND ) THEN
        RAISE NOTICE 'Creating trigger for table %', tablename;
        trigdef = $t$CREATE TRIGGER $t$ || quote_ident( trigname ) || $t$ AFTER INSERT OR UPDATE OR DELETE ON public.$t$ || quote_ident( tablename ) || $t$ FOR EACH ROW EXECUTE PROCEDURE logging.$t$ || quote_ident( procname ) || $t$();$t$;
        EXECUTE trigdef;
      END IF;
    END LOOP;

  END;
$$ LANGUAGE plpgsql;
