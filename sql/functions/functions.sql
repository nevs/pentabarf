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

-- get event_ids of all events a person is speaker (used for checking modify_own_event)
CREATE OR REPLACE FUNCTION own_events(integer) RETURNS SETOF INTEGER AS $$
  SELECT event_id
    FROM event
   WHERE EXISTS (SELECT 1
                   FROM event_person
                        INNER JOIN event_role ON (
                            event_person.event_role_id = event_role.event_role_id AND
                            event_role.tag IN ('speaker', 'moderator', 'coordinator') )
                  WHERE event_person.person_id = $1 AND event_person.event_id = event.event_id);
$$ LANGUAGE SQL RETURNS NULL ON NULL INPUT;

-- get event_ids of all events a person is speaker of a specific conference
CREATE OR REPLACE FUNCTION own_events(integer, integer) RETURNS SETOF INTEGER AS $$
  SELECT event_id
    FROM event
   WHERE conference_id = $2 AND
         EXISTS (SELECT 1
                   FROM event_person
                        INNER JOIN event_role ON (
                            event_person.event_role_id = event_role.event_role_id AND
                            event_role.tag IN ('speaker', 'moderator', 'coordinator')  )
                  WHERE event_person.person_id = $1 AND event_person.event_id = event.event_id);
$$ LANGUAGE SQL RETURNS NULL ON NULL INPUT;

-- get conference_person_ids of all conference_persons with a specific person_id
CREATE OR REPLACE FUNCTION own_conference_persons(integer) RETURNS SETOF INTEGER AS $$
  SELECT conference_person_id
    FROM conference_person
   WHERE person_id = $1;
$$ LANGUAGE SQL RETURNS NULL ON NULL INPUT;

-- create an event resulting from a submission
CREATE OR REPLACE FUNCTION submit_event(integer, integer, text) RETURNS INTEGER AS $$
  DECLARE
    cur_person_id ALIAS FOR $1;
    cur_conference_id ALIAS FOR $2;
    cur_title ALIAS FOR $3;
    new_event_id INTEGER;
  BEGIN
    SELECT INTO new_event_id nextval('event_event_id_seq');
    INSERT INTO event( event_id,
                       conference_id,
                       title,
                       duration,
                       event_state_id,
                       event_origin_id,
                       event_state_progress_id,
                       last_modified_by)
              VALUES ( new_event_id,
                       cur_conference_id,
                       cur_title,
                       ( SELECT default_timeslots * timeslot_duration
                           FROM conference
                          WHERE conference_id = cur_conference_id ),
                       ( SELECT event_state_id
                           FROM event_state
                          WHERE tag = 'undecided'),
                       ( SELECT event_origin_id
                           FROM event_origin
                          WHERE tag = 'submission'),
                       ( SELECT event_state_progress_id
                           FROM event_state_progress
                                INNER JOIN event_state ON (
                                    event_state.event_state_id = event_state_progress.event_state_id AND
                                    event_state.tag = 'undecided')
                          WHERE event_state_progress.tag = 'new'),
                       cur_person_id );

    INSERT INTO event_person( event_id,
                              person_id,
                              event_role_id,
                              event_role_state_id,
                              last_modified_by)
                     VALUES ( new_event_id,
                              cur_person_id,
                              ( SELECT event_role_id
                                  FROM event_role
                                 WHERE tag = 'speaker'),
                              ( SELECT event_role_state_id
                                  FROM event_role_state
                                       INNER JOIN event_role ON (
                                          event_role.event_role_id = event_role_state.event_role_id AND
                                          event_role.tag = 'speaker')
                                 WHERE event_role_state.tag = 'offer'),
                              cur_person_id);
    RETURN new_event_id;
  END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

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
                       (CASE cur_conference_id WHEN conference_id THEN conference_track_id ELSE NULL END),
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

    INSERT INTO event_person( event_id, 
                              person_id,
                              event_role_id,
                              last_modified_by )
                     VALUES ( new_event_id,
                              cur_person_id,
                              (SELECT event_role_id FROM event_role WHERE tag = ''coordinator''),
                              cur_person_id );


    RETURN new_event_id;

  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

CREATE OR REPLACE FUNCTION add_attendee(INTEGER, INTEGER) RETURNS INTEGER AS $$
  DECLARE
    cur_person_id ALIAS FOR $1;
    cur_event_id ALIAS FOR $2;
    cur_event_person RECORD;
  BEGIN
    SELECT INTO cur_event_person event_id 
      FROM event 
           INNER JOIN event_state ON (
               event_state.event_state_id = event.event_state_id AND
               event_state.tag = 'accepted' )
           INNER JOIN event_state_progress ON (
               event_state_progress.event_state_progress_id = event.event_state_progress_id AND
               event_state_progress.event_state_id = event.event_state_id AND
               event_state_progress.tag = 'confirmed' )
           INNER JOIN conference ON (
               conference.conference_id = event.conference_id AND
               conference.f_visitor_enabled = 't' )
     WHERE event.event_id = cur_event_id;
    IF NOT FOUND THEN
      RAISE EXCEPTION 'Event is not accepted and confirmed or visitor system for this conference is disabled.';
    END IF;
    INSERT INTO event_person( event_id,
                              person_id,
                              event_role_id,
                              last_modified,
                              last_modified_by )
                      VALUES( cur_event_id,
                              cur_person_id,
                              (SELECT event_role_id FROM event_role WHERE tag = 'attendee'),
                              now(),
                              cur_person_id );
    RETURN cur_person_id;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

CREATE OR REPLACE FUNCTION remove_attendee(person_id INTEGER, event_id INTEGER) RETURNS INTEGER AS $$
  DELETE FROM event_person
        WHERE event_id = $2 AND
              person_id = $1 AND
              event_role_id = (SELECT event_role_id FROM event_role WHERE tag = 'attendee');
  SELECT $1;
$$ LANGUAGE SQL RETURNS NULL ON NULL INPUT;

CREATE OR REPLACE FUNCTION remove_event( event_id INTEGER ) RETURNS INTEGER AS $$
  DECLARE
  BEGIN
    DELETE FROM event_transaction WHERE event_transaction.event_id = event_id;
    DELETE FROM event_related WHERE event_related.event_id1 = event_id;
    DELETE FROM event_image WHERE event_image.event_id = event_id;
    DELETE FROM event_person WHERE event_person.event_id = event_id;
    DELETE FROM event_link WHERE event_link.event_id = event_id;
    DELETE FROM event_link_internal WHERE event_link_internal.event_id = event_id;
    DELETE FROM event_attachment WHERE event_attachment.event_id = event_id;
    DELETE FROM event_rating WHERE event_rating.event_id = event_id;
    DELETE FROM event_rating_public WHERE event_rating_public.event_id = event_id; 
    DELETE FROM event WHERE event.event_id = event_id;
    RETURN event_id;
  END;
$$ LANGUAGE PLPGSQL RETURNS NULL ON NULL INPUT;

CREATE OR REPLACE FUNCTION remove_conference( conference_id INTEGER ) RETURNS INTEGER AS $$
  DECLARE
    cur_event RECORD;
  BEGIN
    DELETE FROM conference_transaction WHERE conference_transaction.conference_id = conference_id;
    FOR cur_event IN
      SELECT event_id FROM event WHERE event.conference_id = conference_id
    LOOP
      PERFORM remove_event( cur_event.event_id );
    END LOOP;
    DELETE FROM conference WHERE conference.conference_id = conference_id;
    RETURN conference_id;
  END;
$$ LANGUAGE PLPGSQL RETURNS NULL ON NULL INPUT;

