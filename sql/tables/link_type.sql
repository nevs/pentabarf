
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

