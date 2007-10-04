
CREATE TABLE auth.role_permission (
  role TEXT NOT NULL,
  permission TEXT NOT NULL,
  PRIMARY KEY( role, permission ),
  FOREIGN KEY( role ) REFERENCES auth.role( role ) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( permission ) REFERENCES auth.permission( permission ) ON UPDATE CASCADE ON DELETE CASCADE
);

