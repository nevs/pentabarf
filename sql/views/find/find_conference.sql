
CREATE OR REPLACE VIEW view_find_conference AS
  SELECT conference.conference_id,
         conference.acronym,
         conference.title,
         conference.subtitle,
         conference.start_date,
         conference.days,
         conference.venue,
         conference.city,
         conference_image.mime_type,
         mime_type.file_extension
    FROM conference
         LEFT OUTER JOIN conference_image USING (conference_id)
         LEFT OUTER JOIN mime_type USING (mime_type);

