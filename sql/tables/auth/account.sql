
CREATE TABLE base.account (
  account_id SERIAL,
  login_name TEXT NOT NULL UNIQUE,
  email TEXT NOT NULL,
  salt TEXT,
  password TEXT,
  edit_token TEXT,
  current_language TEXT NOT NULL DEFAULT 'en',
  current_conference_id INTEGER,
  preferences TEXT,
  last_login TIMESTAMP,
  person_id INTEGER,
  CHECK (login_name <> 'logout'),
  CHECK ( strpos( login_name, ':' ) = 0 )
);

CREATE TABLE auth.account (
  FOREIGN KEY( current_language ) REFERENCES language( language ) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY( current_conference_id ) REFERENCES conference( conference_id ) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY( person_id ) REFERENCES person( person_id ) ON UPDATE CASCADE ON DELETE SET NULL,
  PRIMARY KEY( account_id )
) INHERITS( base.account );

CREATE TABLE log.account (
) INHERITS( base.logging, base.account );

