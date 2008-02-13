
CREATE TABLE base.account_settings (
  account_id INTEGER NOT NULL,
  current_language TEXT NOT NULL DEFAULT 'en',
  current_conference_id INTEGER,
  preferences TEXT,
  last_login TIMESTAMP
);

CREATE TABLE auth.account_settings (
  FOREIGN KEY( account_id ) REFERENCES auth.account( account_id ) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY( account_id )
) INHERITS( base.account_settings );

