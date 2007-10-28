CREATE OR REPLACE FUNCTION view_conflict_event( conference_id INTEGER ) RETURNS SETOF view_conflict_event AS $$
  SELECT
    conflict_event.conflict_id,
    conflict_event.event_id,
    conference_phase_conflict.conflict_level_id,
    view_conflict_level.name AS level_name,
    view_conflict_level.tag AS level_tag,
    view_conflict.language_id,
    view_conflict.tag AS conflict_tag,
    view_conflict.name AS conflict_name,
    event.title
  FROM conflict_event( $1 )
    LEFT JOIN conference ON (conference.conference_id = $1 )
    INNER JOIN conference_phase_conflict USING (conference_phase, conflict_id)
    INNER JOIN view_conflict USING (conflict_id)
    INNER JOIN view_conflict_level USING (conflict_level_id, language_id)
    INNER JOIN (SELECT event_id, title FROM event) AS event USING (event_id)
$$ LANGUAGE SQL;

