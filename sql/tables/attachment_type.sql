
CREATE TABLE attachment_type (
  attachment_type_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  rank INTEGER,
  PRIMARY KEY (attachment_type_id)
);

