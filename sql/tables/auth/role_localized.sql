
CREATE TABLE auth.role_localized (
  role TEXT NOT NULL,
  translated_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  PRIMARY KEY( role, translated_id ),
  FOREIGN KEY( role ) REFERENCES auth.role( role ),
  FOREIGN KEY( translated_id ) REFERENCES language( language_id )
);

