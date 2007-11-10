
CREATE TABLE base.conference_phase_localized (
  conference_phase TEXT NOT NULL,
  translated TEXT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE conference_phase_localized (
  FOREIGN KEY (conference_phase) REFERENCES conference_phase (conference_phase) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_phase, translated)
) INHERITS( base.conference_phase_localized );

CREATE TABLE log.conference_phase_localized (
) INHERITS( base.logging, base.conference_phase_localized );

