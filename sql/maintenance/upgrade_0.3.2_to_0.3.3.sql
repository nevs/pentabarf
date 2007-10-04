
BEGIN;

ALTER TABLE auth.permission_localized DROP CONSTRAINT permission_localized_permission_fkey;
ALTER TABLE auth.permission_localized ADD constraint permission_localized_permission_fkey FOREIGN KEY (permission) REFERENCES auth.permission(permission) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE auth.permission_localized DROP CONSTRAINT permission_localized_translated_id_fkey;
ALTER TABLE auth.permission_localized ADD CONSTRAINT permission_localized_translated_id_fkey FOREIGN KEY (translated_id) REFERENCES "language"(language_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE auth.role_permission DROP CONSTRAINT role_permission_permission_fkey;
ALTER TABLE auth.role_permission ADD CONSTRAINT role_permission_permission_fkey FOREIGN KEY (permission) REFERENCES auth.permission(permission) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE auth.role_permission DROP CONSTRAINT role_permission_role_fkey;
ALTER TABLE auth.role_permission ADD CONSTRAINT role_permission_role_fkey FOREIGN KEY ("role") REFERENCES auth."role"("role") ON UPDATE CASCADE ON DELETE CASCADE;

UPDATE auth.permission SET permission = 'modify_account' WHERE permission = 'modify_login';
UPDATE auth.permission SET permission = 'create_account' WHERE permission = 'create_login';
UPDATE auth.permission SET permission = 'delete_account' WHERE permission = 'delete_login';

COMMIT;

