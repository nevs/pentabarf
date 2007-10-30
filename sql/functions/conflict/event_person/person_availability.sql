
-- returns all events conflicting with the availability of speakers
CREATE OR REPLACE FUNCTION conflict.conflict_event_person_person_availability( INTEGER ) RETURNS SETOF conflict.conflict_event_person AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_conflict conflict.conflict_event_person%rowtype;
  BEGIN

    FOR cur_conflict IN
      SELECT DISTINCT ON ( event_person.event_id, event_person.person_id )
             event_person.event_id, event_person.person_id
        FROM event_person
        INNER JOIN event ON (
          event.event_id = event_person.event_id AND
          event.day IS NOT NULL AND
          event.start_time IS NOT NULL
        )
        INNER JOIN person_availability AS slot USING (person_id, conference_id)
        INNER JOIN conference ON (
            conference.conference_id = event.conference_id AND
            conference.conference_id = cur_conference_id
        )
      WHERE
        event_person.event_role IN ('speaker','moderator') AND
        event_person.event_role_state = 'confirmed' AND
        event.event_state = 'accepted' AND
        ( ( slot.start_date <= (conference.start_date + event.day + '-1'::integer + event.start_time + conference.day_change) AND
            ( slot.start_date + slot.duration ) > (conference.start_date + event.day + '-1'::integer + event.start_time + conference.day_change)
          ) OR (
            slot.start_date >= (conference.start_date + event.day + '-1'::integer + event.start_time + conference.day_change) AND
            ( slot.start_date + slot.duration ) <= ( conference.start_date + event.day + '-1'::integer + event.start_time + conference.day_change + event.duration )
          ) OR (
            slot.start_date < ( conference.start_date + event.day + '-1'::integer + event.start_time + conference.day_change + event.duration ) AND
            ( slot.start_date + slot.duration ) >= ( conference.start_date + event.day + '-1'::integer + event.start_time + conference.day_change + event.duration )
          )
        )
    LOOP
      RETURN NEXT cur_conflict;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

