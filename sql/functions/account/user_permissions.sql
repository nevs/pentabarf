
/*
 * function for getting the permissions of a user
*/

CREATE OR REPLACE FUNCTION user_permissions( person_id INTEGER ) RETURNS SETOF TEXT AS '
  SELECT DISTINCT authorisation.tag
  FROM person_role
    INNER JOIN role_authorisation USING( role_id )
    INNER JOIN authorisation USING( authorisation_id )
  WHERE person_role.person_id = $1;
' LANGUAGE SQL;

