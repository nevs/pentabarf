
CREATE OR REPLACE VIEW view_event_image_modification AS
  SELECT event_image.event_id,
         event_image.last_modified
    FROM event_image;

