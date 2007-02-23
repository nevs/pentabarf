
CREATE TABLE transport (
  transport_id SERIAL NOT NULL,
  tag VARCHAR(32) NOT NULL UNIQUE,
  rank INTEGER,
  PRIMARY KEY (transport_id)
) WITHOUT OIDS;

