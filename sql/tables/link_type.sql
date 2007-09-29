
CREATE TABLE link_type (
  link_type_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  template VARCHAR(1024),
  rank INTEGER,
  PRIMARY KEY (link_type_id)
);

