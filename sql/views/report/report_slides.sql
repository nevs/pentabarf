
CREATE OR REPLACE VIEW view_report_slides AS
  SELECT event_id,
         conference_id,
         title,
         subtitle,
         slides,
         (SELECT count(event_attachment_id)
            FROM event_attachment
           WHERE event_id = event.event_id AND
                 attachment_type = 'slides')
         AS slides_submitted,
         (SELECT sum(pages)
           FROM event_attachment
          WHERE event_id = event.event_id AND
                attachment_type = 'slides')
         AS pages
    FROM event
   WHERE event.event_state = 'accepted' AND
         event.event_state_progress = 'confirmed' AND
         event.slides = 't'
   ORDER BY lower(title), lower(subtitle)
;

