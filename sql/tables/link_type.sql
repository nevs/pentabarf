
CREATE TABLE link_type (
  link_type TEXT SERIAL NOT NULL,
  template VARCHAR(1024),
  rank INTEGER,
  PRIMARY KEY (link_type)
);

