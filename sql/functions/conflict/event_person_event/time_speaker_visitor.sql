
-- returns event_persons with conflicting events
CREATE OR REPLACE FUNCTION conflict_event_person_event_time_speaker_visitor(integer) RETURNS SETOF conflict_event_person_event AS '
  DECLARE 
    cur_conference_id ALIAS FOR $1;
    cur_speaker RECORD;
    cur_event RECORD;
    cur_conflict conflict_event_person_event%rowtype;
  BEGIN

-- Loop through all event_persons
    FOR cur_speaker IN
      SELECT person_id, 
             event_id, 
             conference_id, 
             day, 
             start_time, 
             duration,
             event_role.tag AS event_role_tag
        FROM event_person 
        INNER JOIN event_role USING (event_role_id)
        LEFT OUTER JOIN event_role_state USING (event_role_state_id)
        INNER JOIN event USING (event_id)
        INNER JOIN event_state USING (event_state_id)
        INNER JOIN event_state_progress USING (event_state_progress_id)
        WHERE (( event_role.tag IN (''speaker'', ''moderator'') AND
                 event_role_state.tag = ''confirmed'') OR
               ( event_role.tag = ''visitor'' )) AND
              event.conference_id = cur_conference_id AND
              event_state.tag = ''accepted'' AND
              event_state_progress.tag <> ''canceled'' AND
              event.day IS NOT NULL AND
              event.start_time IS NOT NULL
    LOOP

      -- loop through overlapping events
      FOR cur_event IN
        SELECT event_id 
          FROM event
          INNER JOIN event_state USING (event_state_id)
          INNER JOIN event_state_progress USING (event_state_progress_id)
          INNER JOIN event_person USING (event_id)
          INNER JOIN event_role USING (event_role_id)
          LEFT OUTER JOIN event_role_state USING (event_role_state_id)
          WHERE event.day IS NOT NULL AND
                event.start_time IS NOT NULL AND
                event.day = cur_speaker.day AND 
                event.event_id <> cur_speaker.event_id AND
                event.conference_id = cur_conference_id AND
                ( event.start_time::time, event.duration::interval ) OVERLAPS 
                ( cur_speaker.start_time::time, cur_speaker.duration::interval) AND
                event_state.tag = ''accepted'' AND
                event_state_progress.tag <> ''canceled'' AND
                (( cur_speaker.event_role_tag = ''visitor'' AND 
                   event_role.tag IN (''speaker'', ''moderator'') AND
                   event_role_state.tag = ''confirmed'') OR
                 ( cur_speaker.event_role_tag IN (''speaker'', ''moderator'') AND
                   event_role.tag = ''visitor'')) AND
                event_person.person_id = cur_speaker.person_id
  
      LOOP
        cur_conflict.person_id = cur_speaker.person_id;
        cur_conflict.event_id1 = cur_speaker.event_id;
        cur_conflict.event_id2 = cur_event.event_id;
        RETURN NEXT cur_conflict;
      END LOOP;
    END LOOP;
    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

