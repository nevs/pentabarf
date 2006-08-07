
CREATE TABLE master.phone_type(
  phone_type TEXT NOT NULL
) WITHOUT OIDS;

CREATE TABLE phone_type(
  PRIMARY KEY(phone_type)
) INHERITS(master.phone_type);

CREATE TABLE logging.phone_type() INHERITS(master.phone_type);

