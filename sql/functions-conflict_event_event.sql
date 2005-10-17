/*
 * Conflicts concerning two events
*/

-- returns all conclicts related to events
CREATE OR REPLACE FUNCTION conflict_event_event(integer) RETURNS SETOF conflict_event_event_conflict AS '
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

-- returns events with conflicting timeslots
CREATE OR REPLACE FUNCTION conflict_event_event_time(integer) RETURNS SETOF conflict_event_event AS '
  DECLARE 
    cur_conference_id ALIAS FOR $1;
    cur_event RECORD;
    cur_event2 RECORD;
    conflicting_event conflict_event_event%ROWTYPE;
  BEGIN
-- Loop through all events
    FOR cur_event IN
      SELECT event_id, start_time, duration, day, room_id FROM event INNER JOIN event_state USING (event_state_id) 
        WHERE event.conference_id = cur_conference_id AND
              event_state.tag = ''accepted'' AND
              event.day IS NOT NULL AND
              event.start_time IS NOT NULL
    LOOP
      FOR cur_event2 IN
        SELECT event_id FROM event INNER JOIN event_state USING (event_state_id) 
          WHERE event.day IS NOT NULL AND
                event.start_time IS NOT NULL AND
                event.day = cur_event.day AND 
                event_state.tag = ''accepted'' AND
                event.event_id <> cur_event.event_id AND
                event.conference_id = cur_conference_id AND
                event.room_id = cur_event.room_id AND
                (( event.start_time >= cur_event.start_time AND
                   event.start_time < cur_event.start_time + cur_event.duration ) OR
                 ( event.start_time + event.duration > cur_event.start_time AND
                   event.start_time + event.duration <= cur_event.start_time + cur_event.duration ))
      LOOP
        conflicting_event.event_id1 := cur_event.event_id;
        conflicting_event.event_id2 := cur_event2.event_id;
        RETURN NEXT conflicting_event;
      END LOOP;
    END LOOP;
    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

-- returns events with conflicting tags
CREATE OR REPLACE FUNCTION conflict_event_event_duplicate_tag(integer) RETURNS SETOF conflict_event_event AS '
  DECLARE 
    cur_conference_id ALIAS FOR $1;
    cur_event RECORD;
    cur_event2 RECORD;
    conflicting_event conflict_event_event%ROWTYPE;
  BEGIN
-- Loop through all events
    FOR cur_event IN
      SELECT event.event_id,
             event.tag
        FROM event
             INNER JOIN event_state USING (event_state_id)
       WHERE event.conference_id = cur_conference_id AND
             event_state.tag = ''accepted'' AND
             event.tag IS NOT NULL
    LOOP
      FOR cur_event2 IN
        SELECT event_id 
          FROM event 
               INNER JOIN event_state USING (event_state_id) 
         WHERE event.conference_id = cur_conference_id AND 
               event.event_id <> cur_event.event_id AND
               event_state.tag = ''accepted'' AND
               event.tag = cur_event.tag
      LOOP
        conflicting_event.event_id1 := cur_event.event_id;
        conflicting_event.event_id2 := cur_event2.event_id;
        RETURN NEXT conflicting_event;
      END LOOP;
    END LOOP;
    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

