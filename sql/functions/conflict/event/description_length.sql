
CREATE OR REPLACE FUNCTION conflict.conflict_event_description_length(INTEGER) RETURNS SETOF conflict.conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_conference RECORD;
    cur_event RECORD;
  BEGIN
    SELECT INTO cur_conference abstract_length, description_length FROM conference WHERE conference_id = cur_conference_id;
    FOR cur_event IN
      SELECT event_id
        FROM event
       WHERE conference_id = cur_conference_id AND 
             length(description) > cur_conference.description_length
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

