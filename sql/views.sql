-- view for persons with name
CREATE OR REPLACE VIEW view_person AS
  SELECT person_id,
         login_name,
         coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname, person.login_name) AS name,
         password,
         title,
         gender,
         first_name,
         middle_name,
         last_name,
         public_name,
         nickname,
         address,
         street,
         street_postcode,
         po_box,
         po_box_postcode,
         city,
         country_id,
         email_contact,
         iban,
         bic,
         bank_name,
         account_owner,
         gpg_key,
         preferences,
         f_conflict,
         f_deleted,
         f_spam,
         last_login
    FROM person;

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
         event.event_state_id,
         event.event_state_progress_id,
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
         event.f_conflict,
         event.f_deleted,
         event.remark,
         view_event_state.language_id AS translated_id,
         view_event_state.language_tag AS translated_tag,
         view_event_state.tag AS event_state_tag,
         view_event_state.name AS event_state,
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
         INNER JOIN view_event_state USING (event_state_id)
         INNER JOIN conference USING (conference_id)
         LEFT OUTER JOIN view_event_type ON (
             event.event_type_id = view_event_type.event_type_id AND
             view_event_state.language_id = view_event_type.language_id)
         LEFT OUTER JOIN view_conference_track ON (
             event.conference_track_id = view_conference_track.conference_track_id AND
             view_conference_track.language_id = view_event_state.language_id)
         LEFT OUTER JOIN view_team ON (
             event.team_id = view_team.team_id AND
             view_team.language_id = view_event_state.language_id)
         LEFT OUTER JOIN view_room ON (
             event.room_id = view_room.room_id AND
             view_room.language_id = view_event_state.language_id)
         LEFT OUTER JOIN event_image USING (event_id)
         LEFT OUTER JOIN mime_type USING (mime_type_id)
;

CREATE OR REPLACE VIEW view_event_attachment AS
  SELECT event_attachment_id,
         attachment_type_id,
         view_attachment_type.name AS attachment_type,
         view_attachment_type.tag AS attachment_type_tag,
         event_id,
         conference_id,
         mime_type_id,
         mime_type AS mime_type_tag,
         view_mime_type.name AS mime_type,
         filename,
         title,
         pages,
         f_public,
         last_modified,
         octet_length( data ) AS filesize,
         view_attachment_type.language_id
    FROM event_attachment
         INNER JOIN (
             SELECT event_id,
                    conference_id
               FROM event
         ) AS event USING (event_id)
         INNER JOIN view_attachment_type USING (attachment_type_id)
         INNER JOIN view_mime_type USING (mime_type_id, language_id)
;

-- view for last active user
CREATE OR REPLACE VIEW view_last_active AS
  SELECT person_id,
         login_name,
         name,
         last_login,
         now() - last_login AS login_diff
    FROM view_person
    WHERE last_login > now() + '-1 hour'::interval
    ORDER BY last_login DESC;

-- view for recent changes
CREATE OR REPLACE VIEW view_recent_changes AS
  SELECT 'conference' AS type,
         conference_transaction.conference_id AS id,
         conference.acronym,
         conference.title AS title,
         conference_transaction.changed_when,
         conference_transaction.changed_by,
         view_person.name,
         conference_transaction.f_create
    FROM conference_transaction
         INNER JOIN conference USING (conference_id)
         INNER JOIN view_person ON (conference_transaction.changed_by = view_person.person_id)
UNION
  SELECT 'event' AS type,
         event_transaction.event_id AS id,
         conference.acronym,
         event.title AS title,
         event_transaction.changed_when,
         event_transaction.changed_by,
         view_person.name,
         event_transaction.f_create
    FROM event_transaction
         INNER JOIN event USING (event_id)
         INNER JOIN conference USING (conference_id)
         INNER JOIN view_person ON (event_transaction.changed_by = view_person.person_id)
UNION
  SELECT 'person' AS type,
         person_transaction.person_id AS id,
         '' AS acronym,
         person.name AS title ,
         person_transaction.changed_when,
         person_transaction.changed_by,
         view_person.name,
         person_transaction.f_create
    FROM person_transaction
         INNER JOIN view_person AS person USING (person_id)
         INNER JOIN view_person ON (person_transaction.changed_by = view_person.person_id)
ORDER BY changed_when DESC;

-- view for event_persons
CREATE OR REPLACE VIEW view_event_person AS
  SELECT event_person.event_person_id,
         event_person.event_id,
         event_person.person_id,
         event_person.event_role_id,
         event_person.event_role_state_id,
         event_person.remark,
         event_person.rank,
         event.title,
         event.subtitle,
         event.event_state_id,
         conference.conference_id,
         conference.acronym,
         view_person.name,
         view_event_state.language_id,
         view_event_state.language_tag,
         view_event_state.tag AS event_state_tag,
         view_event_state.name AS event_state,
         view_event_state_progress.tag AS event_state_progress_tag,
         view_event_state_progress.name AS event_state_progress,
         view_event_role.tag AS event_role_tag,
         view_event_role.name AS event_role,
         view_event_role_state.tag AS event_role_state_tag,
         view_event_role_state.name AS event_role_state
    FROM event_person
         INNER JOIN event USING (event_id)
         INNER JOIN conference USING (conference_id)
         INNER JOIN view_person USING (person_id)
         INNER JOIN view_event_state USING (event_state_id)
         INNER JOIN view_event_state_progress ON (
               view_event_state_progress.event_state_progress_id = event.event_state_progress_id AND
               view_event_state_progress.language_id = view_event_state.language_id)
         INNER JOIN view_event_role ON (
               view_event_role.event_role_id = event_person.event_role_id AND
               view_event_state.language_id = view_event_role.language_id)
         LEFT OUTER JOIN view_event_role_state ON (
               event_person.event_role_state_id = view_event_role_state.event_role_state_id AND
               view_event_state.language_id = view_event_role_state.language_id);

CREATE OR REPLACE VIEW view_event_person_simple_person AS
  SELECT event_person.person_id,
         event_person.event_id,
         view_person.name,
         event_role.event_role_id,
         event_role.tag AS event_role_tag,
         event_role_state.event_role_state_id,
         event_role_state.tag AS event_role_state_tag
    FROM event_person
         INNER JOIN view_person USING (person_id)
         INNER JOIN event_role USING (event_role_id)
         INNER JOIN event_role_state USING (event_role_state_id);

CREATE OR REPLACE VIEW view_find_conference AS
  SELECT conference.conference_id,
         conference.acronym,
         conference.title,
         conference.subtitle,
         conference.start_date,
         conference.days,
         conference.venue,
         conference.city,
         conference_image.mime_type_id,
         mime_type.mime_type,
         mime_type.file_extension
    FROM conference
         LEFT OUTER JOIN conference_image USING (conference_id)
         LEFT OUTER JOIN mime_type USING (mime_type_id);

CREATE OR REPLACE VIEW view_find_event AS
  SELECT event.event_id,
         event.conference_id,
         event.title,
         event.subtitle,
         event.abstract,
         event.description,
         event.duration,
         event.event_origin_id,
         event.conference_track_id,
         event.event_state_id,
         event.event_state_progress_id,
         event.language_id,
         event.room_id,
         event.day,
         (event.start_time + conference.day_change)::interval AS start_time,
         event.f_public,
         event_image.mime_type_id,
         mime_type.mime_type,
         mime_type.file_extension,
         view_event_state.language_id AS translated_id,
         view_event_state.tag AS event_state_tag,
         view_event_state.name AS event_state,
         view_event_state_progress.tag AS event_state_progress_tag,
         view_event_state_progress.name AS event_state_progress,
         view_room.tag AS room_tag,
         view_room.name AS room
    FROM event
         INNER JOIN conference USING (conference_id)
         INNER JOIN view_event_state USING (event_state_id)
         INNER JOIN view_event_state_progress ON (
             view_event_state.language_id = view_event_state_progress.language_id AND
             event.event_state_progress_id = view_event_state_progress.event_state_progress_id)
         LEFT OUTER JOIN event_image USING (event_id)
         LEFT OUTER JOIN mime_type USING (mime_type_id)
         LEFT OUTER JOIN view_room ON (
             view_event_state.language_id = view_room.language_id AND
             event.room_id = view_room.room_id);

CREATE OR REPLACE VIEW view_find_person AS
  SELECT view_person.person_id,
         view_person.name,
         view_person.first_name,
         view_person.last_name,
         view_person.nickname,
         view_person.public_name,
         view_person.login_name,
         view_person.email_contact,
         view_person.gender,
         person_image.mime_type_id,
         mime_type.mime_type,
         mime_type.file_extension,
         conference_person.conference_id
    FROM view_person
         LEFT OUTER JOIN conference_person USING (person_id)
         LEFT OUTER JOIN person_image USING (person_id)
         LEFT OUTER JOIN mime_type USING (mime_type_id);

CREATE OR REPLACE VIEW view_conference_image AS
  SELECT conference_image.conference_id,
         conference_image.mime_type_id,
         mime_type.mime_type,
         conference_image.image,
         conference_image.last_modified
    FROM conference_image
         INNER JOIN mime_type USING (mime_type_id);

CREATE OR REPLACE VIEW view_event_image AS
  SELECT event_image.event_id,
         event_image.mime_type_id,
         mime_type.mime_type,
         event_image.image,
         event_image.last_modified
    FROM event_image
         INNER JOIN mime_type USING (mime_type_id);

CREATE OR REPLACE VIEW view_person_image AS
  SELECT person_image.person_id,
         person_image.mime_type_id,
         mime_type.mime_type,
         person_image.image,
         person_image.last_modified
    FROM person_image
         INNER JOIN mime_type USING (mime_type_id);

CREATE OR REPLACE VIEW view_conference_image_modification AS
  SELECT conference_image.conference_id,
         conference_image.last_modified
    FROM conference_image;

CREATE OR REPLACE VIEW view_event_image_modification AS
  SELECT event_image.event_id,
         event_image.last_modified
    FROM event_image;

CREATE OR REPLACE VIEW view_person_image_modification AS
  SELECT person_image.person_id,
         person_image.last_modified
    FROM person_image;

CREATE OR REPLACE VIEW view_event_link_internal AS
  SELECT event_link_internal_id,
         event_id,
         link_type_id,
         url,
         description,
         event_link_internal.rank,
         language_id,
         template,
         tag,
         name
  FROM event_link_internal
       INNER JOIN view_link_type USING (link_type_id);

CREATE OR REPLACE VIEW view_conference_person_link_internal AS
  SELECT conference_person_link_internal_id,
         conference_person_id,
         link_type_id,
         url,
         description,
         conference_person_link_internal.rank,
         language_id,
         template,
         tag,
         name
    FROM conference_person_link_internal
         INNER JOIN view_link_type USING (link_type_id);

CREATE OR REPLACE VIEW view_person_rating AS
  SELECT person_rating.person_id,
         person_rating.evaluator_id,
         person_rating.speaker_quality,
         person_rating.competence,
         person_rating.remark,
         person_rating.eval_time,
         view_person.name
    FROM person_rating
         INNER JOIN view_person ON (person_rating.evaluator_id = view_person.person_id)
    ORDER BY person_rating.eval_time DESC;

CREATE OR REPLACE VIEW view_event_rating AS
  SELECT event_rating.event_id,
         event_rating.person_id,
         event_rating.relevance,
         event_rating.actuality,
         event_rating.acceptance,
         event_rating.remark,
         event_rating.eval_time,
         view_person.name
    FROM event_rating
         INNER JOIN view_person USING (person_id)
    ORDER BY event_rating.eval_time DESC;

CREATE OR REPLACE VIEW view_event_related AS
  SELECT event_id1,
         event_id2 AS event_id,
         title,
         subtitle
    FROM event_related
         INNER JOIN event ON (event_related.event_id2 = event.event_id);

CREATE OR REPLACE VIEW view_event_state_combined AS
  SELECT view_event_state_progress.event_state_progress_id,
         view_event_state_progress.event_state_id,
         view_event_state_progress.tag AS event_state_progress_tag,
         view_event_state_progress.language_id,
         view_event_state.tag AS event_state_tag,
         view_event_state.name || ' ' || view_event_state_progress.name AS name,
         view_event_state.rank AS event_state_rank,
         view_event_state_progress.rank AS event_state_progress_rank
    FROM view_event_state_progress
         INNER JOIN view_event_state USING (event_state_id, language_id) ORDER BY event_state_rank,event_state_progress_rank;

CREATE OR REPLACE VIEW view_jid_login AS
  SELECT person_im_id,
         person_id,
         im_address,
         view_person.name,
         view_person.preferences
    FROM person_im
         INNER JOIN im_type USING (im_type_id)
         INNER JOIN view_person USING (person_id)
   WHERE im_type.tag = 'jabber';


-- view for events
CREATE OR REPLACE VIEW view_schedule AS
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
                view_room.language_id = view_event_state_progress.language_id AND
                view_room.f_public = 't' )
    WHERE event.day IS NOT NULL AND
          event.start_time IS NOT NULL AND
          event.room_id IS NOT NULL AND
          event_state.tag = 'accepted' AND
          view_event_state_progress.tag != 'canceled'
;

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

CREATE OR REPLACE VIEW view_report_expenses AS
  SELECT person_id,
         view_person.name,
         conference_id,
         travel_cost,
         travel_currency_id,
         travel_currency.name AS travel_currency_name,
         accommodation_cost,
         accommodation_currency_id,
         accommodation_currency.name AS accommodation_currency_name,
         fee,
         fee_currency_id,
         fee_currency.name AS fee_currency_name,
         travel_currency.language_id
    FROM person_travel
         INNER JOIN view_person USING (person_id)
         INNER JOIN view_currency AS travel_currency ON (
             person_travel.travel_currency_id = travel_currency.currency_id)
         INNER JOIN view_currency AS accommodation_currency ON (
             person_travel.accommodation_currency_id = accommodation_currency.currency_id AND
             accommodation_currency.language_id = travel_currency.language_id)
         INNER JOIN view_currency AS fee_currency ON (
             person_travel.fee_currency_id = fee_currency.currency_id AND
             fee_currency.language_id = travel_currency.language_id)
   WHERE ( f_need_travel_cost = 't' OR
           f_need_accommodation_cost = 't' OR
           travel_cost IS NOT NULL OR
           accommodation_cost IS NOT NULL OR
           fee IS NOT NULL )
;

CREATE OR REPLACE VIEW view_report_pickup AS
  SELECT person_id,
         conference_id,
         language_id,
         view_person.name,
         'arrival' AS "type",
         arrival_from AS "from",
         arrival_to AS "to",
         arrival_transport_id AS transport_id,
         view_transport.name AS transport,
         view_transport.tag AS transport_tag,
         arrival_date AS "date",
         arrival_time AS "time",
         arrival_number AS "number"
    FROM person_travel
         INNER JOIN view_person USING (person_id)
         LEFT OUTER JOIN view_transport ON (
             person_travel.arrival_transport_id = view_transport.transport_id )
   WHERE f_arrival_pickup = 't'
UNION
 (SELECT person_id,
         conference_id,
         language_id,
         view_person.name,
         'departure' AS "type",
         departure_from AS "from",
         departure_to AS "to",
         departure_transport_id AS transport_id,
         view_transport.name AS transport,
         view_transport.tag AS transport_tag,
         departure_date AS "date",
         departure_time AS "time",
         departure_number AS "number"
    FROM person_travel
         INNER JOIN view_person USING (person_id)
         LEFT OUTER JOIN view_transport ON (
             departure_transport_id = view_transport.transport_id )
   WHERE f_departure_pickup = 't')
;

CREATE OR REPLACE VIEW view_event_rating_public AS
  SELECT event_rating_public.event_id,
         event.conference_id,
         event_rating_public.participant_knowledge,
         event_rating_public.topic_importance,
         event_rating_public.content_quality,
         event_rating_public.presentation_quality,
         event_rating_public.audience_involvement,
         event_rating_public.remark,
         event_rating_public.eval_time,
         event_rating_public.rater_ip
    FROM event_rating_public
         INNER JOIN event USING (event_id)
;

CREATE OR REPLACE VIEW view_report_paper AS
  SELECT event_id,
         conference_id,
         title,
         subtitle,
         f_paper,
         (SELECT count(event_attachment_id)
            FROM event_attachment
                 INNER JOIN attachment_type USING (attachment_type_id)
           WHERE event_id = event.event_id AND
                 attachment_type.tag = 'paper')
         AS paper_submitted,
         (SELECT sum(pages)
           FROM event_attachment
                INNER JOIN attachment_type USING (attachment_type_id)
          WHERE event_id = event.event_id AND
                attachment_type.tag = 'paper')
         AS pages
    FROM event
         INNER JOIN event_state USING (event_state_id)
         INNER JOIN event_state_progress USING (event_state_progress_id)
   WHERE event_state.tag = 'accepted' AND
         event.f_paper = 't'
   ORDER BY lower(title), lower(subtitle)
;

CREATE OR REPLACE VIEW view_report_schedule_gender AS
  SELECT DISTINCT ON (person_id, conference_id)
         person_id,
         conference_id,
         gender
    FROM event_person
         INNER JOIN person USING (person_id)
         INNER JOIN event USING (event_id)
         INNER JOIN event_state USING (event_state_id)
         INNER JOIN event_role USING (event_role_id)
         INNER JOIN event_role_state USING (event_role_state_id)
   WHERE event_state.tag = 'accepted' AND
         event_role.tag IN ('speaker','moderator') AND
         event_role_state.tag = 'confirmed'
;

CREATE OR REPLACE VIEW view_report_schedule_coordinator AS
  SELECT count(person_id) AS count,
         person_id,
         conference_id,
         name
    FROM event_person
         INNER JOIN event USING (event_id)
         INNER JOIN event_state ON (
             event.event_state_id = event_state.event_state_id AND
             event_state.tag = 'accepted' )
         INNER JOIN event_role ON (
             event_person.event_role_id = event_role.event_role_id AND
             event_role.tag = 'coordinator' )
         INNER JOIN view_person USING (person_id)
   GROUP BY person_id, name, conference_id
   ORDER BY count(person_id) DESC
;

CREATE OR REPLACE VIEW view_schedule_person AS
  SELECT view_person.person_id,
         view_person.name,
         speaker.event_id,
         speaker.title,
         speaker.subtitle,
         speaker.conference_id,
         conference_person.conference_person_id,
         conference_person.abstract,
         conference_person.description,
         conference_person.email_public,
         person_image.f_public,
         person_image.file_extension
    FROM view_person
         LEFT OUTER JOIN (
             SELECT person_id,
                    f_public,
                    file_extension
               FROM person_image
                    INNER JOIN mime_type USING (mime_type_id)
              WHERE f_public = 't'
         ) AS person_image USING (person_id)
         INNER JOIN (
             SELECT event_person.person_id,
                    event.conference_id,
                    event.event_id,
                    event.title,
                    event.subtitle
               FROM event_person
                    INNER JOIN event_role ON (
                        event_person.event_role_id = event_role.event_role_id AND
                        event_role.tag IN ('speaker', 'moderator'))
                    INNER JOIN event_role_state ON (
                        event_person.event_role_state_id = event_role_state.event_role_state_id AND
                        event_role_state.event_role_id = event_role.event_role_id AND
                        event_role_state.tag = 'confirmed' )
                    INNER JOIN event ON (
                        event_person.event_id = event.event_id AND
                        event.f_public = 't' AND
                        event.day IS NOT NULL AND
                        event.start_time IS NOT NULL AND
                        event.room_id IS NOT NULL )
                    INNER JOIN room ON (
                        event.room_id = room.room_id AND
                        room.f_public = 't' )
                    INNER JOIN event_state ON (
                        event.event_state_id = event_state.event_state_id AND
                        event_state.tag = 'accepted' )
                    INNER JOIN event_state_progress ON (
                        event.event_state_progress_id = event_state_progress.event_state_progress_id AND
                        event_state_progress.event_state_id = event.event_state_id AND
                        event_state_progress.tag = 'confirmed' )
         ) AS speaker USING (person_id)
         LEFT OUTER JOIN conference_person USING (person_id, conference_id)
;

CREATE OR REPLACE VIEW view_schedule_event AS
  SELECT event.event_id,
         event.conference_id,
         event.tag AS event_tag,
         event.title,
         event.subtitle,
         event.abstract,
         event.description,
         event.day,
         event.duration,
         event.start_time,
         (conference.start_date + event.day + '-1'::integer + event.start_time + conference.day_change)::timestamp AS start_datetime,
         (conference.start_date + event.day + '-1'::integer + event.start_time + conference.day_change + event.duration)::timestamp AS end_datetime,
         event.start_time + conference.day_change AS real_starttime,
         view_event_state.language_id AS translated_id,
         view_event_type.event_type_id,
         view_event_type.name AS event_type,
         view_event_type.tag AS event_type_tag,
         view_conference_track.conference_track_id,
         view_conference_track.name AS conference_track,
         view_conference_track.tag AS conference_track_tag,
         view_language.language_id,
         view_language.name AS language,
         view_language.tag AS language_tag,
         speaker.person_id,
         speaker.name,
         event_image.file_extension,
         view_room.room_id,
         view_room.tag AS room_tag,
         view_room.name AS room
    FROM event_person
         LEFT OUTER JOIN (
             SELECT event_id,
                    file_extension
               FROM event_image
                    INNER JOIN mime_type USING (mime_type_id)
         ) AS event_image USING (event_id)
         INNER JOIN event ON (
             event.event_id = event_person.event_id AND
             event.f_public = 't' AND
             event.day IS NOT NULL AND
             event.start_time IS NOT NULL AND
             event.room_id IS NOT NULL )
         INNER JOIN conference USING (conference_id)
         INNER JOIN view_event_state ON (
             view_event_state.event_state_id = event.event_state_id AND
             view_event_state.tag = 'accepted' )
         INNER JOIN view_room ON (
             view_room.language_id = view_event_state.language_id AND
             view_room.room_id = event.room_id AND
             view_room.f_public = 't' )
         INNER JOIN event_state_progress ON (
             event_state_progress.event_state_progress_id = event.event_state_progress_id AND
             event_state_progress.tag = 'confirmed')
         INNER JOIN event_role ON (
             event_person.event_role_id = event_role.event_role_id AND
             event_role.tag IN ('speaker', 'moderator') )
         INNER JOIN event_role_state ON (
             event_person.event_role_state_id = event_role_state.event_role_state_id AND
             event_role_state.tag = 'confirmed' )
         INNER JOIN (
             SELECT person_id,
                    name
               FROM view_person
         ) AS speaker USING (person_id)
         LEFT OUTER JOIN view_conference_track ON (
             view_conference_track.conference_track_id = event.conference_track_id AND
             view_conference_track.language_id = view_event_state.language_id)
         LEFT OUTER JOIN view_event_type ON (
             view_event_type.event_type_id = event.event_type_id AND
             view_event_type.language_id = view_event_state.language_id)
         LEFT OUTER JOIN view_language ON (
             view_language.language_id = event.language_id AND
             view_language.translated_id = view_event_state.language_id)
;

CREATE OR REPLACE VIEW view_review AS
  SELECT event.event_id,
         event.conference_id,
         event.title,
         event.subtitle,
         event.event_state_id,
         event.event_state_progress_id,
         rating.relevance,
         rating.relevance_count,
         rating.actuality,
         rating.actuality_count,
         rating.acceptance,
         rating.acceptance_count,
         view_event_state.language_id AS translated_id,
         view_event_state.tag AS event_state_tag,
         view_event_state.name AS event_state,
         view_event_state_progress.tag AS event_state_progress_tag,
         view_event_state_progress.name AS event_state_progress,
         view_conference_track.tag AS conference_track_tag,
         view_conference_track.name AS conference_track
    FROM event
         INNER JOIN (
           SELECT event_id,
                  coalesce( sum((relevance - 3) * 50 )/ count(relevance), 0) AS relevance,
                  count(relevance) AS relevance_count,
                  coalesce( sum((actuality - 3) * 50 )/ count(actuality), 0) AS actuality,
                  count(actuality) AS actuality_count,
                  coalesce( sum((acceptance - 3) * 50 ) / count(acceptance), 0) AS acceptance,
                  count(acceptance) AS acceptance_count
             FROM event_rating
            GROUP BY event_id
         ) AS rating USING (event_id)
         INNER JOIN view_event_state USING (event_state_id)
         INNER JOIN view_event_state_progress ON (
           view_event_state.language_id = view_event_state_progress.language_id AND
           event.event_state_progress_id = view_event_state_progress.event_state_progress_id )
         LEFT OUTER JOIN view_conference_track ON (
           view_event_state.language_id = view_conference_track.language_id AND
           event.conference_track_id = view_conference_track.conference_track_id)
   ORDER BY acceptance DESC, relevance DESC, actuality DESC
;

CREATE OR REPLACE VIEW view_conference_person AS
  SELECT conference_person_id,
         person_id,
         conference_id,
         name,
         abstract,
         description,
         remark,
         email_public
    FROM conference_person
         INNER JOIN view_person USING (person_id)
;

CREATE OR REPLACE VIEW view_report_arrived AS
  SELECT view_person.person_id,
         view_person.name,
         person_travel.conference_id,
         person_travel.f_arrived
    FROM view_person
         INNER JOIN person_travel USING (person_id)
   WHERE EXISTS (SELECT 1
                   FROM event_person
                        INNER JOIN event ON (
                          event_person.event_id = event.event_id AND
                          event.conference_id = person_travel.conference_id)
                        INNER JOIN event_state ON (
                          event.event_state_id = event_state.event_state_id AND
                          event_state.tag = 'accepted')
                        INNER JOIN event_state_progress ON (
                          event.event_state_progress_id = event_state_progress.event_state_progress_id AND
                          event_state_progress.tag = 'confirmed')
                        INNER JOIN event_role ON (
                          event_person.event_role_id = event_role.event_role_id AND
                          event_role.tag IN ('speaker', 'moderator'))
                        INNER JOIN event_role_state ON (
                          event_role_state.event_role_state_id = event_person.event_role_state_id AND
                          event_role_state.tag = 'confirmed')
                  WHERE event_person.person_id = view_person.person_id)
   ORDER BY lower(name)
;

CREATE OR REPLACE VIEW view_report_feedback AS
  SELECT event_id,
         conference_id,
         title,
         subtitle,
         count(event_id) AS votes,
         count(event_rating_public.remark) AS comments,
         sum(4 * coalesce(participant_knowledge,0))/(CASE count(participant_knowledge) WHEN 0 THEN 1 ELSE count(participant_knowledge) END) AS participant_knowledge,
         sum(4 * coalesce(topic_importance,0))/(CASE count(topic_importance) WHEN 0 THEN 1 ELSE count(topic_importance) END) AS topic_importance,
         sum(4 * coalesce(content_quality,0))/(CASE count(content_quality) WHEN 0 THEN 1 ELSE count(content_quality) END) AS content_quality,
         sum(4 * coalesce(presentation_quality,0))/(CASE count(presentation_quality) WHEN 0 THEN 1 ELSE count(presentation_quality) END) AS presentation_quality,
         sum(4 * coalesce(audience_involvement,0))/(CASE count(audience_involvement) WHEN 0 THEN 1 ELSE count(audience_involvement) END) AS audience_involvement
    FROM event_rating_public
         INNER JOIN event USING (event_id)
   GROUP BY event_id, conference_id, title, subtitle
;

-- returns all speakers of all conferences
CREATE OR REPLACE VIEW view_mail_all_speaker AS
  SELECT DISTINCT ON ( person.person_id )
         person.person_id,
         view_person.name,
         view_person.email_contact
    FROM event_person
         INNER JOIN event_role ON (
             event_role.event_role_id = event_person.event_role_id AND
             event_role.tag IN ('speaker', 'moderator') )
         INNER JOIN person ON (
             person.person_id = event_person.person_id AND 
             person.email_contact IS NOT NULL AND
             person.f_spam = true )
         INNER JOIN view_person ON (
             view_person.person_id = event_person.person_id AND
             view_person.email_contact IS NOT NULL )
;

-- returns all accepted speakers of accepted and confirmed events
CREATE OR REPLACE VIEW view_mail_accepted_speaker AS
  SELECT view_person.person_id,
         view_person.name,
         view_person.email_contact,
         event.event_id,
         event.title AS event_title,
         event.subtitle AS event_subtitle,
         conference.conference_id,
         conference.acronym AS conference_acronym,
         conference.title AS conference_title
    FROM event_person
         INNER JOIN view_person ON (
             view_person.person_id = event_person.person_id AND
             view_person.email_contact IS NOT NULL )
         INNER JOIN event_role ON (
             event_role.event_role_id = event_person.event_role_id AND
             event_role.tag IN ('speaker', 'moderator') )
         INNER JOIN event_role_state ON (
             event_role_state.event_role_state_id = event_person.event_role_state_id AND
             event_role_state.event_role_id = event_person.event_role_id AND
             event_role_state.tag = 'confirmed' )
         INNER JOIN event ON (
             event.event_id = event_person.event_id )
         INNER JOIN event_state ON (
             event_state.event_state_id = event.event_state_id AND
             event_state.tag = 'accepted' )
         INNER JOIN event_state_progress ON (
             event_state_progress.event_state_progress_id = event.event_state_progress_id AND
             event_state_progress.event_state_id = event.event_state_id AND
             event_state_progress.tag = 'confirmed' )
         INNER JOIN conference ON (
             conference.conference_id = event.conference_id )
ORDER BY view_person.person_id, event.event_id
;

-- returns all persons with events where slides are missing
CREATE OR REPLACE VIEW view_mail_missing_slides AS
  SELECT view_person.person_id,
         view_person.name,
         view_person.email_contact,
         event.event_id,
         event.title AS event_title,
         event.subtitle AS event_subtitle,
         conference.conference_id,
         conference.acronym AS conference_acronym,
         conference.title AS conference_title
    FROM event_person
         INNER JOIN view_person ON (
             view_person.person_id = event_person.person_id AND
             view_person.email_contact IS NOT NULL )
         INNER JOIN event_role ON (
             event_role.event_role_id = event_person.event_role_id AND
             event_role.tag IN ('speaker', 'moderator') )
         INNER JOIN event_role_state ON (
             event_role_state.event_role_state_id = event_person.event_role_state_id AND
             event_role_state.event_role_id = event_person.event_role_id AND
             event_role_state.tag = 'confirmed' )
         INNER JOIN event ON (
             event.event_id = event_person.event_id AND
             event.f_slides = 't' )
         INNER JOIN event_state ON (
             event_state.event_state_id = event.event_state_id AND
             event_state.tag = 'accepted' )
         INNER JOIN event_state_progress ON (
             event_state_progress.event_state_progress_id = event.event_state_progress_id AND
             event_state_progress.event_state_id = event.event_state_id AND
             event_state_progress.tag = 'confirmed' )
         INNER JOIN conference ON (
             conference.conference_id = event.conference_id )
  WHERE NOT EXISTS (SELECT 1
                      FROM event_attachment
                           INNER JOIN attachment_type ON (
                               attachment_type.attachment_type_id = event_attachment.attachment_type_id AND
                               attachment_type.tag = 'slides' )
                     WHERE event_attachment.event_id = event.event_id  )
ORDER BY view_person.person_id, event.event_id
;

-- returns the list of persons for the conference_page
CREATE OR REPLACE VIEW view_conference_persons AS
  SELECT 
         view_person.person_id,
         view_person.name,
         view_event_role.tag AS event_role_tag,
         view_event_role.name AS event_role,
         view_event_role.language_id AS translated_id,
         event.conference_id
    FROM view_person
         INNER JOIN event_person ON (
             event_person.person_id = view_person.person_id )
         INNER JOIN event ON (
             event.event_id = event_person.event_id )
         INNER JOIN view_event_role ON (
               view_event_role.event_role_id = event_person.event_role_id AND
               view_event_role.tag IN ('speaker', 'moderator', 'coordinator') )
ORDER BY lower( view_person.name ), view_event_role.tag; 
         

