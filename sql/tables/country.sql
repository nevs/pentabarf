
CREATE TABLE master.country(
  country TEXT,
  visible BOOL
) WITHOUT OIDS;

CREATE TABLE country() INHERITS(master.country);
CREATE TABLE logging.country() INHERITS(master.country);


