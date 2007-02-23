
CREATE TABLE country (
  country_id SERIAL NOT NULL,
  iso_3166_code CHAR(2) NOT NULL UNIQUE,
  phone_prefix VARCHAR(8),
  f_visible BOOL NOT NULL DEFAULT FALSE,
  f_preferred BOOL NOT NULL DEFAULT FALSE,
  PRIMARY KEY (country_id)
) WITHOUT OIDS;

