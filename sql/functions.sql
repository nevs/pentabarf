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


-- returns all person states of a person 
CREATE OR REPLACE FUNCTION person_event_role_states(integer, text) RETURNS text AS '
  DECLARE
    cur_person_id ALIAS FOR $1;
    cur_conference_id ALIAS FOR $2;
    cur_states TEXT;
    cur_status RECORD;
    
  BEGIN

    FOR cur_status IN
      SELECT event_role_state.tag, count( event_role_state.tag ) AS count FROM event_person INNER JOIN event_role_state USING (event_role_state_id) INNER JOIN event USING (event_id) WHERE conference_id = cur_conference_id AND person_id = cur_person_id GROUP BY event_role_state.tag
    LOOP
      IF ( cur_states IS NOT NULL ) THEN
         cur_states := cur_states || '', ''::text || cur_status.tag;
      ELSE
         cur_states := cur_status.tag;
      END IF;
      
      IF ( cur_status.count > 1 ) THEN
         cur_states := cur_status.tag || '' ('' || cur_status.count || ''x)'';
      END IF;

    END LOOP;

    RETURN cur_states;
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

