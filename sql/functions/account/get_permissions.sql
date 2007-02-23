
/*
 * function for getting the permissions of a user
*/

CREATE OR REPLACE FUNCTION get_permissions(INTEGER) RETURNS SETOF TEXT AS '
  DECLARE
    cur_person_id ALIAS FOR $1;
    cur_permission RECORD;
  BEGIN
    FOR cur_permission IN
      SELECT DISTINCT authorisation.tag FROM authorisation, role_authorisation, person_role
        WHERE authorisation.authorisation_id = role_authorisation.authorisation_id AND
            person_role.role_id = role_authorisation.role_id AND
            person_role.person_id = cur_person_id
    LOOP
      RETURN NEXT cur_permission.tag;
    END LOOP;
    RETURN;
  END;
' LANGUAGE 'plpgsql' RETURNS NULL ON NULL INPUT;

