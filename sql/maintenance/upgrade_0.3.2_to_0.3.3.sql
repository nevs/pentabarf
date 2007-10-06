
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

-- event_role surrogate key removal
ALTER TABLE event_role ADD COLUMN event_role TEXT;
UPDATE event_role SET event_role = tag;
ALTER TABLE event_role DROP COLUMN tag CASCADE;
ALTER TABLE event_role DROP COLUMN f_public CASCADE;

ALTER TABLE event_role_localized ADD COLUMN event_role TEXT;
UPDATE event_role_localized SET event_role = ( SELECT event_role FROM event_role WHERE event_role.event_role_id = event_role_localized.event_role_id );
ALTER TABLE event_role_state ADD COLUMN event_role TEXT;
UPDATE event_role_state SET event_role = ( SELECT event_role FROM event_role WHERE event_role.event_role_id = event_role_state.event_role_id );
ALTER TABLE event_person ADD COLUMN event_role TEXT;
UPDATE event_person SET event_role = ( SELECT event_role FROM event_role WHERE event_role.event_role_id = event_person.event_role_id );

ALTER TABLE event_role DROP CONSTRAINT event_role_pkey CASCADE;
ALTER TABLE event_role ADD CONSTRAINT event_role_pkey PRIMARY KEY( event_role );
ALTER TABLE event_role DROP COLUMN event_role_id CASCADE;

ALTER TABLE event_role_localized DROP CONSTRAINT event_role_localized_pkey;
ALTER TABLE event_role_localized ADD CONSTRAINT event_role_localized_pkey PRIMARY KEY( event_role, language_id );
ALTER TABLE event_role_localized ADD CONSTRAINT event_role_localized_event_role_fkey FOREIGN KEY( event_role ) REFERENCES event_role(event_role) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE event_role_localized DROP COLUMN event_role_id CASCADE;

ALTER TABLE event_role_state DROP CONSTRAINT event_role_state_pkey CASCADE;
ALTER TABLE event_role_state ADD CONSTRAINT event_role_state_event_role_fkey FOREIGN KEY( event_role ) REFERENCES event_role(event_role) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE event_role_state DROP COLUMN event_role_id CASCADE;

ALTER TABLE event_person DROP COLUMN event_role_id CASCADE;
ALTER TABLE event_person ADD CONSTRAINT event_person_event_id_key UNIQUE( event_id, person_id, event_role );
ALTER TABLE event_person ADD CONSTRAINT event_person_event_role_fkey FOREIGN KEY( event_role ) REFERENCES event_role(event_role) ON UPDATE CASCADE ON DELETE RESTRICT;

-- event_role_state surrogate key removal
ALTER TABLE event_role_state ADD COLUMN event_role_state TEXT;
UPDATE event_role_state SET event_role_state = tag;
ALTER TABLE event_role_state DROP COLUMN tag CASCADE;

ALTER TABLE event_role_state_localized ADD COLUMN event_role TEXT;
ALTER TABLE event_role_state_localized ADD COLUMN event_role_state TEXT;
UPDATE event_role_state_localized SET event_role = (SELECT event_role FROM event_role_state WHERE event_role_state.event_role_state_id = event_role_state_localized.event_role_state_id), event_role_state = (SELECT event_role_state FROM event_role_state WHERE event_role_state.event_role_state_id = event_role_state_localized.event_role_state_id);
ALTER TABLE event_role_state_localized DROP COLUMN event_role_state_id CASCADE;

ALTER TABLE event_person ADD COLUMN event_role_state TEXT;
UPDATE event_person SET event_role_state = (SELECT event_role_state FROM event_role_state WHERE event_role_state.event_role_state_id = event_person.event_role_state_id);
ALTER TABLE event_person DROP COLUMN event_role_state_id CASCADE;

ALTER TABLE event_role_state DROP COLUMN event_role_state_id;
ALTER TABLE event_role_state ADD CONSTRAINT event_role_state_pkey PRIMARY KEY( event_role, event_role_state );

ALTER TABLE event_role_state_localized ADD CONSTRAINT event_role_state_localized_pkey PRIMARY KEY( event_role, event_role_state, language_id );
ALTER TABLE event_role_state_localized ADD CONSTRAINT event_role_state_localized_event_role_fkey FOREIGN KEY( event_role, event_role_state) REFERENCES event_role_state( event_role, event_role_state ) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE event_person ADD CONSTRAINT event_person_event_role_state_fkey FOREIGN KEY( event_role, event_role_state ) REFERENCES event_role_state(event_role,event_role_state) ON UPDATE CASCADE ON DELETE RESTRICT;

COMMIT;

