
CREATE OR REPLACE VIEW view_report_resources AS
  SELECT
    event_id,
    conference_id,
    title,
    subtitle,
    remark,
    resources
  FROM event
  WHERE
    event.event_state = 'accepted' AND
    event.event_state_progress = 'confirmed'
  ORDER BY lower(title),lower(subtitle)
;

