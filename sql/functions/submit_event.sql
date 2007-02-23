
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

    INSERT INTO event_person( event_id,
                              person_id,
                              event_role_id,
                              last_modified_by)
                     VALUES ( new_event_id,
                              cur_person_id,
                              ( SELECT event_role_id
                                  FROM event_role
                                 WHERE tag = 'submitter'),
                              cur_person_id);
    RETURN new_event_id;
  END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

