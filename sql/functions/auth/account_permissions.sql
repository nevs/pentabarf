
-- function for getting the global permissions of an account

CREATE OR REPLACE FUNCTION auth.account_permissions( account_id INTEGER ) RETURNS SETOF TEXT AS $$
  SELECT DISTINCT permission
  FROM auth.account_role
    INNER JOIN auth.role_permission USING( role )
  WHERE account_role.account_id = $1;
$$ LANGUAGE SQL;

