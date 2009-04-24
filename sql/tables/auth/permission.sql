
CREATE TABLE base.permission (
  permission TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE auth.permission (
  PRIMARY KEY(permission)
) INHERITS( base.permission );

CREATE TABLE log.permission (
  PRIMARY KEY(permission)
) INHERITS( base.logging, base.permission );

CREATE INDEX log.permission_permission_idx ON log.permission( permission );
CREATE INDEX log.permission_log_transaction_id_idx ON log.permission( log_transaction_id );

