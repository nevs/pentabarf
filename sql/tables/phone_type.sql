
CREATE TABLE base.phone_type (
  phone_type TEXT NOT NULL,
  scheme TEXT,
  rank INTEGER
);

CREATE TABLE phone_type (
  PRIMARY KEY( phone_type )
) INHERITS( base.phone_type );

CREATE TABLE log.phone_type (
) INHERITS( base.logging, base.phone_type );

CREATE INDEX log_phone_type_phone_type_idx ON log.phone_type( phone_type );
CREATE INDEX log_phone_type_log_transaction_id_idx ON log.phone_type( log_transaction_id );

