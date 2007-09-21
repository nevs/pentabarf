
CREATE OR REPLACE FUNCTION conflict_person_no_description(INTEGER) RETURNS SETOF conflict_person AS $$
      SELECT person_id
        FROM person
             LEFT OUTER JOIN (
                 SELECT person_id,
                        description
                   FROM conference_person
                  WHERE conference_id = cur_conference_id
             ) AS conference_person USING (person_id)
       WHERE description IS NULL AND
             EXISTS (SELECT 1
                       FROM event_person
                            INNER JOIN event USING (event_id)
                            INNER JOIN event_role USING (event_role_id)
                            INNER JOIN event_role_state USING (event_role_state_id)
                      WHERE event.conference_id = cur_conference_id AND
                            event.event_state = 'accepted' AND
                            event_person.person_id = person.person_id AND
                            event_role.tag IN ('speaker', 'moderator') AND
                            event_role_state.tag = 'confirmed'
             )
$$ LANGUAGE SQL;

