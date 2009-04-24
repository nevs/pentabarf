
CREATE TABLE base.role (
  role TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE auth.role (
  PRIMARY KEY( role )
) INHERITS( base.role );

CREATE TABLE log.role (
) INHERITS( base.logging, base.role );

CREATE INDEX log_role_role_idx ON log.role( role );
CREATE INDEX log_role_log_transaction_id_idx ON log.role( log_transaction_id );

