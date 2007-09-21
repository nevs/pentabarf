
CREATE OR REPLACE FUNCTION add_attendee(INTEGER, INTEGER) RETURNS INTEGER AS $$
  DECLARE
    cur_person_id ALIAS FOR $1;
    cur_event_id ALIAS FOR $2;
    cur_event_person RECORD;
  BEGIN
    SELECT INTO cur_event_person event_id
      FROM event
           INNER JOIN conference ON (
             conference.conference_id = event.conference_id AND
             conference.f_visitor_enabled = 't' )
      WHERE
        event.event_state = 'accepted' AND
        event.event_state_progress = 'confirmed' AND
        event.event_id = cur_event_id;

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

