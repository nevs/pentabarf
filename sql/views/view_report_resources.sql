
CREATE OR REPLACE VIEW view_report_resources AS
  SELECT
    event_id,
    conference_id,
    title,
    subtitle,
    remark,
    resources
  FROM event
    INNER JOIN event_state ON (
      event_state.event_state_id = event.event_state_id AND
      event_state.tag = 'accepted' )
    INNER JOIN event_state_progress ON (
      event_state_progress.event_state_progress_id = event.event_state_progress_id AND
      event_state_progress.event_state_id = event.event_state_id AND
      event_state_progress.tag = 'confirmed' )
;

