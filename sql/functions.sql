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

-- create new account to be activated
-- the parameter are login_name, email_contact, password, activation_string
CREATE OR REPLACE FUNCTION create_account(varchar(32),varchar(64),char(48), char(64)) RETURNS INTEGER AS $$
  DECLARE
    cur_login_name ALIAS FOR $1;
    cur_email_contact ALIAS FOR $2;
    cur_password ALIAS FOR $3;
    cur_activation_string ALIAS FOR $4;
    new_person_id INTEGER;
    cur_person RECORD;
  BEGIN
    -- cleanup obsolete activation stuff
    FOR cur_person IN
      SELECT person_id FROM person WHERE person_id IN (SELECT person_id FROM account_activation WHERE account_creation < (now() + '-1 day')::timestamptz)
    LOOP
      DELETE FROM person WHERE person_id = cur_person.person_id
      DELETE FROM account_activation WHERE person_id = cur_person.person_id
    END LOOP;

    SELECT INTO new_person_id nextval(pg_get_serial_sequence('person', 'person_id'));
    INSERT INTO person(person_id, login_name, email_contact, password) VALUES (new_person_id, cur_login_name, cur_email_contact, cur_password);
    INSERT INTO account_activation(person_id, activation_string) VALUES (new_person_id, cur_activation_string);
    RETURN new_person_id;
  END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

CREATE OR REPLACE FUNCTION activate_account(char(64)) RETURNS INTEGER AS $$
  DECLARE
    cur_activation_string ALIAS FOR $1;
    cur_person_id INTEGER;
  BEGIN
    -- cleanup obsolete activation stuff
    FOR cur_person IN
      SELECT person_id FROM person WHERE person_id IN (SELECT person_id FROM account_activation WHERE account_creation < (now() + '-1 day')::timestamptz)
    LOOP
      DELETE FROM person WHERE person_id = cur_person.person_id
      DELETE FROM account_activation WHERE person_id = cur_person.person_id
    END LOOP;

    SELECT INTO cur_person_id person_id FROM account_activation WHERE activation_string = cur_activation_string;
    IF FOUND THEN
      INSERT INTO person_role(person_id, role_id) VALUES (cur_person_id, (SELECT role_id FROM role WHERE tag = 'submitter'));
      INSERT INTO person_transaction( person_id, changed_when, changed_by, f_create ) VALUES (cur_person_id, now(), cur_person_id, 't');
      DELETE FROM account_activation WHERE activation_string = cur_activation_string;
    ELSE
      RAISE EXCEPTION 'invalid activation string';
    END IF;
    RETURN cur_person_id;
  END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

-- get event_ids of all events a person is speaker (used for checking modify_own_event)
CREATE OR REPLACE FUNCTION own_events(integer) RETURNS SETOF INTEGER AS $$
  SELECT event_id
    FROM event
   WHERE EXISTS (SELECT 1
                   FROM event_person
                        INNER JOIN event_role ON (
                            event_person.event_role_id = event_role.event_role_id AND
                            event_role.tag = 'speaker' )
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
                            event_role.tag = 'speaker' )
                  WHERE event_person.person_id = $1 AND event_person.event_id = event.event_id);
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

