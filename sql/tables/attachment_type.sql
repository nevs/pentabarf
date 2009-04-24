
CREATE TABLE base.attachment_type (
  attachment_type TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE attachment_type (
  PRIMARY KEY (attachment_type)
) INHERITS( base.attachment_type );

CREATE TABLE log.attachment_type (
) INHERITS( base.logging, base.attachment_type );

CREATE INDEX log_attachment_type_attachment_type_idx ON log.attachment_type( attachment_type );
CREATE INDEX log_attachment_type_log_transaction_id_idx ON log.attachment_type( log_transaction_id );

