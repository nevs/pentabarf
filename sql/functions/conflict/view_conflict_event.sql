CREATE OR REPLACE FUNCTION conflict.view_conflict_event( conference_id INTEGER ) RETURNS SETOF conflict.view_conflict_event AS $$
  SELECT
    conflict_event.conflict,
    conflict_localized.name AS conflict_name,
    conference_phase_conflict.conflict_level,
    conflict_level_localized.name AS conflict_level_name,
    conflict_localized.translated,
    conflict_event.event_id,
    event.title
  FROM conflict.conflict_event( $1 )
    LEFT JOIN conference ON (conference.conference_id = $1 )
    INNER JOIN conflict.conference_phase_conflict USING (conference_phase, conflict)
    INNER JOIN conflict.conflict_localized USING (conflict)
    INNER JOIN conflict.conflict_level_localized USING (conflict_level, translated)
    INNER JOIN (SELECT event_id, title FROM event) AS event USING (event_id)
$$ LANGUAGE SQL;

