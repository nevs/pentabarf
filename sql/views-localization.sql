
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

CREATE OR REPLACE VIEW view_conference_language AS
  SELECT language_id,
         conference_id,
         tag,
         name,
         translated_id
    FROM conference_language
         INNER JOIN view_language USING (language_id)
;
