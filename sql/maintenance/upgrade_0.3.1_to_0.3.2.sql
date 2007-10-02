
BEGIN;

-- remove unused columns from event
ALTER TABLE event DROP COLUMN actual_start;
ALTER TABLE event DROP COLUMN actual_end;

-- remove surrogate primary key from event type
ALTER TABLE event_type ADD COLUMN event_type TEXT;
UPDATE event_type SET event_type = tag;
ALTER TABLE event_type DROP COLUMN tag CASCADE;
ALTER TABLE event_type_localized ADD COLUMN event_type TEXT;
UPDATE event_type_localized SET event_type = ( SELECT event_type FROM event_type WHERE event_type.event_type_id = event_type_localized.event_type_id );
ALTER TABLE event ADD COLUMN event_type TEXT;
UPDATE event SET event_type = ( SELECT event_type FROM event_type WHERE event_type.event_type_id = event.event_type_id );

ALTER TABLE event_type_localized DROP CONSTRAINT event_type_localized_pkey;
ALTER TABLE event_type DROP CONSTRAINT event_type_pkey CASCADE;
ALTER TABLE event_type DROP COLUMN event_type_id;
ALTER TABLE event_type_localized DROP COLUMN event_type_id ;
ALTER TABLE event DROP COLUMN event_type_id CASCADE;

ALTER TABLE event_type ADD CONSTRAINT event_type_pkey PRIMARY KEY( event_type );
ALTER TABLE event_type_localized ADD CONSTRAINT event_type_localized_pkey PRIMARY KEY ( event_type, language_id );
ALTER TABLE event_type_localized ADD CONSTRAINT event_type_localized_event_type_fkey FOREIGN KEY( event_type ) REFERENCES event_type(event_type) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE event ADD CONSTRAINT event_event_type_fkey FOREIGN KEY( event_type ) REFERENCES event_type(event_type) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE event_type_localized ALTER name TYPE TEXT;

-- move auth related stuff in auth schema and get rid of surrogate keys while moving

CREATE TABLE auth.permission (
  permission TEXT,
  rank INTEGER,
  PRIMARY KEY(permission)
);

CREATE TABLE auth.permission_localized (
  permission TEXT NOT NULL,
  translated_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  PRIMARY KEY( permission, translated_id ),
  FOREIGN KEY( permission ) REFERENCES auth.permission( permission ),
  FOREIGN KEY( translated_id ) REFERENCES language( language_id )
);

CREATE TABLE auth.role (
  role TEXT,
  rank INTEGER,
  PRIMARY KEY( role )
);

CREATE TABLE auth.role_localized (
  role TEXT NOT NULL,
  translated_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  PRIMARY KEY( role, translated_id ),
  FOREIGN KEY( role ) REFERENCES auth.role( role ),
  FOREIGN KEY( translated_id ) REFERENCES language( language_id )
);

CREATE TABLE auth.role_permission (
  role TEXT NOT NULL,
  permission TEXT NOT NULL,
  PRIMARY KEY( role, permission ),
  FOREIGN KEY( role ) REFERENCES auth.role( role ),
  FOREIGN KEY( permission ) REFERENCES auth.permission( permission )
);

CREATE TABLE auth.person_role (
  person_id INTEGER NOT NULL,
  role TEXT NOT NULL,
  PRIMARY KEY( person_id, role ),
  FOREIGN KEY( person_id) REFERENCES person( person_id ) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( role ) REFERENCES auth.role( role ) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO auth.permission(permission,rank) SELECT tag,rank FROM authorisation;
INSERT INTO auth.permission_localized(permission,translated_id,name) SELECT tag,language_id,name FROM authorisation_localized INNER JOIN authorisation USING (authorisation_id);
INSERT INTO auth.role(role,rank) SELECT tag,rank FROM role;
INSERT INTO auth.role_localized(role,translated_id,name) SELECT tag,language_id,name FROM role_localized INNER JOIN role USING (role_id);
INSERT INTO auth.role_permission(role,permission) SELECT role.tag,authorisation.tag FROM role_authorisation INNER JOIN role USING (role_id) INNER JOIN authorisation USING (authorisation_id);
INSERT INTO auth.person_role(person_id,role) SELECT person_id,tag FROM person_role INNER JOIN role USING (role_id);

DROP TABLE person_role CASCADE;
DROP TABLE role_authorisation;
DROP TABLE role_localized;
DROP TABLE role CASCADE;
DROP TABLE authorisation_localized;
DROP TABLE authorisation;

ALTER TABLE account_activation SET SCHEMA auth;
ALTER FUNCTION activate_account( CHAR ) SET SCHEMA auth;
ALTER FUNCTION hash_password( TEXT ) SET SCHEMA auth;
ALTER FUNCTION create_account( VARCHAR, VARCHAR, TEXT, CHAR, INTEGER ) SET SCHEMA auth;

INSERT INTO auth.permission VALUES ('modify_review');
INSERT INTO auth.role_permission VALUES ('reviewer','modify_review');

ALTER TABLE activation_string_reset_password RENAME TO password_reset;
ALTER TABLE password_reset SET SCHEMA auth;


COMMIT;

