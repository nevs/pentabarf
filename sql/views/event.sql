
-- view for events
CREATE OR REPLACE VIEW view_event AS
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
         event.conference_day,
         conference_day.name AS conference_day_name,
         event.start_time,
         event.abstract,
         event.description,
         event.resources,
         event.public,
         event.paper,
         event.slides,
         event.remark,
         event_state_localized.translated,
         event_state_localized.name AS event_state_name,
         event_type_localized.name AS event_type_name,
         conference.acronym,
         (event.conference_day + event.start_time + conference.day_change)::timestamp AS start_datetime,
         event.start_time + conference.day_change AS real_starttime,
         event_image.mime_type,
         mime_type.file_extension
    FROM event
         INNER JOIN event_state_localized USING (event_state)
         INNER JOIN conference USING (conference_id)
         LEFT OUTER JOIN conference_day USING (conference_id, conference_day)
         LEFT OUTER JOIN event_type_localized USING (event_type,translated)
         LEFT OUTER JOIN event_image USING (event_id)
         LEFT OUTER JOIN mime_type USING (mime_type)
;

