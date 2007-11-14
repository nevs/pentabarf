
-- create an event resulting from a submission
CREATE OR REPLACE FUNCTION submit_event( e_person_id INTEGER, e_conference_id INTEGER, e_title TEXT ) RETURNS INTEGER AS $$
  DECLARE
    new_event_id INTEGER;
  BEGIN
    SELECT INTO new_event_id nextval(pg_get_serial_sequence('base.event','event_id'));
    INSERT INTO event( event_id,
                       conference_id,
                       title,
                       duration,
                       event_state,
                       event_state_progress,
                       event_origin )
              VALUES ( new_event_id,
                       e_conference_id,
                       e_title,
                       ( SELECT default_timeslots * timeslot_duration
                           FROM conference
                          WHERE conference.conference_id = e_conference_id ),
                       'undecided',
                       'new',
                       'submission' );

    INSERT INTO event_person( event_id,
                              person_id,
                              event_role,
                              event_role_state )
                     VALUES ( new_event_id,
                              e_person_id,
                              'speaker',
                              'offer' );

    INSERT INTO event_person( event_id,
                              person_id,
                              event_role )
                     VALUES ( new_event_id,
                              e_person_id,
                              'submitter' );
    RETURN new_event_id;
  END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

