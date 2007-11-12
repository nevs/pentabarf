
CREATE OR REPLACE FUNCTION conflict.view_conflict_event_person_event( conference_id INTEGER ) RETURNS SETOF conflict.view_conflict_event_person_event AS $$
  SELECT conflict_event_person_event.conflict,
         conflict_localized.name AS conflict_name,
         conference_phase_conflict.conflict_level,
         conflict_level_localized.name AS conflict_level_name,
         conflict_localized.translated,
         conflict_event_person_event.person_id,
         conflict_event_person_event.event_id1,
         conflict_event_person_event.event_id2,
         view_person.name,
         event1.title1,
         event2.title2
    FROM conflict.conflict_event_person_event( $1 )
         LEFT JOIN conference ON ( conference.conference_id = $1 )
         INNER JOIN conflict.conference_phase_conflict USING (conference_phase, conflict)
         INNER JOIN conflict.conflict_localized USING (conflict)
         INNER JOIN conflict.conflict_level_localized USING (conflict_level, translated)
         INNER JOIN view_person USING (person_id)
         INNER JOIN (SELECT event_id AS event_id1, title AS title1 FROM event) AS event1 USING (event_id1)
         INNER JOIN (SELECT event_id AS event_id2, title AS title2 FROM event) AS event2 USING (event_id2)
$$ LANGUAGE SQL;

