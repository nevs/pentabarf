
-- view for events
CREATE OR REPLACE VIEW view_schedule AS
   SELECT event.event_id,
          event.conference_id,
          event.tag,
          event.title,
          event.subtitle,
          event.conference_track,
          event.conference_team,
          event.event_type,
          event.duration,
          event.event_state,
          event.event_state_progress,
          event.language,
          event.conference_room,
          event.day,
          event.start_time,
          event.abstract,
          event.description,
          event.public,
          translated.language AS translated,
          language_localized.name AS language_name,
          event_type_localized.name AS event_type_name,
          (conference.start_date + event.day + '-1'::integer + event.start_time + conference.day_change)::timestamp AS start_datetime,
          event.start_time + conference.day_change AS real_starttime,
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
                ORDER BY event_role.rank, view_person.name
            ),
            ', '
          ) AS persons
     FROM event
          CROSS JOIN language AS translated
          INNER JOIN conference USING (conference_id)
          LEFT OUTER JOIN language_localized ON (
              language_localized.translated = translated.language AND
              language_localized.language = event.language )
          LEFT OUTER JOIN event_type_localized USING (event_type,translated)
    WHERE event.day IS NOT NULL AND
          event.start_time IS NOT NULL AND
          event.conference_room IS NOT NULL AND
          event.event_state = 'accepted' AND
          event.event_state_progress != 'canceled'
;

