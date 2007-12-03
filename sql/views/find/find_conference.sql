
CREATE OR REPLACE VIEW view_find_conference AS
  SELECT conference.conference_id,
         conference.acronym,
         conference.title,
         conference.subtitle,
         conference_day.start_date,
         conference.venue,
         conference.city,
         conference_image.mime_type,
         mime_type.file_extension
    FROM conference
         LEFT OUTER JOIN ( SELECT conference_id, min(conference_day) AS start_date FROM conference_day GROUP BY conference_id ) AS conference_day USING (conference_id)
         LEFT OUTER JOIN conference_image USING (conference_id)
         LEFT OUTER JOIN mime_type USING (mime_type)
;

