
CREATE TABLE base.permission_localized (
  permission TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE auth.permission_localized (
  PRIMARY KEY( permission, translated ),
  FOREIGN KEY( permission ) REFERENCES auth.permission( permission ) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( translated ) REFERENCES language( language ) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.permission_localized );

CREATE TABLE log.permission_localized (
) INHERITS( base.logging, base.permission_localized );

CREATE INDEX log_permission_localized_permission_idx ON log.permission_localized( permission );
CREATE INDEX log_permission_localized_log_transaction_id_idx ON log.permission_localized( log_transaction_id );

