
CREATE OR REPLACE VIEW view_person_image AS
  SELECT person_image.person_id,
         person_image.mime_type_id,
         mime_type.mime_type,
         person_image.image,
         person_image.last_modified
    FROM person_image
         INNER JOIN mime_type USING (mime_type_id);

