
CREATE TABLE master.conference_phase_localized(
  conference_phase TEXT,
  translated TEXT,
  name TEXT
) WITHOUT OIDS;

CREATE TABLE conference_phase_localized() INHERITS(master.conference_phase_localized);
CREATE TABLE logging.conference_phase_localized() INHERITS(master.conference_phase_localized);

