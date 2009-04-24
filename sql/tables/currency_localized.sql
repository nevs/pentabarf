
CREATE TABLE base.currency_localized (
  currency TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE currency_localized (
  FOREIGN KEY (currency) REFERENCES currency (currency) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (currency, translated)
) INHERITS( base.currency_localized );

CREATE TABLE log.currency_localized (
) INHERITS( base.logging, base.currency_localized );

CREATE INDEX log.currency_localized_currency_idx ON log.currency_localized( currency );
CREATE INDEX log.currency_localized_log_transaction_id_idx ON log.currency_localized( log_transaction_id );

