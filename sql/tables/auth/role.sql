
CREATE TABLE base.role (
  role TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE auth.role (
  PRIMARY KEY( role )
) INHERITS( base.role );

CREATE TABLE log.role (
) INHERITS( base.logging, base.role );

