
CREATE TABLE base.conflict_level (
  conflict_level TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE conflict.conflict_level (
  PRIMARY KEY (conflict_level)
) INHERITS( base.conflict_level );

CREATE TABLE log.conflict_level (
) INHERITS( base.logging, base.conflict_level );

CREATE INDEX log.conflict_level_conflict_level_idx ON log.conflict_level( conflict_level );
CREATE INDEX log.conflict_level_log_transaction_id_idx ON log.conflict_level( log_transaction_id );

