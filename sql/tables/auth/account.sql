
CREATE TABLE auth.account (
  account_id SERIAL,
  login_name TEXT NOT NULL UNIQUE,
  email TEXT NOT NULL,
  salt TEXT,
  password TEXT,
  edit_token TEXT,
  current_language_id INTEGER NOT NULL DEFAULT 120,
  current_conference_id INTEGER,
  preferences TEXT,
  last_login TIMESTAMP,
  person_id INTEGER REFERENCES public.person(person_id),
  CHECK (login_name <> 'logout'),
  CHECK ( strpos( login_name, ':' ) = 0 ),
  PRIMARY KEY( account_id )
);

