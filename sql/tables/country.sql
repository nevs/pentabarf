
CREATE TABLE master.country(
  country TEXT NOT NULL,
  visible BOOL NOT NULL DEFAULT FALSE
) WITHOUT OIDS;

CREATE TABLE country(
  PRIMARY KEY(country)
) INHERITS(master.country);
CREATE TABLE logging.country() INHERITS(master.country);


