CREATE TYPE view_conflict_event_person AS (
  conflict_id INTEGER,
  event_id INTEGER,
  person_id INTEGER,
  conflict_level_id INTEGER,
  level_name TEXT,
  level_tag TEXT,
  language_id INTEGER,
  conflict_tag TEXT,
  conflict_name TEXT,
  title TEXT,
  name TEXT
);

CREATE OR REPLACE FUNCTION view_conflict_event_person( conference_id INTEGER ) RETURNS SETOF view_conflict_event_person AS $$
  SELECT conflict_event_person.conflict_id,
         conflict_event_person.event_id,
         conflict_event_person.person_id,
         conference_phase_conflict.conflict_level_id,
         view_conflict_level.name AS level_name,
         view_conflict_level.tag AS level_tag,
         view_conflict.language_id,
         view_conflict.tag AS conflict_tag,
         view_conflict.name AS conflict_name,
         event.title,
         view_person.name
    FROM conflict_event_person( $1 )
         LEFT JOIN conference ON ( conference.conference_id = $1 )
         INNER JOIN conference_phase_conflict USING (conference_phase_id, conflict_id)
         INNER JOIN view_conflict USING (conflict_id)
         INNER JOIN view_conflict_level USING (conflict_level_id, language_id)
         INNER JOIN (SELECT event_id, title FROM event) AS event USING (event_id)
         INNER JOIN view_person USING (person_id)
$$ LANGUAGE SQL;
  
