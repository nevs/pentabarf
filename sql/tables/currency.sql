
CREATE TABLE currency (
  currency_id SERIAL NOT NULL,
  iso_4217_code CHAR(3) NOT NULL UNIQUE,
  f_default BOOL NOT NULL DEFAULT FALSE,
  f_visible BOOL NOT NULL DEFAULT FALSE,
  f_preferred BOOL NOT NULL DEFAULT FALSE,
  exchange_rate DECIMAL(15,5),
  PRIMARY KEY (currency_id)
) WITHOUT OIDS;

