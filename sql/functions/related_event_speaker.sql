
CREATE OR REPLACE FUNCTION related_event_speaker(integer) RETURNS SETOF conflict_event AS '
  DECLARE
    cur_event_id ALIAS FOR $1;
    cur_event RECORD;
  BEGIN

    FOR cur_event IN
      SELECT event_id FROM event
        WHERE event.conference_id = (SELECT conference_id 
                                       FROM event 
                                      WHERE event_id = cur_event_id) AND
              event.event_id <> cur_event_id AND
              event.event_id IN ( SELECT event_id 
                                    FROM event_person
                                         INNER JOIN event_role USING (event_role_id)
                                         INNER JOIN event_role_state USING (event_role_state_id)
                                   WHERE event_role.tag IN (''speaker'',''moderator'') AND
                                         person_id IN ( SELECT person_id 
                                                          FROM event_person 
                                                               INNER JOIN event_role USING (event_role_id)
                                                               INNER JOIN event_role_state USING (event_role_state_id)
                                                         WHERE event_role.tag IN (''speaker'', ''moderator'') AND 
                                                               event_id = cur_event_id ) )
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
    
    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

