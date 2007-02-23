
-- returns all events with inconsistent public links
CREATE OR REPLACE FUNCTION conflict_event_inconsistent_public_link(INTEGER) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
    FOR cur_event IN
      SELECT event_id
        FROM event
       WHERE conference_id = cur_conference_id AND
             EXISTS (SELECT 1 FROM event_link
                             WHERE event_id = event.event_id AND
                                   url NOT SIMILAR TO '[a-z]+:%')
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

