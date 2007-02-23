
CREATE OR REPLACE FUNCTION remove_conference( conference_id INTEGER ) RETURNS INTEGER AS $$
  DECLARE
    cur_event RECORD;
  BEGIN
    DELETE FROM conference_transaction WHERE conference_transaction.conference_id = conference_id;
    FOR cur_event IN
      SELECT event_id FROM event WHERE event.conference_id = conference_id
    LOOP
      PERFORM remove_event( cur_event.event_id );
    END LOOP;
    DELETE FROM conference WHERE conference.conference_id = conference_id;
    RETURN conference_id;
  END;
$$ LANGUAGE PLPGSQL RETURNS NULL ON NULL INPUT;

