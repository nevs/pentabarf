
CREATE TABLE base.permission (
  permission TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE auth.permission (
  PRIMARY KEY(permission)
) INHERITS( base.permission );

CREATE TABLE log.permission (
  PRIMARY KEY(permission)
) INHERITS( base.logging, base.permission );

