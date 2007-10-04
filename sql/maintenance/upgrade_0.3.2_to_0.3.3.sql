
BEGIN;

 ALTER TABLE auth.permission_localized DROP CONSTRAINT permission_localized_permission_fkey;
 ALTER TABLE auth.permission_localized ADD constraint permission_localized_permission_fkey FOREIGN KEY (permission) REFERENCES auth.permission(permission) ON UPDATE CASCADE ON DELETE CASCADE;

 ALTER TABLE auth.permission_localized DROP CONSTRAINT permission_localized_translated_id_fkey;
 ALTER TABLE auth.permission_localized ADD CONSTRAINT permission_localized_translated_id_fkey FOREIGN KEY (translated_id) REFERENCES "language"(language_id) ON UPDATE CASCADE ON DELETE CASCADE;


COMMIT;

