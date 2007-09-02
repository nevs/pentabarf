
CREATE OR REPLACE VIEW view_conference_image_modification AS
  SELECT conference_image.conference_id,
         conference_image.last_modified
    FROM conference_image;

