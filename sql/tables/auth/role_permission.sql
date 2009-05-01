
-- table linking permissions to global roles

CREATE TABLE base.role_permission (
  role TEXT NOT NULL,
  permission TEXT NOT NULL
);

CREATE TABLE auth.role_permission (
  PRIMARY KEY( role, permission ),
  FOREIGN KEY( role ) REFERENCES auth.role( role ) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( permission ) REFERENCES auth.permission( permission ) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.role_permission );

CREATE TABLE log.role_permission (
) INHERITS( base.logging, base.role_permission );

CREATE INDEX log_role_permission_role_idx ON log.role_permission( role );
CREATE INDEX log_role_permission_log_transaction_id_idx ON log.role_permission( log_transaction_id );

