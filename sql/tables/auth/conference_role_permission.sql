
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

