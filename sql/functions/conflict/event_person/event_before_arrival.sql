
-- returns all events starting before the arrival of the speaker
CREATE OR REPLACE FUNCTION conflict_event_person_event_before_arrival(integer) RETURNS SETOF conflict_event_person AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_conflict conflict_event_person%rowtype;
  BEGIN

    FOR cur_conflict IN
      SELECT event_person.event_id, event_person.person_id
        FROM event_person
        INNER JOIN event ON (
          event.event_id = event_person.event_id AND
          event.day IS NOT NULL AND
          event.start_time IS NOT NULL
        )
        INNER JOIN person_travel USING (person_id, conference_id)
        INNER JOIN conference ON (
            event.conference_id = conference.conference_id AND
            conference.conference_id = cur_conference_id
        )
      WHERE
        event_person.event_role IN ('speaker','moderator') AND
        event_person.event_role_state = 'confirmed' AND
        event.event_state = 'accepted' AND
        ( (
            person_travel.arrival_date IS NOT NULL AND
            person_travel.arrival_time IS NULL AND
            person_travel.arrival_date > conference.start_date + event.day + '-1'::integer
          ) OR (
            person_travel.arrival_date IS NOT NULL AND
            person_travel.arrival_time IS NOT NULL AND
            (person_travel.arrival_date + person_travel.arrival_time)::timestamp > (conference.start_date + event.day + '-1'::integer + event.start_time + conference.day_change)::timestamp
        ) )
    LOOP
      RETURN NEXT cur_conflict;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

