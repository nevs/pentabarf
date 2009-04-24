
CREATE TABLE base.transport (
  transport TEXT,
  rank INTEGER
);

CREATE TABLE transport (
  PRIMARY KEY (transport)
) INHERITS( base.transport );

CREATE TABLE log.transport (
) INHERITS( base.logging, base.transport );

CREATE INDEX log.transport_transport_idx ON log.transport( transport );
CREATE INDEX log.transport_log_transaction_id_idx ON log.transport( log_transaction_id );

