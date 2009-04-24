
CREATE TABLE base.object_domain(
  object TEXT NOT NULL,
  domain TEXT NOT NULL
);

CREATE TABLE auth.object_domain(
  PRIMARY KEY(object, domain),
  FOREIGN KEY(domain) REFERENCES auth.domain(domain) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.object_domain );

CREATE TABLE log.object_domain(
) INHERITS( base.logging, base.object_domain );

CREATE INDEX log.object_domain_object_idx ON log.object_domain( object );
CREATE INDEX log.object_domain_log_transaction_id_idx ON log.object_domain( log_transaction_id );

