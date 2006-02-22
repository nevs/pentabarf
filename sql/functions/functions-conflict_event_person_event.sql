
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

-- returns event_persons with conflicting events
CREATE OR REPLACE FUNCTION conflict_event_person_event_time_speaker_speaker(integer) RETURNS SETOF conflict_event_person_event AS '
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
             duration 
        FROM event_person 
        INNER JOIN event_role USING (event_role_id)
        INNER JOIN event_role_state USING (event_role_state_id)
        INNER JOIN event USING (event_id)
        INNER JOIN event_state USING (event_state_id)
        WHERE event_role.tag IN (''speaker'', ''moderator'') AND
              event_role_state.tag = ''confirmed'' AND
              event.conference_id = cur_conference_id AND
              event_state.tag = ''accepted'' AND
              event.day IS NOT NULL AND
              event.start_time IS NOT NULL
    LOOP

      -- loop through overlapping events
      FOR cur_event IN
        SELECT event_id 
          FROM event_person
          INNER JOIN event_role USING (event_role_id)
          INNER JOIN event_role_state USING (event_role_state_id)
          INNER JOIN event USING (event_id)
          INNER JOIN event_state USING (event_state_id)
          WHERE event.day IS NOT NULL AND
                event.start_time IS NOT NULL AND
                event.day = cur_speaker.day AND 
                event.event_id <> cur_speaker.event_id AND
                event.conference_id = cur_conference_id AND
                (( event.start_time >= cur_speaker.start_time AND
                   event.start_time < cur_speaker.start_time + cur_speaker.duration ) OR
                 ( event.start_time + event.duration > cur_speaker.start_time AND
                   event.start_time + event.duration <= cur_speaker.start_time + cur_speaker.duration )) AND
                event_state.tag = ''accepted'' AND
                event_role.tag IN (''speaker'', ''moderator'') AND
                event_role_state.tag = ''confirmed'' AND
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
        WHERE (( event_role.tag IN (''speaker'', ''moderator'') AND
                 event_role_state.tag = ''confirmed'') OR
               ( event_role.tag = ''visitor'' )) AND
              event.conference_id = cur_conference_id AND
              event_state.tag = ''accepted'' AND
              event.day IS NOT NULL AND
              event.start_time IS NOT NULL
    LOOP

      -- loop through overlapping events
      FOR cur_event IN
        SELECT event_id 
          FROM event
          INNER JOIN event_state USING (event_state_id)
          INNER JOIN event_person USING (event_id)
          INNER JOIN event_role USING (event_role_id)
          LEFT OUTER JOIN event_role_state USING (event_role_state_id)
          WHERE event.day IS NOT NULL AND
                event.start_time IS NOT NULL AND
                event.day = cur_speaker.day AND 
                event.event_id <> cur_speaker.event_id AND
                event.conference_id = cur_conference_id AND
                ( event.start_time::time, event.duration ) OVERLAPS ( cur_speaker.start_time::time, cur_speaker.duration ) AND
                event_state.tag = ''accepted'' AND
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

-- returns event_persons with conflicting events
CREATE OR REPLACE FUNCTION conflict_event_person_event_time_visitor_visitor(integer) RETURNS SETOF conflict_event_person_event AS '
  DECLARE 
    cur_conference_id ALIAS FOR $1;
    cur_speaker RECORD;
    cur_event RECORD;
    cur_conflict conflict_event_person_event%rowtype;
  BEGIN

-- Loop through all event_persons
    FOR cur_speaker IN
      SELECT person_id, event_id, conference_id, day, start_time, duration 
        FROM event_person 
        INNER JOIN event_role USING (event_role_id)
        INNER JOIN event USING (event_id)
        INNER JOIN event_state USING (event_state_id)
        WHERE event_role.tag = ''visitor'' AND
              event.conference_id = cur_conference_id AND
              event_state.tag = ''accepted'' AND
              event.day IS NOT NULL AND
              event.start_time IS NOT NULL
    LOOP

      -- loop through overlapping events
      FOR cur_event IN
        SELECT event_id 
          FROM event
          INNER JOIN event_state USING (event_state_id)
          INNER JOIN event_person USING (event_id)
          INNER JOIN event_role USING (event_role_id)
          WHERE event.day IS NOT NULL AND
                event.start_time IS NOT NULL AND
                event.day = cur_speaker.day AND 
                event.event_id <> cur_speaker.event_id AND
                event.conference_id = cur_conference_id AND
                ( event.start_time::time, event.duration ) OVERLAPS ( cur_speaker.start_time::time, cur_speaker.duration ) AND
                event_state.tag = ''accepted'' AND
                event_role.tag = ''visitor'' AND
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

-- returns attendees with conflicting events
CREATE OR REPLACE FUNCTION conflict_event_person_event_time_attendee(integer) RETURNS SETOF conflict_event_person_event AS '
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
             duration
        FROM event_person
        INNER JOIN event_role USING (event_role_id)
        INNER JOIN event USING (event_id)
        INNER JOIN event_state USING (event_state_id)
        INNER JOIN event_state_progress USING (event_state_progress_id)
        WHERE event_role.tag = ''attendee'' AND
              event.conference_id = cur_conference_id AND
              event_state.tag = ''accepted'' AND
              event_state_progress.tag = ''confirmed'' AND
              event.day IS NOT NULL AND
              event.start_time IS NOT NULL
    LOOP

      -- loop through overlapping events
      FOR cur_event IN
        SELECT event_id
          FROM event_person
          INNER JOIN event_role USING (event_role_id)
          INNER JOIN event USING (event_id)
          INNER JOIN event_state USING (event_state_id)
          INNER JOIN event_state_progress USING (event_state_progress_id)
          WHERE event.day IS NOT NULL AND
                event.start_time IS NOT NULL AND
                event.day = cur_speaker.day AND
                event.event_id <> cur_speaker.event_id AND
                event.conference_id = cur_conference_id AND
                (( event.start_time >= cur_speaker.start_time AND
                   event.start_time < cur_speaker.start_time + cur_speaker.duration ) OR
                 ( event.start_time + event.duration > cur_speaker.start_time AND
                   event.start_time + event.duration <= cur_speaker.start_time + cur_speaker.duration )) AND
                event_state.tag = ''accepted'' AND
                event_state_progress.tag = ''confirmed'' AND
                event_role.tag = ''attendee'' AND
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
