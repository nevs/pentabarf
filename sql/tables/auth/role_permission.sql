
CREATE TABLE auth.role_permission (
  role TEXT NOT NULL,
  permission TEXT NOT NULL,
  PRIMARY KEY( role, permission ),
  FOREIGN KEY( role ) REFERENCES auth.role( role ),
  FOREIGN KEY( permission ) REFERENCES auth.permission( permission )
);

