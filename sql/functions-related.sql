
-- returns all events with identical keywords 
CREATE OR REPLACE FUNCTION related_event_keyword(integer) RETURNS SETOF event AS '
  DECLARE
    cur_event_id ALIAS FOR $1;
    cur_conference_id INTEGER;
    cur_day_change INTERVAL;
    cur_event RECORD;
    
  BEGIN

    SELECT INTO cur_conference_id conference_id FROM event WHERE event_id = cur_event_id;
    SELECT INTO cur_day_change day_change FROM conference WHERE conference_id = cur_conference_id;

    FOR cur_event IN
      SELECT event_id, conference_id, tag, title, subtitle, conference_track_id, team_id, event_type_id, duration, event_state_id, language_id, room_id, day, cur_day_change + start_time AS start_time, abstract, description, resources, f_public, f_paper, f_slides, f_conflict, f_deleted, remark FROM event 
        WHERE event.conference_id = cur_conference_id AND
              event.event_id <> cur_event_id AND
              event.event_id IN (SELECT event_id FROM event_keyword WHERE keyword_id IN 
                  (SELECT keyword_id FROM event_keyword WHERE event_id = cur_event_id)) 
    LOOP
      RETURN NEXT cur_event; 
    END LOOP;

    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

CREATE OR REPLACE FUNCTION related_event_speaker(integer) RETURNS SETOF event AS '
  DECLARE
    cur_event_id ALIAS FOR $1;
    cur_conference_id INTEGER;
    speaker_event_role_id INTEGER;
    speaker_state_confirmed INTEGER;
    cur_event RECORD;

  BEGIN

    SELECT INTO cur_conference_id conference_id FROM event WHERE event_id = cur_event_id;
    SELECT INTO speaker_event_role_id event_role_id FROM event_role WHERE event_role.tag = ''speaker'';
    SELECT INTO speaker_state_confirmed event_role_state_id FROM event_role_state 
      WHERE event_role_id = speaker_event_role_id AND tag = ''confirmed'';

    FOR cur_event IN
      SELECT * FROM event
        WHERE event.conference_id = cur_conference_id AND
              event.event_id <> cur_event_id AND
              event.event_id IN ( SELECT event_id FROM event_person WHERE 
                  event_person.event_role_id = speaker_event_role_id AND 
                  event_person.event_role_state_id = speaker_state_confirmed AND
                  person_id IN 
                    ( SELECT person_id FROM event_person WHERE 
                          event_person.event_role_id = speaker_event_role_id AND 
                          event_person.event_role_state_id = speaker_state_confirmed AND
                          event_id = cur_event_id ) )
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
    
    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

