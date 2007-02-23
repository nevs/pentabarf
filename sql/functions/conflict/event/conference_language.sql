
-- returns all events with a language not in conference_language 
CREATE OR REPLACE FUNCTION conflict_event_conference_language(INTEGER) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
    FOR cur_event IN
      SELECT event_id
        FROM event
       WHERE event.conference_id = cur_conference_id AND
             event.language_id IS NOT NULL AND
             NOT EXISTS (SELECT 1 
                           FROM conference_language 
                          WHERE conference_id = cur_conference_id AND
                                language_id = event.language_id)
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

