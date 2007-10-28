
-- returns all conclicts related to persons
CREATE OR REPLACE FUNCTION conflict_person(integer) RETURNS SETOF conflict_person_conflict AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_conflict_person RECORD;
    cur_conflict RECORD;

  BEGIN

    FOR cur_conflict IN
      SELECT conflict.conflict_id,
             conflict.conflict_type_id,
             conflict.tag
        FROM conflict
             INNER JOIN conflict_type USING (conflict_type_id)
             INNER JOIN conference_phase_conflict USING (conflict_id)
             INNER JOIN conference USING (conference_phase)
             INNER JOIN conflict_level USING (conflict_level_id)
       WHERE conflict_type.tag = 'person' AND
             conflict_level.tag <> 'silent' AND
             conference.conference_id = cur_conference_id
    LOOP
      FOR cur_conflict_person IN
        EXECUTE 'SELECT conflict_id, person_id FROM conflict_' || cur_conflict.tag || '(' || cur_conference_id || '), ( SELECT ' || cur_conflict.conflict_id || ' AS conflict_id) AS conflict_id; '
      LOOP
        RETURN NEXT cur_conflict_person;
      END LOOP;
    END LOOP;

    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

