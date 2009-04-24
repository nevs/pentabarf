
CREATE TABLE base.transport_localized (
  transport TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE transport_localized (
  FOREIGN KEY (transport) REFERENCES transport (transport) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (transport, translated)
) INHERITS( base.transport_localized );

CREATE TABLE log.transport_localized (
) INHERITS( base.logging, base.transport_localized );

CREATE INDEX log.transport_localized_transport_idx ON log.transport_localized( transport );
CREATE INDEX log.transport_localized_log_transaction_id_idx ON log.transport_localized( log_transaction_id );

