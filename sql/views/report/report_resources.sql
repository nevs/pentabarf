
CREATE OR REPLACE VIEW view_report_resources AS
  SELECT event_id,
         conference_id,
         title,
         subtitle,
         resources
    FROM event
   WHERE resources IS NOT NULL
;

