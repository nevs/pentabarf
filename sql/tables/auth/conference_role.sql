
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

