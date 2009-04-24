
CREATE TABLE base.link_type (
  link_type TEXT NOT NULL,
  template TEXT,
  rank INTEGER
);

CREATE TABLE link_type (
  PRIMARY KEY (link_type)
) INHERITS( base.link_type );

CREATE TABLE log.link_type (
) INHERITS( base.logging, base.link_type );

CREATE INDEX log.link_type_link_type_idx ON log.link_type( link_type );
CREATE INDEX log.link_type_log_transaction_id_idx ON log.link_type( log_transaction_id );

