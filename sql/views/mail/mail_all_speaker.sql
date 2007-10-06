
-- returns all speakers of all conferences
CREATE OR REPLACE VIEW view_mail_all_speaker AS
  SELECT DISTINCT ON ( person.person_id )
         person.person_id,
         view_person.name,
         view_person.email_contact
    FROM event_person
         INNER JOIN person ON (
             person.person_id = event_person.person_id AND
             person.email_contact IS NOT NULL AND
             person.f_spam = true )
         INNER JOIN view_person ON (
             view_person.person_id = event_person.person_id AND
             view_person.email_contact IS NOT NULL )
   WHERE event_role IN ('speaker','moderator')
;

