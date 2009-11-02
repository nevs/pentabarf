
-- view for events
CREATE OR REPLACE VIEW view_schedule AS
   SELECT event.event_id,
          event.conference_id,
          event.slug,
          event.title,
          event.subtitle,
          event.conference_track_id,
          conference_track.conference_track,
          event.conference_team,
          event.event_type,
          event.duration,
          event.event_state,
          event.event_state_progress,
          event.language,
          event.conference_room_id,
          conference_room.conference_room,
          event.conference_day_id,
          conference_day.conference_day,
          conference_day.name AS conference_day_name,
          event.start_time AS start_offset,
          event.start_time + conference.day_change AS start_time,
          event.abstract,
          event.description,
          event.public,
          translated.language AS translated,
          language_localized.name AS language_name,
          event_type_localized.name AS event_type_name,
          (conference_day.conference_day + event.start_time + conference.day_change)::timestamp AS start_datetime,
          array_to_string(
            ARRAY(
              SELECT view_person.person_id
                FROM event_person
                INNER JOIN event_role USING(event_role)
                JOIN event_role_localized ON (
                  event_role_localized.translated = translated.language AND
                  event_role_localized.event_role = event_person.event_role )
                JOIN view_person USING (person_id)
                WHERE
                  event_person.event_id = event.event_id AND
                  (
                    ( event_person.event_role = 'coordinator' ) OR
                    ( event_person.event_role IN ('speaker','moderator') AND
                      event_person.event_role_state NOT IN ( 'declined','canceled' ) )
                  )
                ORDER BY event_role.rank, view_person.name, view_person.person_id
            ),
            E'\n'
          ) AS speaker_ids,
          array_to_string(
            ARRAY(
              SELECT view_person.name || ' (' || event_role_localized.name || ')'
                FROM event_person
                INNER JOIN event_role USING(event_role)
                JOIN event_role_localized ON (
                  event_role_localized.translated = translated.language AND
                  event_role_localized.event_role = event_person.event_role )
                JOIN view_person USING (person_id)
                WHERE
                  event_person.event_id = event.event_id AND
                  (
                    ( event_person.event_role = 'coordinator' ) OR
                    ( event_person.event_role IN ('speaker','moderator') AND
                      event_person.event_role_state NOT IN ( 'declined','canceled' ) )
                  )
                ORDER BY event_role.rank, view_person.name, view_person.person_id
            ),
            E'\n'
          ) AS speakers
     FROM event
          CROSS JOIN language AS translated
          INNER JOIN conference USING (conference_id)
          INNER JOIN conference_day USING (conference_day_id)
          INNER JOIN conference_room USING (conference_room_id)
          LEFT OUTER JOIN conference_track USING (conference_track_id)
          LEFT OUTER JOIN language_localized ON (
              language_localized.translated = translated.language AND
              language_localized.language = event.language )
          LEFT OUTER JOIN event_type_localized USING (event_type,translated)
    WHERE
      event.start_time IS NOT NULL AND
      event.event_state = 'accepted' AND
      event.event_state_progress != 'canceled'
;

