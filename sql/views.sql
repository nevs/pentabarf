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
             view_conference_track.language_id = view_event_type.language_id)
       LEFT OUTER JOIN view_team ON (
             event.team_id = view_team.team_id AND
             view_team.language_id = view_event_type.language_id)
       LEFT OUTER JOIN view_room ON (
             event.room_id = view_room.room_id AND
             view_room.language_id = view_event_type.language_id)
       LEFT OUTER JOIN event_image USING (event_id)
       LEFT OUTER JOIN mime_type USING (mime_type_id)
;

CREATE OR REPLACE VIEW view_event_attachment AS
  SELECT event_attachment_id,
         attachment_type_id,
         view_attachment_type.name AS attachment_type,
         view_attachment_type.tag AS attachment_type_tag,
         event_id,
         mime_type_id,
         mime_type AS mime_type_tag,
         view_mime_type.name AS mime_type,
         filename,
         title,
         f_public,
         last_changed,
         octet_length( data ) AS filesize,
         view_attachment_type.language_id
    FROM event_attachment
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
         view_event_role.tag AS event_role_tag, 
         view_event_role.name AS event_role, 
         view_event_role_state.tag AS event_role_state_tag, 
         view_event_role_state.name AS event_role_state
    FROM event_person 
         INNER JOIN event USING (event_id) 
         INNER JOIN conference USING (conference_id)
         INNER JOIN view_person USING (person_id) 
         INNER JOIN view_event_state USING (event_state_id)
         INNER JOIN view_event_role ON (
               view_event_role.event_role_id = event_person.event_role_id AND 
               view_event_state.language_id = view_event_role.language_id)
         LEFT OUTER JOIN view_event_role_state ON (
               event_person.event_role_state_id = view_event_role_state.event_role_state_id AND 
               view_event_state.language_id = view_event_role_state.language_id);

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
         conference_image.last_changed
    FROM conference_image 
         INNER JOIN mime_type USING (mime_type_id);

CREATE OR REPLACE VIEW view_event_image AS
  SELECT event_image.event_id, 
         event_image.mime_type_id, 
         mime_type.mime_type, 
         event_image.image,
         event_image.last_changed
    FROM event_image 
         INNER JOIN mime_type USING (mime_type_id);

CREATE OR REPLACE VIEW view_person_image AS
  SELECT person_image.person_id, 
         person_image.mime_type_id, 
         mime_type.mime_type, 
         person_image.image,
         person_image.last_changed
    FROM person_image 
         INNER JOIN mime_type USING (mime_type_id);

CREATE OR REPLACE VIEW view_conference_image_modification AS
  SELECT conference_image.conference_id,
         conference_image.last_changed
    FROM conference_image;

CREATE OR REPLACE VIEW view_event_image_modification AS
  SELECT event_image.event_id,
         event_image.last_changed
    FROM event_image;

CREATE OR REPLACE VIEW view_person_image_modification AS
  SELECT person_image.person_id,
         person_image.last_changed
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
         view_person.name
    FROM person_im
         INNER JOIN im_type USING (im_type_id)
         INNER JOIN view_person USING (person_id)
   WHERE im_type.tag = 'jabber';
         

