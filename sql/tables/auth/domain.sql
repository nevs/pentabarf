
CREATE TABLE base.domain(
  domain TEXT NOT NULL
);

CREATE TABLE auth.domain(
  PRIMARY KEY(domain)
) INHERITS( base.domain );

CREATE TABLE log.domain(
) INHERITS( base.logging,base.domain );

