
CREATE TABLE conference_phase_conflict(
  conference_phase_conflict_id SERIAL NOT NULL,
  conference_phase TEXT NOT NULL,
  conflict_id INTEGER NOT NULL,
  conflict_level_id INTEGER NOT NULL,
  FOREIGN KEY (conference_phase) REFERENCES conference_phase (conference_phase) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (conflict_id) REFERENCES conflict (conflict_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (conflict_level_id) REFERENCES conflict_level (conflict_level_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  UNIQUE (conference_phase, conflict_id),
  PRIMARY KEY (conference_phase_conflict_id)
);

