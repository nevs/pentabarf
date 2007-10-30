CREATE OR REPLACE FUNCTION conflict.view_conflict_event_person( conference_id INTEGER ) RETURNS SETOF conflict.view_conflict_event_person AS $$
  SELECT conflict_event_person.conflict,
         conflict_localized.name AS conflict_name,
         conference_phase_conflict.conflict_level,
         conflict_level_localized.name AS level_name,
         conflict_localized.language_id,
         conflict_event_person.event_id,
         conflict_event_person.person_id,
         event.title,
         view_person.name
    FROM conflict.conflict_event_person( $1 )
         LEFT JOIN conference ON ( conference.conference_id = $1 )
         INNER JOIN conflict.conference_phase_conflict USING (conference_phase, conflict)
         INNER JOIN conflict.conflict_localized USING (conflict)
         INNER JOIN conflict.conflict_level_localized USING (conflict_level, language_id)
         INNER JOIN (SELECT event_id, title FROM event) AS event USING (event_id)
         INNER JOIN view_person USING (person_id)
$$ LANGUAGE SQL;

