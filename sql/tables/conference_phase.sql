
CREATE TABLE base.conference_phase (
  conference_phase TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE conference_phase (
  PRIMARY KEY (conference_phase)
) INHERITS( base.conference_phase );

CREATE TABLE log.conference_phase (
) INHERITS( base.logging, base.conference_phase );

CREATE INDEX log.conference_phase_conference_phase_idx ON log.conference_phase( conference_phase );
CREATE INDEX log.conference_phase_log_transaction_id_idx ON log.conference_phase( log_transaction_id );

