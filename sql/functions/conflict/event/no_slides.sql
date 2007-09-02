
-- returns all accepted events with no paper but the f_slides flag set
CREATE OR REPLACE FUNCTION conflict_event_no_slides(INTEGER) RETURNS SETOF conflict_event AS $$
  DECLARE
    cur_conference_id ALIAS FOR $1;
    cur_event conflict_event%ROWTYPE;
  BEGIN
    FOR cur_event IN
      SELECT event_id
        FROM event
             INNER JOIN event_state USING (event_state_id)
             INNER JOIN event_state_progress ON (
                event.event_state_progress_id = event_state_progress.event_state_progress_id AND
                event.event_state_id = event_state_progress.event_state_id AND
                event_state_progress.tag = 'confirmed'
              )
       WHERE conference_id = cur_conference_id AND
             event_state.tag = 'accepted' AND
             f_slides = 't' AND
             NOT EXISTS (SELECT 1 FROM event_attachment
                                       INNER JOIN attachment_type USING (attachment_type_id)
                                 WHERE event_id = event.event_id AND
                                       attachment_type.tag = 'slides' AND
                                       event_attachment.f_public = 't')
    LOOP
      RETURN NEXT cur_event;
    END LOOP;
    RETURN;
  END;
$$ LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

