
CREATE TABLE master.phone_type(
  phone_type TEXT
) WITHOUT OIDS;

CREATE TABLE phone_type() INHERITS(master.phone_type);
CREATE TABLE logging.phone_type() INHERITS(master.phone_type);

