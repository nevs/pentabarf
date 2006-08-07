
CREATE TABLE master.conference_phase(
  conference_phase TEXT
) WITHOUT OIDS;

CREATE TABLE conference_phase() INHERITS(master.conference_phase);
CREATE TABLE logging.conference_phase() INHERITS(master.conference_phase);

