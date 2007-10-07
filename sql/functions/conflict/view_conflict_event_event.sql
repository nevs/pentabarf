CREATE OR REPLACE FUNCTION view_conflict_event_event( conference_id INTEGER ) RETURNS SETOF view_conflict_event_event AS $$
  SELECT conflict_event_event.conflict_id,
         conflict_event_event.event_id1,
         conflict_event_event.event_id2,
         conference_phase_conflict.conflict_level_id,
         view_conflict_level.name AS level_name,
         view_conflict_level.tag AS level_tag,
         view_conflict.language_id,
         view_conflict.tag AS conflict_tag,
         view_conflict.name AS conflict_name,
         event1.title1,
         event2.title2
    FROM conflict_event_event( $1 )
         LEFT JOIN conference ON ( conference.conference_id = $1 )
         INNER JOIN conference_phase_conflict USING (conference_phase_id, conflict_id)
         INNER JOIN view_conflict USING (conflict_id)
         INNER JOIN view_conflict_level USING (conflict_level_id, language_id)
         INNER JOIN (SELECT event_id AS event_id1, title AS title1 FROM event) AS event1 USING (event_id1)
         INNER JOIN (SELECT event_id AS event_id2, title AS title2 FROM event) AS event2 USING (event_id2)
$$ LANGUAGE SQL;

