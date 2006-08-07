
CREATE TABLE master.person(
  person_id INTEGER,
  login_name VARCHAR(64),
  password VARCHAR(32),
  salt VARCHAR(16),
  first_name TEXT,
  last_name TEXT
) WITHOUT OIDS;

CREATE TABLE person() INHERITS(master.person);
CREATE TABLE logging.person() INHERITS(master.person);

