
CREATE TABLE base.im_type (
  im_type TEXT NOT NULL,
  scheme TEXT,
  rank INTEGER
);

CREATE TABLE im_type (
  PRIMARY KEY (im_type)
) INHERITS( base.im_type );

CREATE TABLE log.im_type (
) INHERITS( base.logging, base.im_type );

