
CREATE TABLE base.person_role (
  person_id INTEGER NOT NULL,
  role TEXT NOT NULL
);

CREATE TABLE auth.person_role (
  PRIMARY KEY( person_id, role ),
  FOREIGN KEY( person_id) REFERENCES person( person_id ) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( role ) REFERENCES auth.role( role ) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.person_role );

CREATE TABLE log.person_role() INHERITS( base.logging, base.person_role );

