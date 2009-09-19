
BEGIN;

DELETE FROM auth.permission WHERE permission = 'move_event';

ALTER TABLE log.permission DROP CONSTRAINT permission_pkey;
ALTER TABLE log.permission ADD CONSTRAINT permission_pkey PRIMARY KEY(log_transaction_id,permission);

ALTER TABLE base.permission ADD COLUMN conference_permission BOOL NOT NULL DEFAULT FALSE;

DELETE FROM auth.permission;

INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('account::create', NULL, false);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('account::delete', NULL, false);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('account::modify', NULL, false);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('account::modify_own', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('account::show', NULL, false);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('account_conference_role::create', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('account_conference_role::delete', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('account_role::create', NULL, false);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('account_role::delete', NULL, false);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('admin::login', NULL, false);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('conference::create', NULL, false);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('conference::delete', NULL, false);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('conference::modify', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('conference::show', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('conference_person::create', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('conference_person::delete', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('conference_person::modify', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('conference_role::create', NULL, false);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('conference_role::delete', NULL, false);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('conference_role::modify', NULL, false);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('config::modify', NULL, false);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('custom::modify', NULL, false);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('event::create', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('event::delete', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('event::modify', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('event::modify_own', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('event::show', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('localization::create', NULL, false);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('localization::delete', NULL, false);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('localization::modify', NULL, false);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('pentabarf::login', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('person::create', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('person::delete', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('person::modify', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('person::modify_own', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('person::show', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('rating::create', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('rating::modify', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('rating::show', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('review::modify', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('role::create', NULL, false);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('role::delete', NULL, false);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('role::modify', NULL, false);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('submission::login', NULL, true);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('valuelist::create', NULL, false);
INSERT INTO auth.permission (permission, rank, conference_permission) VALUES ('valuelist::modify', NULL, false);

INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'account::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'account::delete');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'account::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'account::modify_own');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'account::show');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'account_conference_role::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'account_conference_role::delete');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'account_role::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'account_role::delete');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'admin::login');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'conference::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'conference::delete');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'conference::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'conference::show');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'conference_person::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'conference_person::delete');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'conference_person::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'conference_role::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'conference_role::delete');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'conference_role::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'config::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'custom::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'event::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'event::delete');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'event::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'event::modify_own');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'event::show');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'localization::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'localization::delete');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'localization::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'pentabarf::login');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'person::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'person::delete');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'person::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'person::modify_own');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'person::show');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'rating::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'rating::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'rating::show');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'review::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'role::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'role::delete');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'role::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'submission::login');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'valuelist::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('admin', 'valuelist::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('committee', 'account::modify_own');
INSERT INTO auth.role_permission ("role", permission) VALUES ('committee', 'conference::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('committee', 'conference::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('committee', 'conference::show');
INSERT INTO auth.role_permission ("role", permission) VALUES ('committee', 'conference_person::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('committee', 'conference_person::delete');
INSERT INTO auth.role_permission ("role", permission) VALUES ('committee', 'conference_person::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('committee', 'event::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('committee', 'event::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('committee', 'event::modify_own');
INSERT INTO auth.role_permission ("role", permission) VALUES ('committee', 'event::show');
INSERT INTO auth.role_permission ("role", permission) VALUES ('committee', 'pentabarf::login');
INSERT INTO auth.role_permission ("role", permission) VALUES ('committee', 'person::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('committee', 'person::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('committee', 'person::modify_own');
INSERT INTO auth.role_permission ("role", permission) VALUES ('committee', 'person::show');
INSERT INTO auth.role_permission ("role", permission) VALUES ('committee', 'rating::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('committee', 'rating::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('committee', 'rating::show');
INSERT INTO auth.role_permission ("role", permission) VALUES ('committee', 'review::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('committee', 'submission::login');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'account::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'account::delete');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'account::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'account::modify_own');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'account_conference_role::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'account_conference_role::delete');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'account_role::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'account_role::delete');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'admin::login');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'conference::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'conference::delete');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'conference::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'conference::show');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'conference_person::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'conference_person::delete');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'conference_person::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'conference_role::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'conference_role::delete');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'conference_role::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'config::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'custom::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'event::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'event::delete');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'event::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'event::modify_own');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'event::show');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'localization::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'localization::delete');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'localization::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'pentabarf::login');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'person::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'person::delete');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'person::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'person::modify_own');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'person::show');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'rating::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'rating::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'rating::show');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'review::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'role::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'role::delete');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'role::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'submission::login');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'valuelist::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('developer', 'valuelist::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('reviewer', 'account::modify_own');
INSERT INTO auth.role_permission ("role", permission) VALUES ('reviewer', 'conference::show');
INSERT INTO auth.role_permission ("role", permission) VALUES ('reviewer', 'event::show');
INSERT INTO auth.role_permission ("role", permission) VALUES ('reviewer', 'pentabarf::login');
INSERT INTO auth.role_permission ("role", permission) VALUES ('reviewer', 'person::modify_own');
INSERT INTO auth.role_permission ("role", permission) VALUES ('reviewer', 'person::show');
INSERT INTO auth.role_permission ("role", permission) VALUES ('reviewer', 'rating::create');
INSERT INTO auth.role_permission ("role", permission) VALUES ('reviewer', 'rating::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('reviewer', 'review::modify');
INSERT INTO auth.role_permission ("role", permission) VALUES ('submitter', 'account::modify_own');
INSERT INTO auth.role_permission ("role", permission) VALUES ('submitter', 'event::modify_own');
INSERT INTO auth.role_permission ("role", permission) VALUES ('submitter', 'person::modify_own');
INSERT INTO auth.role_permission ("role", permission) VALUES ('submitter', 'submission::login');

CREATE TABLE base.conference_role ( conference_role TEXT NOT NULL, rank INTEGER);
CREATE TABLE auth.conference_role ( PRIMARY KEY( conference_role )) INHERITS( base.conference_role );
CREATE TABLE log.conference_role () INHERITS( base.logging, base.conference_role );
CREATE INDEX log_conference_role_conference_role_idx ON log.conference_role( conference_role );
CREATE INDEX log_conference_role_log_transaction_id_idx ON log.conference_role( log_transaction_id );

CREATE TABLE base.conference_role_localized ( conference_role TEXT NOT NULL, translated TEXT NOT NULL, name TEXT NOT NULL);

CREATE TABLE auth.conference_role_localized (
  PRIMARY KEY( conference_role, translated ), 
  FOREIGN KEY( conference_role ) REFERENCES auth.conference_role( conference_role ) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( translated ) REFERENCES language( language ) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.conference_role_localized ); 
CREATE TABLE log.conference_role_localized () INHERITS( base.logging, base.conference_role_localized ); 
      
CREATE INDEX log_conference_role_localized_conference_role_idx ON log.conference_role_localized( conference_role ); 
CREATE INDEX log_conference_role_localized_log_transaction_id_idx ON log.conference_role_localized( log_transaction_id ); 

INSERT INTO auth.conference_role (conference_role, rank) VALUES ('admin', NULL);
INSERT INTO auth.conference_role (conference_role, rank) VALUES ('committee', NULL);
INSERT INTO auth.conference_role (conference_role, rank) VALUES ('reviewer', NULL);

CREATE TABLE base.conference_role_permission ( conference_role TEXT NOT NULL, permission TEXT NOT NULL );
CREATE TABLE auth.conference_role_permission (
  PRIMARY KEY( conference_role, permission ),
  FOREIGN KEY( conference_role ) REFERENCES auth.conference_role( conference_role ) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( permission ) REFERENCES auth.permission( permission ) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.conference_role_permission );
CREATE TABLE log.conference_role_permission () INHERITS( base.logging, base.conference_role_permission );
CREATE INDEX log_conference_role_permission_conference_role_idx ON log.conference_role_permission( conference_role );
CREATE INDEX log_conference_role_permission_log_transaction_id_idx ON log.conference_role_permission( log_transaction_id );


CREATE TABLE base.account_conference_role ( account_id INTEGER NOT NULL, conference_id INTEGER NOT NULL, conference_role TEXT NOT NULL );
CREATE TABLE auth.account_conference_role (
  PRIMARY KEY( account_id, conference_id, conference_role ),
  FOREIGN KEY( account_id ) REFERENCES auth.account ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( conference_id) REFERENCES conference ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( conference_role ) REFERENCES auth.conference_role ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.account_conference_role );
CREATE TABLE log.account_conference_role() INHERITS( base.logging, base.account_conference_role );
CREATE INDEX log_account_conference_role_account_id_idx ON log.account_conference_role( account_id );
CREATE INDEX log_account_conference_role_log_transaction_id_idx ON log.account_conference_role( log_transaction_id );


INSERT INTO auth.domain VALUES ('account_role'),('account_conference_role');
INSERT INTO auth.domain VALUES ('role'),('conference_role');
UPDATE auth.object_domain SET domain = 'account_role' WHERE object = 'account_role';

INSERT INTO auth.object_domain VALUES ('role','role');
INSERT INTO auth.object_domain VALUES ('role_permission','role');
INSERT INTO auth.object_domain VALUES ('conference_role','conference_role');
INSERT INTO auth.object_domain VALUES ('conference_role_permission','conference_role');
INSERT INTO auth.object_domain VALUES ('account_conference_role','account_conference_role');

CREATE TYPE auth.conference_permission AS (
  conference_id INTEGER,
  permission TEXT
);

ALTER TABLE auth.account_settings ADD CONSTRAINT account_settings_current_conference_id_fkey FOREIGN KEY (current_conference_id) REFERENCES conference(conference_id) ON UPDATE CASCADE ON DELETE CASCADE;

COMMIT;

