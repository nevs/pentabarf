
-- view for attachment_type with fallback to tag
CREATE OR REPLACE VIEW view_attachment_type AS 
  SELECT attachment_type_id, 
         language_id, 
         tag, 
         coalesce(name,tag) AS name, 
         rank, 
         language_tag
    FROM ( SELECT language_id, 
                  attachment_type_id, 
                  attachment_type.tag, 
                  attachment_type.rank, 
                  language.tag AS language_tag 
             FROM language 
                  CROSS JOIN attachment_type
            WHERE language.f_localized = 't'
         ) AS all_lang 
         LEFT OUTER JOIN attachment_type_localized USING (language_id, attachment_type_id);

-- view for conference_track with fallback to tag
CREATE OR REPLACE VIEW view_conference_track AS 
  SELECT conference_track_id, 
         conference_id, 
         language_id, 
         tag, 
         coalesce(name,tag) AS name, 
         rank, 
         language_tag 
    FROM ( SELECT language_id, 
                  conference_track_id, 
                  conference_track.conference_id, 
                  conference_track.tag, 
                  conference_track.rank, 
                  language.tag AS language_tag 
             FROM language 
                  CROSS JOIN conference_track
            WHERE language.f_localized = 't'
         ) AS all_lang 
         LEFT OUTER JOIN conference_track_localized USING (language_id, conference_track_id);

-- view for conference_phase with fallback to tag
CREATE OR REPLACE VIEW view_conference_phase AS 
  SELECT conference_phase_id, 
         language_id, 
         tag, 
         coalesce(name,tag) AS name, 
         rank, 
         language_tag
    FROM ( SELECT language_id, 
                  conference_phase_id, 
                  conference_phase.tag, 
                  conference_phase.rank, 
                  language.tag AS language_tag 
             FROM language 
                  CROSS JOIN conference_phase
            WHERE language.f_localized = 't'
         ) AS all_lang 
         LEFT OUTER JOIN conference_phase_localized USING (language_id, conference_phase_id);

-- view for conflicts with fallback to tag
CREATE OR REPLACE VIEW view_conflict AS 
  SELECT conflict_id, 
         language_id, 
         tag, 
         coalesce(name,tag) AS name, 
         language_tag
    FROM ( SELECT language_id, 
                  conflict_id, 
                  conflict.tag, 
                  language.tag AS language_tag 
             FROM language 
                  CROSS JOIN conflict
            WHERE language.f_localized = 't'
         ) AS all_lang 
         LEFT OUTER JOIN conflict_localized USING (language_id, conflict_id);

-- view for conflict_level with fallback to tag
CREATE OR REPLACE VIEW view_conflict_level AS 
  SELECT conflict_level_id, 
         language_id, 
         tag, 
         coalesce(name,tag) AS name, 
         rank, 
         language_tag
    FROM ( SELECT language_id, 
                  conflict_level_id, 
                  conflict_level.tag, 
                  conflict_level.rank, 
                  language.tag AS language_tag 
             FROM language 
                  CROSS JOIN conflict_level
            WHERE language.f_localized = 't'
         ) AS all_lang 
         LEFT OUTER JOIN conflict_level_localized USING (language_id, conflict_level_id);

-- view for country with fallback to tag
CREATE OR REPLACE VIEW view_country AS 
  SELECT country_id, 
         language_id, 
         tag, 
         coalesce(name,tag) AS name, 
         language_tag
    FROM ( SELECT language_id, 
                  country_id, 
                  country.iso_3166_code AS tag, 
                  country.phone_prefix, 
                  language.tag AS language_tag 
             FROM language 
                  CROSS JOIN country 
            WHERE language.f_localized = 't' AND
                  country.f_visible = 't' 
         ) AS all_lang 
         LEFT OUTER JOIN country_localized USING (language_id, country_id) 
    ORDER BY lower(name);

-- view for currency with fallback to tag
CREATE OR REPLACE VIEW view_currency AS 
  SELECT currency_id, 
         language_id, 
         tag, 
         coalesce(name,tag) AS name, 
         language_tag
    FROM ( SELECT language_id, 
                  currency_id, 
                  currency.iso_4217_code AS tag, 
                  currency.f_default, 
                  currency.exchange_rate, 
                  language.tag AS language_tag 
             FROM language 
                  CROSS JOIN currency 
            WHERE language.f_localized = 't' AND
                  currency.f_visible = 't' 
         ) AS all_lang 
         LEFT OUTER JOIN currency_localized USING (language_id, currency_id);

-- view for event_origin with fallback to tag
CREATE OR REPLACE VIEW view_event_origin AS 
  SELECT event_origin_id, 
         language_id, 
         tag, 
         coalesce(name,tag) AS name, 
         rank, 
         language_tag
    FROM ( SELECT language_id, 
                  event_origin_id, 
                  event_origin.tag, 
                  event_origin.rank, 
                  language.tag AS language_tag 
             FROM language 
                  CROSS JOIN event_origin
            WHERE language.f_localized = 't'
         ) AS all_lang 
         LEFT OUTER JOIN event_origin_localized USING (language_id, event_origin_id);

-- view for event_role with fallback to tag
CREATE OR REPLACE VIEW view_event_role AS 
  SELECT event_role_id, 
         language_id, 
         tag, 
         coalesce(name,tag) AS name, 
         rank, 
         language_tag
    FROM ( SELECT language_id, 
                  event_role_id, 
                  event_role.tag, 
                  event_role.rank, 
                  language.tag AS language_tag 
             FROM language 
                  CROSS JOIN event_role
            WHERE language.f_localized = 't'
         ) AS all_lang 
         LEFT OUTER JOIN event_role_localized USING (language_id, event_role_id);

-- view for event_role_state with fallback to tag
CREATE OR REPLACE VIEW view_event_role_state AS 
  SELECT event_role_state_id,
         event_role_id,
         language_id, 
         tag, 
         coalesce(name,tag) AS name, 
         rank, 
         language_tag
    FROM ( SELECT language_id, 
                  event_role_state_id, 
                  event_role_id, 
                  event_role_state.tag, 
                  event_role_state.rank, 
                  language.tag AS language_tag 
             FROM language 
                  CROSS JOIN event_role_state
            WHERE language.f_localized = 't'
         ) AS all_lang 
         LEFT OUTER JOIN event_role_state_localized USING (language_id, event_role_state_id);

-- view for event_state with fallback to tag
CREATE OR REPLACE VIEW view_event_state AS 
  SELECT event_state_id, 
         language_id, 
         tag, 
         coalesce(name,tag) AS name, 
         rank, 
         language_tag
    FROM ( SELECT language_id, 
                  event_state_id, 
                  event_state.tag, 
                  event_state.rank, 
                  language.tag AS language_tag 
             FROM language 
                  CROSS JOIN event_state
            WHERE language.f_localized = 't'
         ) AS all_lang 
         LEFT OUTER JOIN event_state_localized USING (language_id, event_state_id);

-- view for event_type with fallback to tag
CREATE OR REPLACE VIEW view_event_type AS 
  SELECT event_type_id, 
         language_id, 
         tag, 
         coalesce(name,tag) AS name, 
         rank, 
         language_tag
    FROM ( SELECT language_id, 
                  event_type_id, 
                  event_type.tag, 
                  event_type.rank, 
                  language.tag AS language_tag 
             FROM language 
                  CROSS JOIN event_type
            WHERE language.f_localized = 't'
         ) AS all_lang 
         LEFT OUTER JOIN event_type_localized USING (language_id, event_type_id);

-- view for event_state_progress with fallback to tag
CREATE OR REPLACE VIEW view_event_state_progress AS 
   SELECT event_state_progress_id, 
          event_state_id,
          language_id, 
          tag, 
          coalesce(name,tag) AS name, 
          rank, 
          language_tag
     FROM ( SELECT language_id, 
                   event_state_progress_id, 
                   event_state_id,
                   event_state_progress.tag, 
                   event_state_progress.rank, 
                   language.tag AS language_tag 
              FROM language 
                   CROSS JOIN event_state_progress
            WHERE language.f_localized = 't'
          ) AS all_lang 
          LEFT OUTER JOIN event_state_progress_localized USING (language_id, event_state_progress_id);

-- view for im_type with fallback to tag
CREATE OR REPLACE VIEW view_im_type AS 
  SELECT im_type_id, 
         language_id, 
         scheme, 
         tag, 
         coalesce(name,tag) AS name, 
         rank, 
         language_tag
    FROM ( SELECT language_id, 
                  im_type_id, 
                  im_type.scheme, 
                  im_type.tag, 
                  im_type.rank, 
                  language.tag AS language_tag 
             FROM language 
                  CROSS JOIN im_type
            WHERE language.f_localized = 't'
         ) AS all_lang 
         LEFT OUTER JOIN im_type_localized USING (language_id, im_type_id);
             
-- view for languages
CREATE OR REPLACE VIEW view_language AS
  SELECT language_id,
         iso_639_code,
         tag,
         f_default,
         f_localized,
         f_visible,
         f_preferred,
         coalesce(name,tag) AS name,
         translated_id,
         language_tag
    FROM ( SELECT language.language_id,
                  language.iso_639_code,
                  language.tag,
                  language.f_default,
                  language.f_localized,
                  language.f_visible,
                  language.f_preferred,
                  lang.language_id AS translated_id,
                  lang.tag AS language_tag
             FROM language 
                  CROSS JOIN language AS lang
            WHERE lang.f_localized = 't'
         ) AS all_lang
         LEFT OUTER JOIN language_localized USING (language_id, translated_id);
         
-- view for link_type with fallback to tag
CREATE OR REPLACE VIEW view_link_type AS 
  SELECT link_type_id, 
         language_id, 
         template, 
         tag, 
         coalesce(name,tag) AS name, 
         rank, 
         language_tag
    FROM ( SELECT language_id, 
                  link_type_id, 
                  link_type.template, 
                  link_type.tag, 
                  link_type.rank, 
                  language.tag AS language_tag 
             FROM language 
                  CROSS JOIN link_type
            WHERE language.f_localized = 't'
         ) AS all_lang 
         LEFT OUTER JOIN link_type_localized USING (language_id, link_type_id);
             
-- view for mime_type with fallback to tag
CREATE OR REPLACE VIEW view_mime_type AS 
  SELECT mime_type_id, 
         language_id, 
         tag,
         tag AS mime_type,
         coalesce(name,tag) AS name,
         file_extension,
         f_image,
         language_tag
    FROM ( SELECT language_id, 
                  mime_type_id, 
                  mime_type AS tag, 
                  file_extension,
                  f_image,
                  language.tag AS language_tag 
             FROM language 
                  CROSS JOIN mime_type
            WHERE language.f_localized = 't'
         ) AS all_lang 
         LEFT OUTER JOIN mime_type_localized USING (language_id, mime_type_id);

-- view for phone_type with fallback to tag
CREATE OR REPLACE VIEW view_phone_type AS 
  SELECT phone_type_id, 
         language_id, 
         scheme, 
         tag, 
         coalesce(name,tag) AS name, 
         rank, 
         language_tag
    FROM ( SELECT language_id, 
                  phone_type_id, 
                  phone_type.scheme, 
                  phone_type.tag, 
                  phone_type.rank, 
                  language.tag AS language_tag 
             FROM language 
                  CROSS JOIN phone_type
            WHERE language.f_localized = 't'
         ) AS all_lang 
         LEFT OUTER JOIN phone_type_localized USING (language_id, phone_type_id);

-- view for roles with fallback to tag
CREATE OR REPLACE VIEW view_role AS 
  SELECT role_id, 
         language_id, 
         tag, 
         coalesce(name,tag) AS name, 
         language_tag
    FROM ( SELECT language_id, 
                  role_id, 
                  role.tag, 
                  language.tag AS 
                  language_tag FROM 
                  language CROSS JOIN role
            WHERE language.f_localized = 't'
         ) AS all_lang 
         LEFT OUTER JOIN role_localized USING (language_id, role_id);

-- view for room with fallback to tag
CREATE OR REPLACE VIEW view_room AS 
  SELECT room_id, 
         conference_id, 
         language_id, 
         tag, 
         coalesce(public_name , tag) AS name, 
         f_public, 
         size, 
         remark, 
         rank, 
         language_tag
    FROM ( SELECT language_id, 
                  room.room_id, 
                  room.conference_id, 
                  room.short_name AS tag, 
                  room.f_public, 
                  room.size, 
                  room.remark, 
                  room.rank, 
                  language.tag AS language_tag 
             FROM language 
                  CROSS JOIN room
            WHERE language.f_localized = 't'
         ) AS all_lang 
         LEFT OUTER JOIN room_localized USING (language_id, room_id);

-- view for team with fallback to tag
CREATE OR REPLACE VIEW view_team AS 
  SELECT team_id, 
         conference_id,
         language_id, 
         tag, 
         coalesce(name,tag) AS name, 
         rank, 
         language_tag
    FROM ( SELECT language_id, 
                  team_id, 
                  conference_id, 
                  team.tag, 
                  team.rank, 
                  language.tag AS language_tag 
             FROM language 
                  CROSS JOIN team
            WHERE language.f_localized = 't'
         ) AS all_lang 
         LEFT OUTER JOIN team_localized USING (language_id, team_id);

-- view for time_zone with fallback to tag
CREATE OR REPLACE VIEW view_time_zone AS 
  SELECT time_zone_id, 
         language_id, 
         tag, 
         coalesce(name,tag) AS name, 
         language_tag
    FROM ( SELECT language_id, 
                  time_zone_id, 
                  time_zone.tag, 
                  language.tag AS language_tag 
             FROM language 
                  CROSS JOIN time_zone 
            WHERE language.f_localized = 't'
         ) AS all_lang 
         LEFT OUTER JOIN time_zone_localized USING (language_id, time_zone_id);

-- view for transport with fallback to tag
CREATE OR REPLACE VIEW view_transport AS 
  SELECT transport_id, 
         language_id, 
         tag, 
         coalesce(name,tag) AS name, 
         rank, 
         language_tag
    FROM ( SELECT language_id, 
                  transport_id, 
                  transport.tag, 
                  transport.rank, 
                  language.tag AS language_tag 
             FROM language 
                  CROSS JOIN transport
            WHERE language.f_localized = 't'
         ) AS all_lang 
         LEFT OUTER JOIN transport_localized USING (language_id, transport_id);

-- view for ui_messages with fallback to tag
CREATE OR REPLACE VIEW view_ui_message AS 
  SELECT ui_message_id, 
         language_id, 
         tag, 
         coalesce(name,tag) AS name, 
         language_tag
    FROM ( SELECT language_id, 
                  ui_message_id, 
                  ui_message.tag, 
                  language.tag AS language_tag 
             FROM language 
                  CROSS JOIN ui_message
            WHERE language.f_localized = 't'
         ) AS all_lang 
         LEFT OUTER JOIN ui_message_localized USING (language_id, ui_message_id);

CREATE OR REPLACE VIEW view_conference_language AS
  SELECT language_id,
         conference_id,
         tag,
         name,
         translated_id
    FROM conference_language
         INNER JOIN view_language USING (language_id)
;
