/*
 *
 * Conflicts concerning persons
 *
*/

-- returns all speaker/moderator without email
CREATE OR REPLACE FUNCTION conflict_person_no_email(integer) RETURNS SETOF conflict_person AS '
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_conflict conflict_person%rowtype;
    
  BEGIN

    FOR cur_conflict IN
      SELECT person_id FROM person 
                            INNER JOIN event_person USING (person_id) 
                            INNER JOIN event USING (event_id)
        WHERE person.email_contact IS NULL AND
              event.conference_id = cur_conference_id
    LOOP
      RETURN NEXT cur_conflict; 
    END LOOP;

    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;


-- returns event_persons that do not speak the language of the event
CREATE OR REPLACE FUNCTION conflict_person_event_language(integer) RETURNS SETOF conflict_person_event_language AS '
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event RECORD;
    cur_speaker RECORD;
    cur_conflict conflict_person_event_language%rowtype;
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

-- Loop through all event_persons
    FOR cur_speaker IN
      SELECT person_id, event_id FROM event_person
        WHERE ((event_person.event_role_id = cur_event_role_speaker AND 
                event_person.event_role_state_id = cur_event_role_speaker_confirmed ) OR
               (event_person.event_role_id = cur_event_role_moderator AND
                event_person.event_role_state_id = cur_event_role_moderator_confirmed)) AND
                EXISTS (SELECT event_id FROM event
                  WHERE event.event_id = event_person.event_id AND
                        event.conference_id = cur_conference_id AND
                        event.event_state_id = cur_event_state_confirmed AND
                        event.language_id IS NOT NULL)
    LOOP
      SELECT INTO cur_event event_id, language_id FROM event WHERE event_id = cur_speaker.event_id;
      IF NOT EXISTS (SELECT language_id FROM person_language WHERE person_id = cur_speaker.person_id AND language_id = cur_event.language_id )
      THEN
        cur_conflict.person_id := cur_speaker.person_id;
        SELECT INTO cur_conflict.name coalesce(person.public_name, coalesce(person.first_name || '' '', '''') || person.last_name, person.nickname, person.login_name) FROM person WHERE person.person_id = cur_speaker.person_id;
        cur_conflict.event_id := cur_speaker.event_id;
        SELECT INTO cur_conflict.title, cur_conflict.subtitle title, subtitle FROM event where event_id = cur_conflict.event_id;
        RETURN NEXT cur_conflict;
      END IF;
    END LOOP;
    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;


