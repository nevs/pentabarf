
-- view for events
CREATE OR REPLACE VIEW view_schedule AS
   SELECT event.event_id,
          event.conference_id,
          event.tag,
          event.title,
          event.subtitle,
          event.conference_track_id,
          event.team_id,
          event.event_type,
          event.duration,
          event.event_state,
          event.event_state_progress,
          event.language_id,
          event.room_id,
          event.day,
          event.start_time,
          event.abstract,
          event.description,
          event.f_public,
          view_language.tag AS language_tag,
          view_language.name AS language,
          event_type_localized.name AS event_type_name,
          view_conference_track.tag AS conference_track_tag,
          view_conference_track.name AS conference_track,
          (conference.start_date + event.day + '-1'::integer + event.start_time + conference.day_change)::timestamp AS start_datetime,
          event.start_time + conference.day_change AS real_starttime,
          view_room.language_id AS translated_id,
          view_room.tag AS room_tag,
          view_room.name AS room,
          array_to_string(
            ARRAY(
              SELECT view_person.name || ' (' || event_role_localized.name || ')'
                FROM event_person
                INNER JOIN event_role USING(event_role)
                JOIN event_role_localized ON (
                  event_role_localized.language_id = view_room.language_id AND
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
          INNER JOIN conference USING (conference_id)
          INNER JOIN view_room USING (room_id)
          LEFT OUTER JOIN view_language ON (
              view_language.translated_id = view_room.language_id AND
              view_language.language_id = event.language_id )
          LEFT OUTER JOIN event_type_localized ON (
                event.event_type = event_type_localized.event_type AND
                view_room.language_id = event_type_localized.language_id)
          LEFT OUTER JOIN view_conference_track ON (
                event.conference_track_id = view_conference_track.conference_track_id AND
                view_room.language_id = view_conference_track.language_id)
    WHERE event.day IS NOT NULL AND
          event.start_time IS NOT NULL AND
          event.room_id IS NOT NULL AND
          event.event_state = 'accepted' AND
          event.event_state_progress != 'canceled'
;

