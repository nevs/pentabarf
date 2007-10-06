
-- returns all conclicts related to events, persons and events
CREATE OR REPLACE FUNCTION conflict_event_person_event(integer) RETURNS SETOF conflict_event_person_event_conflict AS '
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_conflict_event_person_event RECORD;
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
       WHERE conflict_type.tag = ''event_person_event'' AND
             conflict_level.tag <> ''silent'' AND
             conference.conference_id = cur_conference_id
    LOOP
      FOR cur_conflict_event_person_event IN
        EXECUTE ''SELECT conflict_id, event_id1, event_id2, person_id FROM conflict_'' || cur_conflict.tag || ''('' || cur_conference_id || ''), ( SELECT '' || cur_conflict.conflict_id || '' AS conflict_id) AS conflict_id; ''
      LOOP
        RETURN NEXT cur_conflict_event_person_event;
      END LOOP;
    END LOOP;

    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

