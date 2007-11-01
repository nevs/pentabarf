
CREATE OR REPLACE FUNCTION conflict.view_conflict_person( conference_id INTEGER ) RETURNS SETOF conflict.view_conflict_person AS $$
  SELECT conflict_person.conflict,
         conflict_localized.name AS conflict_name,
         conference_phase_conflict.conflict_level,
         conflict_level_localized.name AS conflict_level_name,
         conflict_localized.language_id,
         conflict_person.person_id,
         view_person.name
    FROM conflict.conflict_person( $1 )
         LEFT JOIN conference ON ( conference.conference_id = $1 )
         INNER JOIN conflict.conference_phase_conflict USING (conference_phase, conflict)
         INNER JOIN conflict.conflict_localized USING (conflict)
         INNER JOIN conflict.conflict_level_localized USING (conflict_level, language_id)
         INNER JOIN view_person USING (person_id)
$$ LANGUAGE SQL;

