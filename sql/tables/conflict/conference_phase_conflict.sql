
CREATE TABLE base.conference_phase_conflict(
  conference_phase_conflict_id SERIAL NOT NULL,
  conference_phase TEXT NOT NULL,
  conflict TEXT NOT NULL,
  conflict_level TEXT NOT NULL
);

CREATE TABLE conflict.conference_phase_conflict(
  FOREIGN KEY (conference_phase) REFERENCES conference_phase (conference_phase) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (conflict) REFERENCES conflict.conflict (conflict) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (conflict_level) REFERENCES conflict.conflict_level (conflict_level) ON UPDATE CASCADE ON DELETE RESTRICT,
  UNIQUE (conference_phase, conflict),
  PRIMARY KEY (conference_phase_conflict_id)
) INHERITS( base.conference_phase_conflict );

CREATE TABLE log.conference_phase_conflict(
) INHERITS( base.logging, base.conference_phase_conflict );

