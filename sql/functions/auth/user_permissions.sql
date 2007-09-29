
/*
 * function for getting the permissions of a user
*/

CREATE OR REPLACE FUNCTION auth.user_permissions( person_id INTEGER ) RETURNS SETOF TEXT AS '
  SELECT DISTINCT permission
  FROM auth.person_role
    INNER JOIN auth.role_permission USING( role )
  WHERE person_role.person_id = $1;
' LANGUAGE SQL;

