
-- get conference_person_ids of all conference_persons with a specific person_id
CREATE OR REPLACE FUNCTION own_conference_persons( person_id INTEGER ) RETURNS SETOF INTEGER AS $$
  SELECT conference_person_id
    FROM conference_person
   WHERE person_id = $1;
$$ LANGUAGE SQL RETURNS NULL ON NULL INPUT;

