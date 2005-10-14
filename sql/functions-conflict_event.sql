/*
 * Conflicts concerning one event
*/

-- returns all conclicts related to events
CREATE OR REPLACE FUNCTION conflict_event(integer) RETURNS SETOF conflict_event_conflict AS '
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_conflict_event RECORD;
    cur_conflict RECORD;

  BEGIN

    FOR cur_conflict IN
      SELECT conflict.conflict_id, 
             conflict.conflict_type_id, 
             conflict.tag 
        FROM conflict 
             INNER JOIN conflict_type USING (conflict_type_id)
       WHERE conflict_type.tag = ''event''
    LOOP
      FOR cur_conflict_event IN
        EXECUTE ''SELECT conflict_id, event_id FROM conflict_'' || cur_conflict.tag || ''('' || cur_conference_id || ''), ( SELECT '' || cur_conflict.conflict_id || '' AS conflict_id) AS conflict_id; ''
      LOOP
        RETURN NEXT cur_conflict_event;
      END LOOP;
    END LOOP;

    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

-- returns all confirmed events without confirmed speaker/moderator
CREATE OR REPLACE FUNCTION conflict_event_no_speaker(integer) RETURNS SETOF conflict_event AS '
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
-- Loop through all events
    FOR cur_event IN
      SELECT event_id 
        FROM event 
             INNER JOIN event_state USING (event_state_id)
             INNER JOIN event_state_progress USING (event_state_progress_id)
        WHERE event.conference_id = cur_conference_id AND
              event_state.tag = ''accepted'' AND
              event_state_progress.tag = ''confirmed''
    LOOP
      IF NOT EXISTS (SELECT 1 FROM event_person 
                              INNER JOIN event_role USING (event_role_id) 
                              INNER JOIN event_role_state USING (event_role_state_id) 
                       WHERE event_person.event_id = cur_event.event_id AND
                             event_role.tag IN (''speaker'', ''moderator'') AND
                             event_role_state.tag = ''confirmed'')
      THEN
        RETURN NEXT cur_event;
      END IF;
    END LOOP;
    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;


-- returns all events without coordinator
CREATE OR REPLACE FUNCTION conflict_event_no_coordinator(integer) RETURNS setof conflict_event AS '
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
    -- Loop through all events
    FOR cur_event IN
      SELECT event_id FROM event INNER JOIN event_state USING (event_state_id)
        WHERE event.conference_id = cur_conference_id
    LOOP
      IF NOT EXISTS (SELECT 1 FROM event_person 
                                   INNER JOIN event_role USING (event_role_id)
                       WHERE event_person.event_id = cur_event.event_id AND
                             event_role.tag = ''coordinator'')
      THEN
        RETURN NEXT cur_event;
      END IF;
    END LOOP;
    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

-- returns all accepted events with incomplete day/time/room
CREATE OR REPLACE FUNCTION conflict_event_incomplete(INTEGER) RETURNS SETOF conflict_event AS '
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
    FOR cur_event IN
      SELECT event_id 
        FROM event 
             INNER JOIN event_state USING (event_state_id)
             INNER JOIN event_state_progress USING (event_state_progress_id)
        WHERE conference_id = cur_conference_id AND
              event_state.tag = ''accepted'' AND
              event_state_progress.tag = ''confirmed'' AND
              (day IS NULL OR 
               room_id IS NULL OR 
               start_time IS NULL) AND
              (day IS NOT NULL OR 
               room_id IS NOT NULL OR 
               start_time IS NOT NULL)
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

