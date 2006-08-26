
CREATE TABLE master.person(
  person_id INTEGER NOT NULL,
  login_name VARCHAR(64),
  password VARCHAR(32),
  salt VARCHAR(16),
  first_name TEXT,
  last_name TEXT,
  remark TEXT
);

CREATE TABLE person(
  PRIMARY KEY(person_id)
) INHERITS(master.person);

CREATE TABLE logging.person() INHERITS(master.person);

