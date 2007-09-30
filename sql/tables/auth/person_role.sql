
CREATE TABLE auth.person_role (
  person_id INTEGER NOT NULL,
  role TEXT NOT NULL,
  PRIMARY KEY( person_id, role ),
  FOREIGN KEY( person_id) REFERENCES person( person_id ) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( role ) REFERENCES auth.role( role ) ON UPDATE CASCADE ON DELETE CASCADE
);

