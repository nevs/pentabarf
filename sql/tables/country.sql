
CREATE TABLE master.country(
  country TEXT NOT NULL,
  visible BOOL NOT NULL DEFAULT FALSE
);

CREATE TABLE country(
  PRIMARY KEY(country)
) INHERITS(master.country);
CREATE TABLE logging.country() INHERITS(master.country);


