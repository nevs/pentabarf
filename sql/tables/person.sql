
CREATE TABLE master.person(
  person_id INTEGER NOT NULL,
  login_name VARCHAR(64),
  password VARCHAR(32),
  salt VARCHAR(16),
  first_name TEXT,
  last_name TEXT,
  nickname TEXT,
  public_name TEXT,
  title TEXT,
  gender BOOL,
  email TEXT,
  spam BOOL NOT NULL DEFAULT FALSE,
  address TEXT,
  street TEXT,
  street_postcode TEXT,
  po_box TEXT,
  po_box_postcode TEXT,
  city TEXT,
  country TEXT
);

CREATE TABLE person(
  PRIMARY KEY(person_id),
  FOREIGN KEY(country) REFERENCES country(country)
) INHERITS(master.person);

CREATE TABLE logging.person() INHERITS(master.person);

CREATE SEQUENCE person_id_sequence;
ALTER TABLE person ALTER COLUMN person_id SET DEFAULT nextval('person_id_sequence');


