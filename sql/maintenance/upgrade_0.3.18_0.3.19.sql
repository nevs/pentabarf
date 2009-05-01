
BEGIN;

DELETE FROM auth.permission WHERE permission = 'move_event';

ALTER TABLE base.permission add column conference_permission BOOL NOT NULL DEFAULT FALSE;


CREATE TABLE base.conference_role (
  conference_role TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE auth.conference_role (
  PRIMARY KEY( conference_role )
) INHERITS( base.conference_role );

CREATE TABLE log.conference_role (
) INHERITS( base.logging, base.conference_role );

CREATE INDEX log_conference_role_conference_role_idx ON log.conference_role( conference_role );
CREATE INDEX log_conference_role_log_transaction_id_idx ON log.conference_role( log_transaction_id );


CREATE TABLE base.conference_role_permission (
  conference_role TEXT NOT NULL,
  permission TEXT NOT NULL
);

CREATE TABLE auth.conference_role_permission (
  PRIMARY KEY( conference_role, permission ),
  FOREIGN KEY( conference_role ) REFERENCES auth.conference_role( conference_role ) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( permission ) REFERENCES auth.permission( permission ) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.conference_role_permission );

CREATE TABLE log.conference_role_permission (
) INHERITS( base.logging, base.conference_role_permission );

CREATE INDEX log_conference_role_permission_conference_role_idx ON log.conference_role_permission( conference_role );
CREATE INDEX log_conference_role_permission_log_transaction_id_idx ON log.conference_role_permission( log_transaction_id );


CREATE TABLE base.account_conference_role (
  account_id INTEGER NOT NULL,
  conference_id INTEGER NOT NULL,
  conference_role TEXT NOT NULL
);

CREATE TABLE auth.account_conference_role (
  PRIMARY KEY( account_id, conference_id, conference_role ),
  FOREIGN KEY( account_id ) REFERENCES auth.account ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( conference_id) REFERENCES conference ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( conference_role ) REFERENCES auth.conference_role ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.account_conference_role );

CREATE TABLE log.account_conference_role() INHERITS( base.logging, base.account_conference_role );

CREATE INDEX log_account_conference_role_account_id_idx ON log.account_conference_role( account_id );
CREATE INDEX log_account_conference_role_log_transaction_id_idx ON log.account_conference_role( log_transaction_id );

COMMIT;

