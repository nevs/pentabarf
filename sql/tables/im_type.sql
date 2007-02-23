
CREATE TABLE im_type (
  im_type_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  scheme VARCHAR(32),
  rank INTEGER,
  PRIMARY KEY (im_type_id)
) WITHOUT OIDS;

