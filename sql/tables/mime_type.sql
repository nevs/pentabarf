
CREATE TABLE base.mime_type (
  mime_type TEXT NOT NULL,
  file_extension TEXT,
  image BOOL NOT NULL DEFAULT FALSE
);

CREATE TABLE mime_type (
  PRIMARY KEY (mime_type)
) INHERITS( base.mime_type );

CREATE TABLE log.mime_type (
) INHERITS( base.logging, base.mime_type );

CREATE INDEX log_mime_type_mime_type_idx ON log.mime_type( mime_type );
CREATE INDEX log_mime_type_log_transaction_id_idx ON log.mime_type( log_transaction_id );

