
-- view for events
CREATE OR REPLACE VIEW view_visitor_schedule AS
   SELECT event.event_id,
          event.conference_id,
          event.tag,
          event.title,
          event.subtitle,
          event.conference_track_id,
          event.team_id,
          event.event_type_id,
          event.duration,
          event.event_state_id,
          event.language_id,
          event.room_id,
          event.day,
          event.start_time,
          event.abstract,
          event.description,
          event.f_public,
          view_language.tag AS language_tag,
          view_language.name AS language,
          event_state.tag AS event_state_tag,
          view_event_state_progress.event_state_progress_id,
          view_event_state_progress.tag AS event_state_progress_tag,
          view_event_state_progress.language_id AS translated_id,
          view_event_type.tag AS event_type_tag,
          view_event_type.name AS event_type,
          view_conference_track.tag AS conference_track_tag,
          view_conference_track.name AS conference_track,
          (conference.start_date + event.day + '-1'::integer + event.start_time + conference.day_change)::timestamp AS start_datetime,
          event.start_time + conference.day_change AS real_starttime,
          view_room.tag AS room_tag,
          view_room.name AS room
     FROM event
          INNER JOIN event_state USING (event_state_id)
          INNER JOIN view_event_state_progress USING (event_state_progress_id)
          INNER JOIN conference USING (conference_id)
          LEFT OUTER JOIN view_language ON (
              view_language.language_id = event.language_id AND
              view_language.translated_id = view_event_state_progress.language_id)
          LEFT OUTER JOIN view_event_type ON (
                event.event_type_id = view_event_type.event_type_id AND
                view_event_state_progress.language_id = view_event_type.language_id)
          LEFT OUTER JOIN view_conference_track ON (
                event.conference_track_id = view_conference_track.conference_track_id AND
                view_event_state_progress.language_id = view_conference_track.language_id)
          INNER JOIN view_room ON (
                event.room_id = view_room.room_id AND
                view_room.language_id = view_event_state_progress.language_id )
    WHERE event.day IS NOT NULL AND
          event.start_time IS NOT NULL AND
          event.room_id IS NOT NULL AND
          event_state.tag = 'accepted' AND
          view_event_state_progress.tag = 'confirmed'
;

