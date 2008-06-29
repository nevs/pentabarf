
BEGIN;

ALTER TABLE base.account DROP CONSTRAINT account_login_name_key;
ALTER TABLE auth.account ADD CONSTRAINT account_login_name_key UNIQUE(login_name);

COMMIT;

