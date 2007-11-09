
CREATE TABLE base.role_localized (
  role TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE auth.role_localized (
  PRIMARY KEY( role, translated ),
  FOREIGN KEY( role ) REFERENCES auth.role( role ),
  FOREIGN KEY( translated ) REFERENCES language( language )
) INHERITS( base.role_localized );

CREATE TABLE log.role_localized (
) INHERITS( base.logging, base.role_localized );

