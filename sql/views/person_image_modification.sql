
CREATE OR REPLACE VIEW view_person_image_modification AS
  SELECT person_image.person_id,
         person_image.last_modified
    FROM person_image;

