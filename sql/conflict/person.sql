-- returns all conflicts related to persons
CREATE OR REPLACE FUNCTION conflict.person( conference_id INTEGER ) RETURNS SETOF conflict.person_conflict AS $$
  DECLARE
    cur_conflict RECORD;
    cur_conflict_person conflict.person_conflict%ROWTYPE;
  BEGIN

    FOR cur_conflict IN
      SELECT * FROM pg_catalog.pg_proc
               INNER JOIN pg_catalog.pg_namespace ON (
                   pg_namespace.oid = pg_proc.pronamespace AND
                   pg_namespace.nspname = 'conflict' )
               INNER JOIN pg_catalog.pg_type ON (
                   pg_type.oid = pg_proc.prorettype AND
                   pg_type.typnamespace = pg_proc.pronamespace AND
                   pg_type.typname = 'person' )
    LOOP
      FOR cur_conflict_person IN
        EXECUTE 'SELECT ' || quote_literal( cur_conflict.proname ) || ' AS conflict, person_id FROM conflict.' || quote_ident( cur_conflict.proname ) || '(' || quote_literal( conference_id ) || ');'
      LOOP
        RETURN NEXT cur_conflict_person;
      END LOOP;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE plpgsql;

