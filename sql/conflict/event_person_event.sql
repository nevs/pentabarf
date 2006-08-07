
-- returns all conflicts related to events, persons and events
CREATE OR REPLACE FUNCTION conflict.event_person_event( conference_id INTEGER ) RETURNS SETOF conflict.event_person_event_conflict AS $$
  DECLARE
    cur_conflict RECORD;
    cur_conflict_event_person_event conflict.event_person_event_conflict%ROWTYPE;
  BEGIN

    FOR cur_conflict IN
      SELECT * FROM pg_catalog.pg_proc
               INNER JOIN pg_catalog.pg_namespace ON (
                   pg_namespace.oid = pg_proc.pronamespace AND
                   pg_namespace.nspname = 'conflict' )
               INNER JOIN pg_catalog.pg_type ON (
                   pg_type.oid = pg_proc.prorettype AND
                   pg_type.typnamespace = pg_proc.pronamespace AND
                   pg_type.typname = 'event_person_event' )
    LOOP
      FOR cur_conflict_event_person_event IN
        EXECUTE 'SELECT ' || quote_literal( cur_conflict.proname ) || ' AS conflict, event_id1, event_id2, person_id FROM conflict.' || quote_ident( cur_conflict.proname ) || '(' || quote_literal( conference_id ) || ');'
      LOOP
        RETURN NEXT cur_conflict_event_person_event;
      END LOOP;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE plpgsql;

