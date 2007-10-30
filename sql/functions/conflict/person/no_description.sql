
CREATE OR REPLACE FUNCTION conflict.conflict_person_no_description(INTEGER) RETURNS SETOF conflict.conflict_person AS $$
      SELECT person_id
        FROM person
             LEFT OUTER JOIN (
                 SELECT person_id,
                        description
                   FROM conference_person
                  WHERE conference_id = $1
             ) AS conference_person USING (person_id)
       WHERE description IS NULL AND
             EXISTS (SELECT 1
                       FROM event_person
                            INNER JOIN event USING (event_id)
                      WHERE event.conference_id = $1 AND
                            event.event_state = 'accepted' AND
                            event_person.person_id = person.person_id AND
                            event_role IN ('speaker', 'moderator') AND
                            event_role_state = 'confirmed'
             )
$$ LANGUAGE SQL;

