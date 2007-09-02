
CREATE OR REPLACE VIEW view_event_state_combined AS
  SELECT view_event_state_progress.event_state_progress_id,
         view_event_state_progress.event_state_id,
         view_event_state_progress.tag AS event_state_progress_tag,
         view_event_state_progress.language_id,
         view_event_state.tag AS event_state_tag,
         view_event_state.name || ' ' || view_event_state_progress.name AS name,
         view_event_state.rank AS event_state_rank,
         view_event_state_progress.rank AS event_state_progress_rank
    FROM view_event_state_progress
         INNER JOIN view_event_state USING (event_state_id, language_id) ORDER BY event_state_rank,event_state_progress_rank;

