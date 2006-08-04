/*
 * Conflicts concerning two events
*/

CREATE OR REPLACE FUNCTION conflict.event_event( conference_id INTEGER ) RETURNS SETOF conflict.event_event_conflict AS $$
  DECLARE
    cur_conflict RECORD;
    cur_conflict_event_event RECORD;
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
        EXECUTE 'SELECT conflict_id, event_id1, event_id2 FROM ' || cur_conflict.proname || '(' || conference_id || ')'
      LOOP

      END LOOP;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE plpgsql;

-- returns all conflicts related to two events
CREATE OR REPLACE FUNCTION conflict.conflict_event_event(integer) RETURNS SETOF conflict.event_event_conflict AS '
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_conflict_event_event RECORD;
    cur_conflict RECORD;

  BEGIN

    FOR cur_conflict IN
      SELECT conflict.conflict_id,
             conflict.conflict_type_id,
             conflict.tag
        FROM conflict
             INNER JOIN conflict_type USING (conflict_type_id)
             INNER JOIN conference_phase_conflict USING (conflict_id)
             INNER JOIN conference USING (conference_phase_id)
             INNER JOIN conflict_level USING (conflict_level_id)
       WHERE conflict_type.tag = ''event_event'' AND
             conflict_level.tag <> ''silent'' AND
             conference.conference_id = cur_conference_id
    LOOP
      FOR cur_conflict_event_event IN
        EXECUTE ''SELECT conflict_id, event_id1, event_id2 FROM conflict_'' || cur_conflict.tag || ''('' || cur_conference_id || ''), ( SELECT '' || cur_conflict.conflict_id || '' AS conflict_id) AS conflict_id; ''
      LOOP
        RETURN NEXT cur_conflict_event_event;
      END LOOP;
    END LOOP;

    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

