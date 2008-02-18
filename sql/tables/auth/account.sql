
CREATE TABLE base.account (
  account_id SERIAL,
  login_name TEXT NOT NULL UNIQUE,
  email TEXT,
  salt TEXT,
  password TEXT,
  edit_token TEXT,
  person_id INTEGER,
  CHECK (login_name <> 'logout'),
  CHECK ( strpos( login_name, ':' ) = 0 )
);

CREATE TABLE auth.account (
  FOREIGN KEY( person_id ) REFERENCES person( person_id ) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY( account_id )
) INHERITS( base.account );

CREATE TABLE log.account() INHERITS( base.logging, base.account );

