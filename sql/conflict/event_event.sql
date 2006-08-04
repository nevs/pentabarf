/*
 * Conflicts concerning two events
*/

CREATE OR REPLACE FUNCTION conflict.event_event( conference_id INTEGER ) RETURNS SETOF conflict.event_event_conflict AS $$
  DECLARE
    cur_conflict RECORD;
    cur_conflict_event_event conflict.event_event_conflict%ROWTYPE;
  BEGIN

    FOR cur_conflict IN
      SELECT * FROM pg_catalog.pg_proc
               INNER JOIN pg_catalog.pg_namespace ON (
                   pg_namespace.oid = pg_proc.pronamespace AND
                   pg_namespace.nspname = 'conflict' )
               INNER JOIN pg_catalog.pg_type ON (
                   pg_type.oid = pg_proc.prorettype AND
                   pg_type.typnamespace = pg_proc.pronamespace AND
                   pg_type.typname = 'event_event' )
    LOOP
      FOR cur_conflict_event_event IN
        EXECUTE 'SELECT ' || quote_literal( cur_conflict.proname ) || ' AS conflict, event_id1, event_id2 FROM conflict.' || quote_ident( cur_conflict.proname ) || '(' || quote_literal( conference_id ) || ');'
      LOOP
        RETURN NEXT cur_conflict_event_event;
      END LOOP;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION conflict.events_with_same_timeslot( conference_id INTEGER ) RETURNS SETOF conflict.event_event AS $$
  DECLARE
    cur_conflict RECORD;
  BEGIN
    FOR cur_conflict IN
      SELECT event_id AS event_id1, event_id AS event_id2 FROM event WHERE event.conference_id = conference_id
    LOOP
      RETURN NEXT cur_conflict;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE plpgsql;

