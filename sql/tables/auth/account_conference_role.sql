
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

