
-- returns all accepted events with no paper but the f_slides flag set
CREATE OR REPLACE FUNCTION conflict_event_no_slides(INTEGER) RETURNS SETOF conflict_event AS $$
  SELECT event_id
    FROM event
   WHERE conference_id = $1 AND
         event_state = 'accepted' AND
         event_state_progress = 'confirmed' AND
         f_slides = 't' AND
         NOT EXISTS (SELECT 1 FROM event_attachment
                             WHERE event_id = event.event_id AND
                                   event_attachment.attachment_type = 'slides' AND
                                   event_attachment.f_public = 't')
$$ LANGUAGE SQL;

