
CREATE TABLE master.conference_phase_localized(
  conference_phase TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE conference_phase_localized(
  PRIMARY KEY(conference_phase,translated),
  FOREIGN KEY(conference_phase) REFERENCES conference_phase(conference_phase) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY(translated) REFERENCES language(language) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS(master.conference_phase_localized);

CREATE TABLE logging.conference_phase_localized() INHERITS(master.logging, master.conference_phase_localized);

