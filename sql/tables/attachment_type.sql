
CREATE TABLE base.attachment_type (
  attachment_type TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE attachment_type (
  PRIMARY KEY (attachment_type)
) INHERITS( base.attachment_type );

CREATE TABLE log.attachment_type (
) INHERITS( base.logging, base.attachment_type );

