
CREATE TABLE conference_phase_localized (
  conference_phase_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  FOREIGN KEY (conference_phase_id) REFERENCES conference_phase (conference_phase_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_phase_id, language_id)
) WITHOUT OIDS;

