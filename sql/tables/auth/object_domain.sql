
CREATE TABLE auth.object_domain(
  object TEXT,
  domain TEXT,
  PRIMARY KEY(object, domain),
  FOREIGN KEY(domain) REFERENCES auth.domain(domain)
);

