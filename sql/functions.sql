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
CREATE OR REPLACE FUNCTION person_event_role_states(integer, integer) RETURNS text AS '
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

CREATE OR REPLACE FUNCTION copy_event(integer, integer, integer) RETURNS INTEGER AS '
  DECLARE
    cur_event_id ALIAS FOR $1;
    cur_conference_id ALIAS FOR $2;
    cur_person_id ALIAS FOR $3;
    new_event_id INTEGER;

  BEGIN
    SELECT INTO new_event_id nextval(''event_event_id_seq''::regclass);
    INSERT INTO event( event_id, 
                       conference_id, 
                       title, 
                       subtitle, 
                       tag,
                       duration, 
                       event_type_id, 
                       event_origin_id, 
                       event_state_id, 
                       event_state_progress_id, 
                       language_id, 
                       abstract, 
                       description, 
                       resources, 
                       f_public, 
                       f_paper, 
                       f_slides, 
                       f_unmoderated,
                       last_modified_by )
                SELECT new_event_id, 
                       cur_conference_id, 
                       title, 
                       subtitle, 
                       tag,
                       duration, 
                       event_type_id, 
                       (SELECT event_origin_id FROM event_origin WHERE tag = ''idea''), 
                       (SELECT event_state_id FROM event_state WHERE tag = ''undecided''), 
                       (SELECT event_state_progress_id 
                          FROM event_state_progress 
                               INNER JOIN event_state 
                                  ON (event_state.tag = ''undecided'' AND 
                                      event_state.event_state_id = event_state_progress.event_state_id) 
                         WHERE event_state_progress.tag = ''new''), 
                       language_id, 
                       abstract, 
                       description, 
                       resources, 
                       f_public, 
                       f_paper, 
                       f_slides, 
                       f_unmoderated,
                       cur_person_id
                  FROM event WHERE event_id = cur_event_id;

    INSERT INTO event_image( event_id,
                             mime_type_id,
                             image,
                             last_modified_by )
                      SELECT new_event_id,
                             mime_type_id,
                             image,
                             cur_person_id
                        FROM event_image 
                       WHERE event_id = cur_event_id;

    INSERT INTO event_person( event_id,
                              person_id,
                              event_role_id,
                              event_role_state_id,
                              rank,
                              last_modified_by )
                       SELECT new_event_id,
                              person_id,
                              event_person.event_role_id,
                              event_person.event_role_state_id,
                              event_person.rank,
                              cur_person_id
                         FROM event_person
                              INNER JOIN event_role ON
                                  (event_role.event_role_id = event_person.event_role_id AND
                                   event_role.tag IN (''speaker'', ''moderator''))
                              INNER JOIN event_role_state ON 
                                  (event_person.event_role_id = event_role_state.event_role_id AND 
                                   event_role_state.tag = ''unclear'')
                        WHERE event_person.event_id = cur_event_id;

    INSERT INTO event_link( event_id,
                            url,
                            rank,
                            title,
                            last_modified_by )
                     SELECT new_event_id,
                            url,
                            rank,
                            title,
                            cur_person_id
                       FROM event_link
                      WHERE event_id = cur_event_id;

    INSERT INTO event_related( event_id1, event_id2 ) VALUES( cur_event_id, new_event_id );

    RETURN new_event_id;

  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

