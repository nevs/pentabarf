
CREATE TABLE base.conflict_type (
  conflict_type TEXT
);

CREATE TABLE conflict.conflict_type (
  PRIMARY KEY (conflict_type)
) INHERITS( base.conflict_type );

CREATE TABLE log.conflict_type (
) INHERITS( base.logging, base.conflict_type );

CREATE INDEX log_conflict_type_conflict_type_idx ON log.conflict_type( conflict_type );
CREATE INDEX log_conflict_type_log_transaction_id_idx ON log.conflict_type( log_transaction_id );

