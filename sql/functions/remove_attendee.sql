
CREATE OR REPLACE FUNCTION remove_attendee(person_id INTEGER, event_id INTEGER) RETURNS INTEGER AS $$
  DELETE FROM event_person
        WHERE event_id = $2 AND
              person_id = $1 AND
              event_role_id = (SELECT event_role_id FROM event_role WHERE tag = 'attendee');
  SELECT $1;
$$ LANGUAGE SQL RETURNS NULL ON NULL INPUT;

