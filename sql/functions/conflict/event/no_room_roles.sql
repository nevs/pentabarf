
-- returns all confirmed events without his room_roles satisficed
CREATE OR REPLACE FUNCTION conflict.conflict_event_no_room_roles(integer) RETURNS SETOF conflict.conflict_event AS $$
      SELECT event.event_id
        FROM event
				LEFT JOIN conference_room_role using(conference_room_id)
				LEFT JOIN event_person on event_person.event_id = event.event_id and conference_room_role.event_role = event_person.event_role and event_role_state = 'confirmed'
        WHERE event.conference_id = $1 AND
              event_state = 'accepted' AND
              event_state_progress = 'reconfirmed'
        GROUP BY event.event_id,conference_room_role.event_role
				HAVING count(event_person.person_id) < max(conference_room_role.amount);
$$ LANGUAGE SQL;

