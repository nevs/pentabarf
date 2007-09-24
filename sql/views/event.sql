
-- view for events
CREATE OR REPLACE VIEW view_event AS
  SELECT event.event_id,
         event.conference_id,
         event.tag,
         event.title,
         event.subtitle,
         event.conference_track_id,
         event.team_id,
         event.event_type_id,
         event.duration,
         event.event_state,
         event.event_state_progress,
         event.language_id,
         event.room_id,
         event.day,
         event.start_time,
         event.abstract,
         event.description,
         event.resources,
         event.f_public,
         event.f_paper,
         event.f_slides,
         event.remark,
         event_state_localized.language_id AS translated_id,
         event_state_localized.name AS event_state_name,
         view_event_type.tag AS event_type_tag,
         view_event_type.name AS event_type,
         view_conference_track.tag AS conference_track_tag,
         view_conference_track.name AS conference_track,
         view_team.tag AS team_tag,
         view_team.name as team,
         view_room.tag AS room_tag,
         view_room.name AS room,
         conference.acronym,
         (conference.start_date + event.day + '-1'::integer + event.start_time + conference.day_change)::timestamp AS start_datetime,
         event.start_time + conference.day_change AS real_starttime,
         event_image.mime_type_id,
         mime_type.mime_type,
         mime_type.file_extension
    FROM event
         INNER JOIN event_state_localized USING (event_state)
         INNER JOIN conference USING (conference_id)
         LEFT OUTER JOIN view_event_type ON (
             event.event_type_id = view_event_type.event_type_id AND
             event_state_localized.language_id = view_event_type.language_id)
         LEFT OUTER JOIN view_conference_track ON (
             event.conference_track_id = view_conference_track.conference_track_id AND
             view_conference_track.language_id = event_state_localized.language_id)
         LEFT OUTER JOIN view_team ON (
             event.team_id = view_team.team_id AND
             view_team.language_id = event_state_localized.language_id)
         LEFT OUTER JOIN view_room ON (
             event.room_id = view_room.room_id AND
             view_room.language_id = event_state_localized.language_id)
         LEFT OUTER JOIN event_image USING (event_id)
         LEFT OUTER JOIN mime_type USING (mime_type_id)
;

