
CREATE TABLE base.domain(
  domain TEXT NOT NULL
);

CREATE TABLE auth.domain(
  PRIMARY KEY(domain)
) INHERITS( base.domain );

CREATE TABLE log.domain(
) INHERITS( base.logging,base.domain );

CREATE INDEX log.domain_domain_idx ON log.domain( domain );
CREATE INDEX log.domain_log_transaction_id_idx ON log.domain( log_transaction_id );

