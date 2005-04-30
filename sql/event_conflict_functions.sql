/*
 *
 * Conflicts concerning events
 *
*/



-- returns events with conflicting timeslots
CREATE OR REPLACE FUNCTION conflict_event_time(integer) RETURNS SETOF conflict_event_time AS '
  DECLARE 
    cur_conference_id ALIAS FOR $1;
    cur_event RECORD;
    cur_event2 RECORD;
    cur_conflict conflict_event_time%rowtype;
    cur_event_state_confirmed INTEGER;
  BEGIN
    SELECT INTO cur_event_state_confirmed event_state_id FROM event_state WHERE event_state.tag = ''confirmed'';
-- Loop through all events
    FOR cur_event IN
      SELECT event_id, title, subtitle, start_time, duration, day, room_id FROM event 
        WHERE event.conference_id = cur_conference_id AND
              event.event_state_id = cur_event_state_confirmed AND
              event.day IS NOT NULL AND
              event.start_time IS NOT NULL
    LOOP
      FOR cur_event2 IN
        SELECT event_id, title, subtitle FROM event 
          WHERE event.day IS NOT NULL AND
                event.start_time IS NOT NULL AND
                event.day = cur_event.day AND 
                event.event_state_id = cur_event_state_confirmed AND
                event.event_id <> cur_event.event_id AND
                event.conference_id = cur_conference_id AND
                event.room_id = cur_event.room_id AND
                (( event.start_time >= cur_event.start_time AND
                   event.start_time < cur_event.start_time + cur_event.duration ) OR
                 ( event.start_time + event.duration > cur_event.start_time AND
                   event.start_time + event.duratION <= cur_event.start_time + cur_event.duration ))
      LOOP
        cur_conflict.event_id1 := cur_event.event_id;
        cur_conflict.title1 := cur_event.title;
        cur_conflict.subtitle1 := cur_event.subtitle;
        cur_conflict.event_id2 := cur_event2.event_id;
        cur_conflict.title2 := cur_event2.title;
        cur_conflict.subtitle2 := cur_event2.subtitle;
        RETURN NEXT cur_conflict;
      END LOOP;
    END LOOP;
    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;



-- returns all events without speaker/moderator
CREATE OR REPLACE FUNCTION conflict_event_no_speaker(integer) RETURNS SETOF event AS '
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event RECORD;
    cur_event_state_confirmed INTEGER;
    cur_event_role_speaker INTEGER;
    cur_event_role_moderator INTEGER;
    cur_event_role_speaker_confirmed INTEGER;
    cur_event_role_moderator_confirmed INTEGER;
  BEGIN
    SELECT INTO cur_event_state_confirmed event_state_id FROM event_state WHERE event_state.tag = ''confirmed'';
    SELECT INTO cur_event_role_speaker event_role_id FROM event_role WHERE tag = ''speaker'';
    SELECT INTO cur_event_role_moderator event_role_id FROM event_role WHERE tag = ''moderator'';
    SELECT INTO cur_event_role_speaker_confirmed event_role_state_id FROM event_role_state 
      WHERE tag = ''confirmed'' AND event_role_id = cur_event_role_speaker;
    SELECT INTO cur_event_role_moderator_confirmed event_role_state_id FROM event_role_state 
      WHERE tag = ''confirmed'' AND event_role_id = cur_event_role_moderator;
-- Loop through all events
    FOR cur_event IN
      SELECT event.* FROM event
        WHERE event.conference_id = cur_conference_id AND
              event.event_state_id = cur_event_state_confirmed AND
              event.f_public = TRUE
    LOOP
      IF NOT EXISTS (SELECT person_id FROM event_person 
                       WHERE event_person.event_id = cur_event.event_id AND
                             ((event_person.event_role_id = cur_event_role_speaker AND 
                               event_person.event_role_state_id = cur_event_role_speaker_confirmed ) OR
                              (event_person.event_role_id = cur_event_role_moderator AND
                               event_person.event_role_state_id = cur_event_role_moderator_confirmed)))
      THEN
        RETURN NEXT cur_event;
      END IF;
    END LOOP;
    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;


-- returns all events without coordinator
CREATE OR REPLACE FUNCTION conflict_event_no_coordinator(integer) RETURNS setof event AS '
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event RECORD;
    cur_event_state_confirmed INTEGER;
    cur_event_role_coordinator INTEGER;
  BEGIN
    SELECT INTO cur_event_state_confirmed event_state_id FROM event_state WHERE event_state.tag = ''confirmed'';
    SELECT INTO cur_event_role_coordinator event_role_id FROM event_role WHERE event_role.tag = ''coordinator'';

    -- Loop through all events
    FOR cur_event IN
      SELECT event.* FROM event
        WHERE event.conference_id = cur_conference_id AND
              event.event_state_id = cur_event_state_confirmed
    LOOP
      IF NOT EXISTS (SELECT person_id FROM event_person
                       WHERE event_person.event_id = cur_event.event_id AND
                             event_person.event_role_id = cur_event_role_coordinator)
      THEN
        RETURN NEXT cur_event;
      END IF;
    END LOOP;
    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;


-- returns all events with incomplete day/time/room
CREATE OR REPLACE FUNCTION conflict_event_incomplete(INTEGER) RETURNS SETOF event AS '
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event RECORD;
    cur_event_state_confirmed INTEGER;
  BEGIN
    SELECT INTO cur_event_state_confirmed event_state_id FROM event_state WHERE event_state.tag = ''confirmed'';

    FOR cur_event IN
      SELECT event.* FROM event
        WHERE conference_id = cur_conference_id AND
              event_state_id = cur_event_state_confirmed AND
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


