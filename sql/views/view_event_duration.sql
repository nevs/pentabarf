CREATE OR REPLACE VIEW view_event_duration AS
  SELECT DISTINCT duration FROM event ORDER BY duration;

