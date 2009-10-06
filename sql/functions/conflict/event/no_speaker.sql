
-- returns all confirmed events without confirmed speaker/moderator
CREATE OR REPLACE FUNCTION conflict.conflict_event_no_speaker(integer) RETURNS SETOF conflict.conflict_event AS $$
      SELECT event_id
        FROM event
        WHERE event.conference_id = $1 AND
              event_state = 'accepted' AND
              event_state_progress = 'reconfirmed' AND
              NOT EXISTS (SELECT 1 
                FROM event_person 
                     INNER JOIN event_role USING (event_role)
                WHERE event_person.event_id = event.event_id AND
                  event_role.public = true AND
                  event_role_state = 'confirmed');
$$ LANGUAGE SQL;

