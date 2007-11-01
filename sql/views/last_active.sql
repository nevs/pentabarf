
-- view for last active user
CREATE OR REPLACE VIEW view_last_active AS
  SELECT person_id,
         login_name,
         name,
         last_login,
         date_trunc( 'second', now() - last_login) AS login_diff
    FROM view_person
    WHERE last_login > now() + '-1 hour'::interval
    ORDER BY last_login DESC;

