
-- returns all reviewer
CREATE OR REPLACE VIEW view_mail_all_reviewer AS
  SELECT DISTINCT ON ( view_person.person_id )
         view_person.person_id,
         view_person.name,
         view_person.email_contact
    FROM view_person
         INNER JOIN person_role ON (
             person_role.person_id = view_person.person_id )
         INNER JOIN role ON (
             role.role_id = person_role.role_id AND
             role.tag = 'reviewer' )
   WHERE
         view_person.email_contact IS NOT NULL AND
         view_person.f_spam = true
;

