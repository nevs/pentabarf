
CREATE TABLE base.link_type_localized (
  link_type TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE link_type_localized (
  FOREIGN KEY (link_type) REFERENCES link_type (link_type) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (link_type, translated)
) INHERITS( base.link_type_localized );

CREATE TABLE log.link_type_localized (
) INHERITS( base.logging, base.link_type_localized );

CREATE INDEX log_link_type_localized_link_type_idx ON log.link_type_localized( link_type );
CREATE INDEX log_link_type_localized_log_transaction_id_idx ON log.link_type_localized( log_transaction_id );

