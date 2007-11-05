
CREATE TABLE base.account_role (
  account_id INTEGER NOT NULL,
  role TEXT NOT NULL
);

CREATE TABLE auth.account_role (
  PRIMARY KEY( account_id, role ),
  FOREIGN KEY( account_id) REFERENCES auth.account( account_id ) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( role ) REFERENCES auth.role( role ) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.account_role );

CREATE TABLE log.account_role() INHERITS( base.logging, base.account_role );

