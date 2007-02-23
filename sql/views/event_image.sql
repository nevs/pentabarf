
CREATE OR REPLACE VIEW view_event_image AS
  SELECT event_image.event_id,
         event_image.mime_type_id,
         mime_type.mime_type,
         event_image.image,
         event_image.last_modified
    FROM event_image
         INNER JOIN mime_type USING (mime_type_id);

