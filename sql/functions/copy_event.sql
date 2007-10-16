
CREATE OR REPLACE FUNCTION copy_event(integer, integer, integer) RETURNS INTEGER AS '
  DECLARE
    cur_event_id ALIAS FOR $1;
    cur_conference_id ALIAS FOR $2;
    cur_person_id ALIAS FOR $3;
    new_event_id INTEGER;

  BEGIN
    SELECT INTO new_event_id nextval(''event_event_id_seq'');
    INSERT INTO event( event_id,
                       conference_id,
                       conference_track_id,
                       title,
                       subtitle,
                       tag,
                       duration,
                       event_type_id,
                       event_origin,
                       event_state,
                       event_state_progress,
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
                       (CASE cur_conference_id WHEN conference_id THEN conference_track_id ELSE NULL END),
                       title,
                       subtitle,
                       tag,
                       duration,
                       event_type_id,
                       ''idea'',
                       ''undecided'',
                       ''new'',
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
                             mime_type,
                             image,
                             last_modified_by )
                      SELECT new_event_id,
                             mime_type,
                             image,
                             cur_person_id
                        FROM event_image
                       WHERE event_id = cur_event_id;

    INSERT INTO event_person( event_id,
                              person_id,
                              event_role,
                              event_role_state,
                              rank,
                              last_modified_by )
                       SELECT new_event_id,
                              person_id,
                              event_role,
                              event_role_state,
                              event_person.rank,
                              cur_person_id
                         FROM event_person
                        WHERE
                          event_person.event_role IN (''speaker'',''moderator'') AND
                          event_person.event_role_state = ''unclear'' AND
                          event_person.event_id = cur_event_id;

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

    INSERT INTO event_person( event_id,
                              person_id,
                              event_role,
                              last_modified_by )
                     VALUES ( new_event_id,
                              cur_person_id,
                              ''coordinator'',
                              cur_person_id );


    RETURN new_event_id;

  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

