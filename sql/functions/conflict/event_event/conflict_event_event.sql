
-- returns all conclicts related to events
CREATE OR REPLACE FUNCTION conflict.conflict_event_event(conference_id INTEGER) RETURNS SETOF conflict.conflict_event_event_conflict AS $$
  DECLARE
    cur_conflict_event_event RECORD;
    cur_conflict RECORD;

  BEGIN

    FOR cur_conflict IN
      SELECT conflict.conflict,
             conflict.conflict_type
        FROM conflict.conflict
             INNER JOIN conflict.conference_phase_conflict USING (conflict)
             INNER JOIN conflict.conference USING (conference_phase)
       WHERE conflict_type = 'event_event' AND
             conflict_level <> 'silent' AND
             conference.conference_id = conference_id
    LOOP
      FOR cur_conflict_event_event IN
        EXECUTE 'SELECT '|| quote_literal(cur_conflict.conflict) ||' AS conflict, event_id1, event_id2 FROM conflict.conflict_' || cur_conflict.conflict || '(' || conference_id || ');'
      LOOP
        RETURN NEXT cur_conflict_event_event;
      END LOOP;
    END LOOP;

    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

