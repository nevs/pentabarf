
-- view for events
CREATE OR REPLACE VIEW view_event AS
  SELECT event.event_id,
         event.conference_id,
         event.tag,
         event.title,
         event.subtitle,
         event.conference_track_id,
         event.conference_team,
         event.event_type,
         event.duration,
         event.event_state,
         event.event_state_progress,
         event.language_id,
         event.conference_room,
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
         event_type_localized.name AS event_type_name,
         view_conference_track.tag AS conference_track_tag,
         view_conference_track.name AS conference_track,
         conference.acronym,
         (conference.start_date + event.day + '-1'::integer + event.start_time + conference.day_change)::timestamp AS start_datetime,
         event.start_time + conference.day_change AS real_starttime,
         event_image.mime_type,
         mime_type.file_extension
    FROM event
         INNER JOIN event_state_localized USING (event_state)
         INNER JOIN conference USING (conference_id)
         LEFT OUTER JOIN event_type_localized ON (
             event.event_type = event_type_localized.event_type AND
             event_state_localized.language_id = event_type_localized.language_id)
         LEFT OUTER JOIN view_conference_track ON (
             event.conference_track_id = view_conference_track.conference_track_id AND
             view_conference_track.language_id = event_state_localized.language_id)
         LEFT OUTER JOIN event_image USING (event_id)
         LEFT OUTER JOIN mime_type USING (mime_type)
;

