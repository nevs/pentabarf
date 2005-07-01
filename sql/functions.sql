/*
 * function for getting the permissions of a user
*/

CREATE OR REPLACE FUNCTION get_permissions(INTEGER) RETURNS SETOF TEXT AS '
  DECLARE
    cur_person_id ALIAS FOR $1;
    cur_permission RECORD;
  BEGIN
    FOR cur_permission IN
      SELECT DISTINCT authorisation.tag FROM authorisation, role_authorisation, person_role 
        WHERE authorisation.authorisation_id = role_authorisation.authorisation_id AND
            person_role.role_id = role_authorisation.role_id AND
            person_role.person_id = cur_person_id
    LOOP
      RETURN NEXT cur_permission.tag;
    END LOOP;
    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

CREATE OR REPLACE FUNCTION event_localized( INTEGER, INTEGER ) RETURNS SETOF event_localized AS '
  DECLARE
    cur_event_id ALIAS FOR $1;
    cur_language_id ALIAS FOR $2;
    cur_event event_localized%rowtype;
    data RECORD;

  BEGIN
    FOR data IN 
      SELECT event_id, conference_id, tag, title, subtitle, conference_track_id, team_id, event_type_id, duration, event_state_id, language_id, room_id, day, start_time, abstract, description, resources, f_public, f_paper, f_slides, f_conflict, f_slides, f_conflict, f_deleted, remark FROM event WHERE event_id = cur_event_id
    LOOP
      cur_event.event_id := data.event_id;
      cur_event.conference_id := data.conference_id;
      cur_event.tag := data.tag;
      cur_event.title := data.title;
      cur_event.subtitle := data.subtitle;
      cur_event.conference_track_id := data.conference_track_id;
      IF ( cur_event.conference_track_id IS NOT NULL ) THEN
        SELECT INTO cur_event.conference_track_tag tag FROM conference_track WHERE
          conference_track_id = cur_event.conference_track_id;
        SELECT INTO cur_event.conference_track name FROM conference_track_localized WHERE 
          conference_track_id = cur_event.conference_track_id AND language_id = cur_language_id;
        IF ( cur_event.conference_track IS NULL ) THEN 
          cur_event.conference_track := cur_event.conference_track_tag;
        END IF;
      END IF;
      cur_event.team_id := data.team_id;
      IF ( cur_event.team_id IS NOT NULL ) THEN
        SELECT INTO cur_event.team_tag tag FROM team
          WHERE team_id = cur_event.team_id;
        SELECT INTO cur_event.team name FROM team_localized 
          WHERE team_id = cur_event.team_id AND language_id = cur_language_id;
        IF ( cur_event.team IS NULL ) THEN
          cur_event.team := cur_event.team_tag;
        END IF;
      END IF;
      cur_event.event_type_id := data.event_type_id;
      IF ( cur_event.event_type_id IS NOT NULL ) THEN
        SELECT INTO cur_event.event_type_tag tag FROM event_type 
          WHERE event_type_id = cur_event.event_type_id;
        SELECT INTO cur_event.event_type name FROM event_type_localized 
          WHERE event_type_id = cur_event.event_type_id AND language_id = cur_language_id;
      END IF;
      cur_event.duration := data.duration;
      cur_event.event_state_id := data.event_state_id;
      IF ( cur_event.event_state_id IS NOT NULL ) THEN
        SELECT INTO cur_event.event_state_tag tag FROM event_state 
          WHERE event_state_id = cur_event.event_state_id;
        SELECT INTO cur_event.event_state name FROM event_state_localized 
          WHERE event_state_id = cur_event.event_state_id AND language_id = cur_language_id;
      END IF;
      cur_event.language_id := data.language_id;
      IF ( cur_event.language_id IS NOT NULL ) THEN
        SELECT INTO cur_event.language name FROM language_localized 
          WHERE translated_id = cur_event.language_id AND language_id = cur_language_id;
      END IF;
      cur_event.room_id := data.room_id;
      IF ( cur_event.room_id IS NOT NULL ) THEN
        SELECT INTO cur_event.room public_name FROM room_localized 
          WHERE room_id = cur_event.room_id AND language_id = cur_language_id;
        SELECT INTO cur_event.room_tag short_name FROM room 
          WHERE room_id = cur_event.room_id;
        IF ( cur_event.room IS NULL ) THEN
          cur_event.room := cur_event.room_tag;
        END IF;
      END IF;
      cur_event.day := data.day;
      cur_event.start_time := data.start_time;
      cur_event.abstract := data.abstract;
      cur_event.description := data.description;
      cur_event.resources := data.resources;
      cur_event.f_public := data.f_public;
      cur_event.f_paper := data.f_paper;
      cur_event.f_slides := data.f_slides;
      cur_event.f_conflict := data.f_conflict;
      cur_event.f_deleted := data.f_deleted;
      cur_event.remark := data.remark;

      RETURN NEXT cur_event;

    END LOOP;

    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;


-- returns all phone numbers of a specific type 
CREATE OR REPLACE FUNCTION person_phone_by_type(integer, text) RETURNS text AS '
  DECLARE
    cur_person_id ALIAS FOR $1;
    cur_phone_type_tag ALIAS FOR $2;
    cur_phone_numbers TEXT;
    cur_phone_number RECORD;
    
  BEGIN

    FOR cur_phone_number IN
      SELECT phone_number FROM person_phone INNER JOIN phone_type USING (phone_type_id) WHERE person_id = cur_person_id AND phone_type.tag = cur_phone_type_tag 
    LOOP
      IF ( cur_phone_numbers IS NOT NULL ) THEN
         cur_phone_numbers := cur_phone_numbers || '', ''::text || cur_phone_number.phone_number;
      ELSE
         cur_phone_numbers := cur_phone_number.phone_number;
      END IF;
    END LOOP;

    RETURN cur_phone_numbers;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

