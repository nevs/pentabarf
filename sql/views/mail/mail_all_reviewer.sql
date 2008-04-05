
-- returns all reviewer
CREATE OR REPLACE VIEW view_mail_all_reviewer AS
  SELECT DISTINCT ON ( view_person.person_id )
         view_person.person_id,
         view_person.name,
         view_person.email,
         view_person.spam
    FROM view_person
         INNER JOIN auth.account USING (person_id)
         INNER JOIN auth.account_role ON (
           account_role.account_id = account.account_id AND
           account_role.role = 'reviewer'
         )
   WHERE
         view_person.email IS NOT NULL
;

