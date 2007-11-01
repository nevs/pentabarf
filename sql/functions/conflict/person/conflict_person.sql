
-- returns all conclicts related to persons
CREATE OR REPLACE FUNCTION conflict.conflict_person(conference_id INTEGER) RETURNS SETOF conflict.conflict_person_conflict AS $$
  DECLARE
    cur_conflict_person conflict.conflict_person_conflict%ROWTYPE;
    cur_conflict RECORD;

  BEGIN

    FOR cur_conflict IN
      SELECT conflict.conflict,
             conflict.conflict_type
        FROM conflict.conflict
             INNER JOIN conflict.conference_phase_conflict USING (conflict)
             INNER JOIN conference USING (conference_phase)
       WHERE conflict_type = 'person' AND
             conflict_level <> 'silent' AND
             conference.conference_id = conference_id
    LOOP
      FOR cur_conflict_person IN
        EXECUTE 'SELECT '|| quote_literal(cur_conflict.conflict) ||' AS conflict, person_id FROM conflict.conflict_' || cur_conflict.conflict || '(' || conference_id || ');'
      LOOP
        RETURN NEXT cur_conflict_person;
      END LOOP;
    END LOOP;

    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

