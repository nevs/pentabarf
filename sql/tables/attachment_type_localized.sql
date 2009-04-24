
CREATE TABLE base.attachment_type_localized (
  attachment_type TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE attachment_type_localized (
  FOREIGN KEY (attachment_type) REFERENCES attachment_type (attachment_type) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (attachment_type, translated)
) INHERITS( base.attachment_type_localized );

CREATE TABLE log.attachment_type_localized (
) INHERITS( base.logging, base.attachment_type_localized );

CREATE INDEX log.attachment_type_localized_attachment_type_idx ON log.attachment_type_localized( attachment_type );
CREATE INDEX log.attachment_type_localized_log_transaction_id_idx ON log.attachment_type_localized( log_transaction_id );

