
CREATE OR REPLACE VIEW view_person AS
  SELECT person_id,
         login_name,
         coalesce(person.public_name, coalesce(person.first_name || ' ', '') || person.last_name, person.nickname, person.login_name) AS name,
         title,
         gender,
         first_name,
         last_name,
         public_name,
         nickname
    FROM person;

