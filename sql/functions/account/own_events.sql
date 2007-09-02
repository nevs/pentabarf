
-- get event_ids of all events a person is speaker (used for checking modify_own_event)
CREATE OR REPLACE FUNCTION own_events( person_id INTEGER) RETURNS SETOF INTEGER AS $$
  SELECT event_id
    FROM event
   WHERE EXISTS (SELECT 1
                   FROM event_person
                        INNER JOIN event_role ON (
                            event_person.event_role_id = event_role.event_role_id AND
                            event_role.tag IN ('speaker', 'moderator', 'coordinator', 'submitter') )
                  WHERE event_person.person_id = $1 AND event_person.event_id = event.event_id);
$$ LANGUAGE SQL RETURNS NULL ON NULL INPUT;

-- get event_ids of all events a person is speaker of a specific conference
CREATE OR REPLACE FUNCTION own_conference_events( person_id INTEGER, conference_id INTEGER) RETURNS SETOF INTEGER AS $$
  SELECT event_id
    FROM event
   WHERE conference_id = $2 AND
         EXISTS (SELECT 1
                   FROM event_person
                        INNER JOIN event_role ON (
                            event_person.event_role_id = event_role.event_role_id AND
                            event_role.tag IN ('speaker', 'moderator', 'coordinator', 'submitter')  )
                  WHERE event_person.person_id = $1 AND event_person.event_id = event.event_id);
$$ LANGUAGE SQL RETURNS NULL ON NULL INPUT;

