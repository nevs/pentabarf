
CREATE OR REPLACE VIEW view_conference_image AS
  SELECT conference_image.conference_id,
         conference_image.mime_type_id,
         mime_type.mime_type,
         conference_image.image,
         conference_image.last_modified
    FROM conference_image
         INNER JOIN mime_type USING (mime_type_id);

