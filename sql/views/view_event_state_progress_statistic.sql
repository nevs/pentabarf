
CREATE OR REPLACE VIEW view_event_state_progress_statistic AS
  SELECT
    conference_id,
    event_state,
    event_state_progress,
    count(event_state_progress) AS count,
    sum(duration) AS duration
  FROM
    event_state_progress
    INNER JOIN event USING( event_state, event_state_progress )
  GROUP BY 
    conference_id, 
    event_state, 
    event_state_progress,
    event_state_progress.rank
  ORDER BY event_state_progress.rank;

