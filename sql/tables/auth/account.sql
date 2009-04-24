
CREATE TABLE base.account (
  account_id SERIAL,
  login_name TEXT NOT NULL,
  email TEXT,
  salt TEXT,
  password TEXT,
  edit_token TEXT,
  person_id INTEGER,
  CHECK (login_name <> 'logout'),
  CHECK ( strpos( login_name, ':' ) = 0 ),
  CONSTRAINT account_email_check CHECK (email ~ E'^[\\w=_.+-]+@([\\w.+_-]+\.)+\\w{2,}$')
);

CREATE TABLE auth.account (
  UNIQUE( login_name ),
  FOREIGN KEY( person_id ) REFERENCES person( person_id ) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY( account_id )
) INHERITS( base.account );

CREATE TABLE log.account() INHERITS( base.logging, base.account );

CREATE INDEX log.account_account_id_idx ON log.account( account_id );
CREATE INDEX log.account_log_transaction_id_idx ON log.account( log_transaction_id );

