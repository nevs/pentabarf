
CREATE TABLE base.conference_role_localized (
  conference_role TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE auth.conference_role_localized (
  PRIMARY KEY( conference_role, translated ),
  FOREIGN KEY( conference_role ) REFERENCES auth.conference_role( conference_role ) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( translated ) REFERENCES language( language ) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.conference_role_localized );

CREATE TABLE log.conference_role_localized (
) INHERITS( base.logging, base.conference_role_localized );

CREATE INDEX log_conference_role_localized_conference_role_idx ON log.conference_role_localized( conference_role );
CREATE INDEX log_conference_role_localized_log_transaction_id_idx ON log.conference_role_localized( log_transaction_id );

