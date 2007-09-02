
-- returns all events with identical keywords 
CREATE OR REPLACE FUNCTION related_event_keyword(integer) RETURNS SETOF conflict_event AS '
  DECLARE
    cur_event_id ALIAS FOR $1;
    cur_event RECORD;
  BEGIN

    FOR cur_event IN
      SELECT event_id 
        FROM event 
       WHERE event.conference_id = (SELECT conference_id FROM event WHERE event_id = cur_event_id) AND
             event.event_id <> cur_event_id AND
             event.event_id IN (SELECT event_id FROM event_keyword WHERE keyword_id IN 
                  (SELECT keyword_id FROM event_keyword WHERE event_id = cur_event_id)) 
    LOOP
      RETURN NEXT cur_event; 
    END LOOP;

    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

