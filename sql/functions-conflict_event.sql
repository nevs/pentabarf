/*
 *
 * Conflicts concerning one event
 *
*/

-- returns all events without speaker/moderator
CREATE OR REPLACE FUNCTION conflict_event_no_speaker(integer) RETURNS SETOF conflict_event AS '
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
-- Loop through all events
    FOR cur_event IN
      SELECT event_id FROM event INNER JOIN event_state USING (event_state_id)
        WHERE event.conference_id = cur_conference_id AND
              event_state.tag = ''confirmed'' AND
              event.f_public = TRUE 
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
        WHERE event.conference_id = cur_conference_id AND
              event_state.tag = ''confirmed''
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


-- returns all events with incomplete day/time/room
CREATE OR REPLACE FUNCTION conflict_event_incomplete(INTEGER) RETURNS SETOF conflict_event AS '
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
    FOR cur_event IN
      SELECT event_id FROM event INNER JOIN event_state USING (event_state_id)
        WHERE conference_id = cur_conference_id AND
              event_state.tag = ''confirmed'' AND
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


