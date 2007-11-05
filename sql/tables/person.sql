
CREATE TABLE base.person (
  person_id SERIAL NOT NULL,
  title TEXT,
  gender BOOL,
  first_name TEXT,
  last_name TEXT,
  public_name TEXT,
  nickname TEXT,
  email TEXT,
  spam BOOL NOT NULL DEFAULT FALSE,
  address TEXT,
  street TEXT,
  street_postcode TEXT,
  po_box TEXT,
  po_box_postcode TEXT,
  city TEXT,
  country_id INTEGER,
  iban TEXT,
  bic TEXT,
  bank_name TEXT,
  account_owner TEXT
);

CREATE TABLE public.person(
  CHECK (first_name IS NOT NULL OR last_name IS NOT NULL OR public_name IS NOT NULL OR nickname IS NOT NULL),
  FOREIGN KEY (country_id) REFERENCES country (country_id) ON UPDATE CASCADE ON DELETE SET NULL,
  PRIMARY KEY (person_id)
) INHERITS( base.person );

CREATE TABLE log.person() INHERITS( base.logging, base.person );

